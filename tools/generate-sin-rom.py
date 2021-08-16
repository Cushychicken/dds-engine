import math

# Sin Table bit depth
bitdepth = 10
bits = 2 ** bitdepth

# Sin Table entry count
N = 1024

# Helper function to make table generation more readable
def sin_value(bits, n, N):
    return int(bits * math.sin((float(n) / float(N)) * (math.pi / 2.0))) 

# Generate sin table in str format to print 
sin_table = [ sin_value(bits, n, N) for n in range(N) ]

sinrom_template = ''
with open("src/template_sin_rom.vhd") as f:
    sinrom_template = f.read()

coeff = [ f'{index} => "{data:012b}"' for index, data in enumerate(sin_table)]

filename = f"src/sin_rom_{bitdepth}bits_{N}words.vhd"
with open(filename, 'w') as f:
    coeff = ",\n".join(coeff)
    sinrom_template = sinrom_template.format(sintable=coeff)
    f.write(sinrom_template)
    f.close()


