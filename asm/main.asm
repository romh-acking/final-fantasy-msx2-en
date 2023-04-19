.z80

//Format hex to ASM db thing
//Find: [0-9A-Z][0-9A-Z]
//Replace: ,\$$&
//Replace example: xxxxxxxxx$&xxxxxxxxx

// Remove metadata from script dump
//                   "metadata": \{\r\n.*\r\n.*\r\n.*\r\n.*\r\n                  \},*\r\n

.include ".\asm\gfx.asm"
.include ".\asm\text.asm"

.open ".\saydos\sectors\0000.bin",0
	.org 0x18B
	.ascii "Translation by FCandChill and friends."
.close