# dds-engine
Direct digital synthesis engine in VHDL

I'm using the `nvc` compiler. Visualizations are done using GTKwave. 

Build and run a testbench like so:

```vhdl
nvc -a src/phase_accum.vhd test/test_phase_accum.vhd -e test_phase_accum -r -w
```

I'm using Jeremiah Learly's [VHDL style guide package](https://github.com/jeremiah-c-leary/vhdl-style-guide) for source formatting. Get a source formatting report like so: 

```vhdl
vsg -f src/sin_rom_10bits_1024words.vhd 
```

Or append the `--fix` flag to rewrite in place and apply rules:: 

```vhdl
vsg -f src/sin_rom_10bits_1024words.vhd --fix
```
