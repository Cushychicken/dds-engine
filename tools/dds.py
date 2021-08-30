import pandas as pd
import numpy as np
import math

class DirectDigitalSynthesis:
    def __init__(self, sample_rate, acc_depth, rom_size, bit_depth):
        self.sample_rate = sample_rate
        self.acc_depth = acc_depth
        self.rom_size = rom_size
        self.bit_depth = bit_depth
        self.phase = [ 0 ]
        self.generate_sin_rom()

    def __repr__(self):
        return(f"DDS(Fs={self.sample_rate}, acc={self.acc_depth}bits, rom={self.rom_size}, out={self.bit_depth}bits)")

    def freq_to_tuning(self, freq_out):
        """Returns the frequency tuning word for a desired frequency output 

        Keyword Arguments:
        freq_out    -- the desired output frequency
        sample_rate -- Sample rate/input clock, in Hertz (default 100MHz)
        acc_depth   -- bit depth of phase accumulator (32 bits)
        """
        return int((freq_out * (2**self.acc_depth))/self.sample_rate)

    def tuning_to_freq(self, tuning_word):
        """ Returns the frequency output for a given frequency tuning word

        Keyword Arguments:
        tuning_word -- the frequency tuning word for the DDS 
        sample_rate -- Sample rate/input clock, in Hertz (default 100MHz)
        acc_depth   -- bit depth of phase accumulator (32 bits)
        """
        return((tuning_word * self.sample_rate) / float(2 ** self.acc_depth))

    def generate_phase_array(self, tuning, length, append=True, start=0):
        """ Creates an array of phase values given a tuning word and array length
    
        Keyword Arguments:
        tuning      -- the frequency tuning word for the DDS 
        length      -- number of phase accumulator values to generate 
        append      -- set to True for subsequent calls to 
                        generate_phase_array() append to existing phase 
                        array (default True)
        start       -- starting value of phase accumulator (default 0)
        """
        if not append or (len(self.phase) != 0):
            self.phase = [ start ]

        while len(self.phase) < length:
            self.phase.append(self.phase[-1] + tuning)

    def generate_dds_frame(self, dither_output=True):
        """ Returns dds sine output from stored values in self.phase
    
        Keyword Arguments:
        dither_output   -- add phase dither to dds signal (default True)
        """
        # Programmatically generates mask to truncate all but most sig bits
        mask  = 2 ** self.acc_depth - 1
        mask  = mask - (2 ** (shift) - 1)
        shift = self.acc_depth - self.bit_depth
  
        dds_frame = np.zeros(len(self.phase))
        if dither_output:
            dither = np.random.randint(2, size=len(self.phase))
            dither = np.left_shift(dither, (shift-1))
            dds_frame = np.add(self.phase, dither)
        else:
            dds_frame = np.ndarray(self.phase)
        
        dds_frame = np.bitwise_and(dds_frame, mask)
        dds_frame = np.right_shift(dds_frame, shift)

        # Apply sin rom with lambda function (phase-to-amplitude)
        sin_lookup = lambda x: self.sin_rom[x]
        dds_frame = np.ndarray([sin_lookup(x) for x in dds_frame])
        return(dds_frame)

    def generate_dds_spectrum(self, df_phase):
        """ Returns a pandas dataframe containing spectral analysis of dds sine output 

        Keyword Arguments:
        df_phase    -- array of phase accumulator values
        """
        self.fft = np.fft.fft(self.)
        df_fft['fft_mag'] = np.abs(df_fft['raw_fft'])
        df_fft['fft_mag_scaled'] = df_fft['fft_mag'] * (2 / len(df_fft['fft_mag']))
        df_fft['fft_mag_norm'] = df_fft['fft_mag_scaled'] / float(2**(self.bit_depth))
        df_fft['fft_mag_norm'] = (20 * np.log10(df_fft['fft_mag_norm']))
        return(df_fft)

    # Returns a rom table of a signed int sine wave coefficients given a bit depth and ROM count
    def generate_sin_rom(self):
        """ Returns a sin ROM lookup table of (rom_depth) signed data entries with values (bits) wide

        #TODO: add unsigned functionality
        Keyword Arguments:
        signed      -- Set to True to generate signed values (default True)
        """
        #TODO: add unsigned functionality
        # Subtract 1 from bit depth for signed data (msb is sign bit)
        amplitude = 2**(self.bit_depth - 1)
        self.sin_rom = [int(amplitude * math.sin(a/self.rom_size * 2 * math.pi)) for a in range(self.rom_size)]

def freq_to_tuning(freq_out, sample_rate=100000000, acc_depth=32):
    """Returns the frequency tuning word for a desired frequency output 

    Keyword Arguments:
    freq_out    -- the desired output frequency
    sample_rate -- Sample rate/input clock, in Hertz (default 100MHz)
    acc_depth   -- bit depth of phase accumulator (32 bits)
    """
    return int((freq_out * (2**acc_depth))/sample_rate)

def tuning_to_freq(tuning_word, sample_rate=100000000, acc_depth=32):
    """ Returns the frequency output for a given frequency tuning word

    Keyword Arguments:
    tuning_word -- the frequency tuning word for the DDS 
    sample_rate -- Sample rate/input clock, in Hertz (default 100MHz)
    acc_depth   -- bit depth of phase accumulator (32 bits)
    """
    return (tuning_word * sample_rate) / float(2 ** acc_depth)

def generate_phase_array(tuning, length=(2**20), start=0):
    """ Returns an array of phase values given a tuning word and length
    
    Keyword Arguments:
    tuning      -- the frequency tuning word for the DDS 
    length      -- number of phase accumulator values to generate (default 2^20)
    start       -- starting value of phase accumulator (default 0)
    """
    phase = [ start ]
    while len(phase) < length:
        phase.append(phase[-1] + tuning)
    return(phase)

# Returns a rom table of a signed int sine wave coefficients given a bit depth and ROM count
def generate_sin_rom(bits, rom_depth):
    # Subtract 1 from bit depth for signed data (msb is sign bit)
    amplitude = 2**(bits-1)
    sin_rom = [int(amplitude * math.sin(a/rom_depth * 2 * math.pi)) for a in range(rom_depth)]
    return(sin_rom)

def generate_dds_frame(phase, tuning, bit_depth=12, rom_size=4096, dither_output=True):
    """ Returns a pandas dataframe containing phase, tuning, truncated phase, and dds sine output 
    
    Keyword Arguments:
    phase       -- input array of phase accumulator values
    tuning      -- the frequency tuning word for the DDS 
    bit_depth   -- bit depth of sin rom samples (default:12)
    rom_size    -- number of sin samples in ROM (default:4096) 
    """
    # Generate dataframe; add column of truncated phase
    # TODO: generalize the bitwise AND/bit shift of truncation for bit widths besides 12
    df_phase = pd.DataFrame(zip(phase, [tuning] * len(phase)), columns=['phase', 'tuning'])
    
    if dither_output:
        dither = np.random.randint(2, size=len(phase))
        dither = np.left_shift(dither, 19)
        df_phase['phase'] = np.add(df_phase['phase'], dither)
    
    df_phase['phase_trunc'] = np.bitwise_and(df_phase['phase'], 0xFFC00000)
    df_phase['phase_trunc'] = np.right_shift(df_phase['phase_trunc'], 20)

    # Generate sin rom; apply with lambda function as phase-to-amplitude conversion
    sin_rom = generate_sin_rom(bit_depth, rom_size)
    df_phase['dds_out'] = df_phase['phase_trunc'].apply(lambda x: sin_rom[x])
    return(df_phase)

def generate_dds_spectrum(df_phase, bit_depth=12):
    """ Returns a pandas dataframe containing spectral analysis of dds sine output 

    Keyword Arguments:
    df_phase    -- array of phase accumulator values
    bit_depth   -- bit depth of sin rom samples (default:12)
    """
    df_fft = pd.DataFrame(np.fft.fft(df_phase), columns=['raw_fft'])
    df_fft['fft_mag'] = np.abs(df_fft['raw_fft'])
    df_fft['fft_mag_scaled'] = df_fft['fft_mag'] * (2 / len(df_fft['fft_mag']))
    df_fft['fft_mag_norm'] = df_fft['fft_mag_scaled'] / float(2**(bit_depth))
    df_fft['fft_mag_norm'] = (20 * np.log10(df_fft['fft_mag_norm']))
    return(df_fft)


