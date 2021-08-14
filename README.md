# dds-engine
Direct digital synthesis engine in VHDL

I'm using the `nvc` compiler. Visualizations are done using GTKwave. 

Build and run a testbench like so:

```vhdl
nvc -a src/phase_accum.vhd testbenches/test_phase_accum.vhd -e test_phase_accum -r -w
```
