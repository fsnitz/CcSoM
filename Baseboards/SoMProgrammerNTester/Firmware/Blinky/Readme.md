# Usage

## Terminal Based
Follow the guide if you have not already installed the tools: https://www.colognechip.com/docs/ug1002-toolchain-install-latest.pdf.

If you have already installed yosys and p_r or downloaded them from Cologne Chip, simply execute the following commands:

```bash
mkdir net

yosys -lyosys.log -p 'ghdl --warn-no-binding -C --ieee=synopsys SoM.vhd -e SoM;synth_gatemate -top SoM-vlog net/SoM_synth.v'

p_r -i net/SoM_synth.v -o SoM -ccf blink.ccf > log/impl.log

openFPGALoader-b gatemate_evb_jtag SoM_00.cfg.bit

```

## OneWare

tbd.