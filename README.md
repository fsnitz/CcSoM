# CcSoM
<img width="996" alt="Screenshot 2024-12-20 at 3 45 26 PM" src="https://github.com/user-attachments/assets/f41803c0-8ab7-4e95-b333-6015812fb324" />

## Description
CcSoM is a credit card-sized System on Module built around the GateMate FPGA from Cologne Chip. It is designed to accommodate the CCGM1A1 and CCGM1A2 FPGAs with all their features. 
This repository contains all the necessary design files to fabricate and further develop the SoM itself or an application specific baseboard for it. 
A simple IO tester and programmer baseboard can be found in the [Baseboards](Baseboards) folder.
The [Library](Library) folder contains a symbol and footprint to simplify the process of creating a new baseboard. 
Each board folder includes a PDF version of the board and schematics, as well as an interactive HTML BOM.

## Features: 
  - Choose the IO-Bank supply voltage for each IO-Bank freely within the capability of the GateMate FPGA (default 2.5V).
  - All IOs are routed to the SODIMM-connector and can be accessed either as single-ended signal or as differential pair with its designated partner IO.
  - Configuration of the FPGA is possible over JTAG or the on-board QSPI-Flash.

## Manufacturing notes
- The SoM is designed for JLCPCBs "JLC0610H-3313" layer stack and with vias in pads. If a different manufacturer is chosen, it is advisable to either reroute all differential lines or to find a manufacturer where the layer stack can be specified.
- Most of the resistors and capacitors have a 0201 footprint, which may complicate the manufacturing process. 

## Author
Felix Sebastian Nitz

## Acknowledgment
A special thanks to Cologne chip and its employees for their feedback on the design and FPGA samples.

## License
This project falls under the open hardware licence agreement.

## Project status
- SoM revision 1.0 is currently tested with the CCGM1A1 FPGA. Beginning of 2025 an evaluation of its capabilities with an CCGM1A2 will follow.
- A version of the SoM with a 0402 footprint can be found under its designated Tag [0402 Version](https://github.com/fsnitz/CcSoM/tree/VersionWith0402Components).
