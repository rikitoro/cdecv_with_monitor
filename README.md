# CDEC v
Yet another CEDC, CDEC voyager!

# What is CDEC v ?
CDEC v is a very simple 8-bit CPU architecture, micro-architecture,
and its implementation on the FPGA board DE0-CV.

CDEC v is a variant version of CDEC, Comuter Design Education Comuter,
which is originally developed by 
Prof. S. Kimura (Gunma College, National Institute of Technology) and
Prof. A. Kanomata (Sendai College, National Institute of Technoloy).

CDEC v has following features.

- 8-bit architecture CPU
- Very simple but good capable instruction set architecture
- Also very simple micro-architecture (only one data bus in the datapath unit)
- You can trace all data transter steps in the datapath unit
- You can implement your new original instructions, by hacking the controller unit (It's not so difficult!)
- Suitable for entry level education of comupter architecture


# Instruction Set Architecture of CDEC v
CDEC v is defined to be a 8-bit CPU architecture consisting of following register set, memory, and standard instructions.

## register set 

| register | purpose                |
|----------|------------------------|
| PC       | program counter        |
| A        |general purpose register|
| B        |general purpose register|
| C        |general purpose register|
| FLG      |flag register           |

FLG = {4'bxxxx, S, Z, Cy, 1'bx}, where S, Z, and Cy are sign, zero, and carry flag bit, respectively. 

## memory

CDEC v has a 256-byte memory. Address 0x00 ~ 0xFE are RAM area, and $0xFF is 8-bit I/O port.

| address     | memory            |
|-------------|-------------------|
|`$0x00-$0xFE`| RAM (255 words)   |
|`$0xFF      `| I/O port (8 bit)  |
1 word = 1 byte = 8 bit

## statndard instructions

| mnemonic       | machine code  | flag | behavioral description |
|----------------|---------------|:----:|------------------------|
|`MOV sreg, dreg`|`000xssdd`     |  --  | dreg <- sreg           |
|`LD  adrs, dreg`|`100xxxdd adrs`|  --  | dreg <- MEM[adrs]      |
|`ST  sreg, adrs`|`101xssxx adrs`|  --  | MEM[adrs] <- sreg      |
|`ADD reg       `|`001000rr`     |  @   | A <- A + reg           |
|`ADC reg       `|`001001rr`     |  @   | A <- A + reg + Cy      |
|`SUB reg       `|`001010rr`     |  @   | A <- A - reg           |
|`SBB reg       `|`001011rr`     |  @   | A <- A - reg - Cy      |
|`AND reg       `|`001100rr`     |  @   | A <- A & reg           |
|`OR  reg       `|`001101rr`     |  @   | A <- A \| reg          |
|`EOR reg       `|`001111rr`     |  @   | A <- A ^ reg           |
|`INC reg       `|`010000rr`     |  @   | reg <- reg + 1         |
|`DEC reg       `|`010001rr`     |  @   | reg <- reg - 1         |
|`NOR reg       `|`010100rr`     |  @   | reg <- ~reg            |
|`JMP adrs      `|`110xxx00 adrs`|  --  | PC <- adrs             |
|`JS adrs       `|`111100xx adrs`|  --  | PC <- adrs if (S == 1) |
|`JZ adrs       `|`111010xx adrs`|  --  | PC <- adrs if (Z == 1) |
|`JC adrs       `|`111001xx adrs`|  --  | PC <- adrs if (Cy == 1)|

Let x in machine code be 0 for future extensions.

@ means that the flag bits(S, Z, Xy) may be changed
depending on the result of the operation.

ss, dd, and rr in machine code are defined as follows.

| reg/sreg/dreg | rr/ss/dd |
|:-------------:|:--------:|
| A             |`01`      | 
| B             |`10`      |
| C             |`11`      |

## sample program

Following program counts the number of bit '1' in
the 8-bit data stored at the memory address 0xFF (I port),
and outputs the result at the memory address 0x1F and 0xFF (O port).

``` [bitcount.asm]
        ORG   0x00          ; adrs     code
        LD    ZERO, B       ;  00     82  14
        LD    0xFF, A       ;  02     81  FF
LOOP:   ADD   A             ;  04     21
        JC    COUNT         ;  05     E4  0B
        JZ    STORE         ;  07     E8  0E
        JMP   LOOP          ;  09     C0  04
COUNT:  INC   B             ;  0B     42
        JMP   LOOP          ;  0C     C0  04
STORE:  ST    B   , 0xFF    ;  0E     A8  FF
        ST    B   , RSLT    ;  10     A8  1F
        HALT                ;  12     FF
;
        ORG   0x14
ZERO:   DB    0x00          ;  14     04
;
        ORG   0x1F
RSLT:   DB    0x00          ;  1F     00

; HEX format
; :10000000821481FF21E40BE80EC00442C004A8FF63
; :10001000A814FF0000000000000000000000000025
; :00000001FF
```
