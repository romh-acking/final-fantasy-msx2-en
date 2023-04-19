LineGFXDistance				equ 0x08
LineHeightDistance			equ 0x0d

LineStartRow				equ 0x030D

LineCount					equ 0x0d

////////////////////////////////////////////////
// OPMSG pal
////////////////////////////////////////////////

.open ".\saydos\files\OPMSG.PIC",0

// Palette
.org 0x10
	db 0x00,0x03
	db 0x00,0x00
	db 0x24,0x03
	db 0x77,0x07
	db 0x24,0x03
	db 0x24,0x03
	db 0x24,0x03
	db 0x24,0x03
	db 0x24,0x03
	db 0x24,0x03
	db 0x24,0x03
	db 0x24,0x03
	db 0x24,0x03
	db 0x24,0x03
	db 0x24,0x03
	db 0x24,0x03

org 0x8
		db 0x6A
.close


////////////////////////////////////////////////
// Adjust intro gfx text printing
////////////////////////////////////////////////

.open ".\saydos\files\STARTUP.COM",0

org 0x000000B2
	.fill 0x10E

org 0x000000B2
	.headersize 0x000080B2-0x000000B2
	
	// These will never change
	ld hl,0x0000
	ld (0xdc06),hl
	ld hl,0x0008
	ld (0xdc0a),hl
	ld hl,0x00f0
	ld (0xdc0e),hl
	ld hl,0x0008
	ld (0xdc10),hl
	
	// Variable
	ld hl,0x0200-LineGFXDistance
	ld (0xdc08),hl
	ld hl,LineStartRow-LineHeightDistance
	ld (0xdc0c),hl
	
	ld b,LineCount
	
	IntroLoop:
	
		ld hl,(0xdc08)
		ld de,LineGFXDistance
		add hl,de
		ld (0xdc08),hl
		
		ld hl,(0xdc0c)
		ld de,LineHeightDistance
		add hl,de
		ld (0xdc0c),hl
		call 0x7025
		
		dec b
		jp nz,IntroLoop
.close