# CDEC v (variant or voyager)
- Yet Another CDEC(Computer Design Education Computer) by Dr. S. Kimura and Dr. A. Kanomata

# Architecture
CDEC v is defined to be a 8-bit CPU architecture consisting of following register set, memory, and instructions.

## register set 

| register | purpose                |
|----------|------------------------|
| PC       | program counter        |
| A        |general purpose register|
| B        |general purpose register|
| C        |general purpose register|
| FLG      |flag register           |

FLG = {4'b0000, S, Z, Cy, 1'b0}, where S, Z, and Cy are sign, zero, and carry flag, respectively. 

## memory

CDEC v has 256 byte memory. Address 0x00 ~ 0xFE are RAM area, and $0xFF is 8-bit I/O port.

| address     | memory               |
|-------------|----------------------|
|`$0x00-$0xFE`| RAM (1 word = 8 bit) |
|`$0xFF      `| I/O port (8 bit)     |

## instructions

| mnemonic       | machime code      | flag | behavioral description |
|----------------|-------------------|:----:|------------------------|
|`MOV sreg, dreg`|`000xssdd --------`|  --  | dreg <- sreg           |
|`LD  adrs, dreg`|`100xxxdd adrs    `|  --  | dreg <- MEM[adrs]      |
|`ST  sreg, adrs`|`101xssxx adrs    `|  --  | MEM[adrs] <- sreg      |
|`ADD reg       `|`001000rr --------`|  @   | A <- A + reg           |
|`ADC reg       `|`001001rr --------`|  @   | A <- A + reg + Cy      |
|`SUB reg       `|`001010rr --------`|  @   | A <- A - reg           |
|`SBB reg       `|`001011rr --------`|  @   | A <- A - reg - Cy      |
|`AND reg       `|`001100rr --------`|  @   | A <- A & reg           |
|`OR  reg       `|`001101rr --------`|  @   | A <- A \| reg          |
|`EOR reg       `|`001111rr --------`|  @   | A <- A ^ reg           |
|`INC reg       `|`010000rr --------`|  @   | reg <- reg + 1         |
|`DEC reg       `|`010001rr --------`|  @   | reg <- reg - 1         |
|`NOR reg       `|`010100rr --------`|  @   | reg <- ~reg            |
|`JMP adrs      `|`110xxx00 adrs    `|  --  | PC <- adrs             |
|`JS adrs       `|`111100xx adrs    `|  --  | PC <- adrs if (S == 1) |
|`JZ adrs       `|`111010xx adrs    `|  --  | PC <- adrs if (Z == 1) |
|`JC adrs       `|`111001xx adrs    `|  --  | PC <- adrs if (Cy == 1)|

Let x in machine code be 0 for future extensions.

ss, dd, and rr in machine code are defined as follows.

| reg/sreg/dreg | rr/ss/dd |
|:-------------:|:--------:|
| A             |`01`     | 
| B             |`10`      |
| C             |`11`      |
