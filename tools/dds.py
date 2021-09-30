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
        shift = self.acc_depth - self.bit_depth
        mask  = 2 ** self.acc_depth - 1
        mask  = mask - (2 ** (shift) - 1)
  
        dds_frame = np.zeros(len(self.phase))
        if dither_output:
            dither = np.random.randint(2, size=len(self.phase))
            dither = np.left_shift(dither, (shift-1))
            dds_frame = np.add(self.phase, dither)
        else:
            dds_frame = np.array(self.phase)
        
        dds_frame = np.bitwise_and(dds_frame, mask)
        self.phase_trunc = np.right_shift(dds_frame, shift)

        # Apply sin rom with lambda function (phase-to-amplitude)
        sin_lookup = lambda x: self.sin_rom[x]
        self.dds_out = np.array([sin_lookup(x) for x in self.phase_trunc])
        return(self.dds_out)

    def generate_dds_spectrum(self, window='rectangular', n=(2**18)):
        """ Returns a pandas dataframe containing spectral analysis of dds sine output 

        Keyword Arguments:
        window      -- type of window to apply to data (default None/rectangualr)
        """
        options = [ 'rectangular', 'hamming', 'hann', 'blackman' ]
        if window not in options:
            errstring = 'Unknown window type {window}; available options are: {options}'
            raise ValueError(errstring.format(window=window, options=", ".join(options)))

        # All ones == rectangular window (aka no windowing)
        arr_window = np.ones(len(self.phase))
        if window == 'hamming':
            arr_window = np.hamming(len(self.phase))
        elif window == 'hann':
            arr_window = np.hanning(len(self.phase))
        elif window == 'blackman':
            arr_window = np.blackman(len(self.phase))

        self.fft = np.fft.fft(np.multiply(self.dds_out, arr_window), n=n)
        self.fft_mag = np.abs(self.fft)
        self.fft_mag = self.fft_mag * (2 / len(self.fft_mag))
        self.fft_mag = self.fft_mag / float(2**(self.bit_depth))
        self.fft_log_mag = (20 * np.log10(self.fft_mag))
        return(self.fft_log_mag)

    def generate_sin_rom(self, signed=True):
        """ Returns a sin ROM lookup table of (rom_depth) signed data entries with values (bits) wide

        #TODO: add unsigned functionality
        Keyword Arguments:
        signed      -- Set to True to generate signed values (default True)
        """
        #TODO: add unsigned functionality
        # Subtract 1 from bit depth for signed data (msb is sign bit)
        amplitude = 2**(self.bit_depth - 1)
            
        self.sin_rom = [int(amplitude * math.sin(a/self.rom_size * 2 * math.pi)) for a in range(self.rom_size)]

    def generate_ook_mod(self, tx_data, t_symbol, freq_map, length, retrans=False):
        """ Returns a modulated OOK bitstream 

        Keyword Arguments:
        tx_data  -- np.array of bits to transmit
        t_symbol -- int; number of samples per symbol (aka baudrate)
        freq_map -- np.array of frequencies to encode bitstream values as
        length   -- int; length of phase array, in samples
        retrans  -- boolean; repeats encoding of tx_data bitstream onto 
                    carrier from the start of the bitstream until 
                    len(phase) == length (default False)

        """
        freqs = [ self.freq_to_tuning(freq) for freq in freq_map ]
        freqs[0] = 0 # Zero because '0' is equivalent to 'off' keying
        tuning_word_map = np.array(freqs)
        tuning_word_list = tuning_word_map[tx_data]
        for word in tuning_word_list:
            self.phase = self.generate_phase_array(word, t_symbol)
        return(self.phase)


