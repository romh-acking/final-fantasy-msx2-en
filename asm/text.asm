DTEStart 		equ 0xBF
MBRLocation 	equ 0xF351
Temp 			equ 0xf410
DTEMin 			equ 0x1A

////////////////////////////////////////////////
// Startup menu alignment
////////////////////////////////////////////////

.open ".\saydos\files\STARTUP.COM",0
// Continue
.org 0x0000025E
	ld hl,0x0001

// New game
.org 0x00000271
	ld hl,0x0001

// Response rate
.org 0x00000284
	ld hl,0x0001
	
.org 0x30b	
	db 0xD
.close

////////////////////////////////////////////////
// Intro
////////////////////////////////////////////////

// Extend the amount of lines / palette changes
.open ".\saydos\files\STARTUP.COM",0
.org 0x000001D6
	ld b,0x0C
.close

////////////////////////////////////////////////
// Battle hits
////////////////////////////////////////////////

.loadtable ".\asm\CHR - New.tbl"

.open ".\saydos\files\BATTLE.COM",0
.org 0x00001746
	.strn "Hits!",0x00
.close

////////////////////////////////////////////////
// Adjust "perished" placement after defeating enemies
////////////////////////////////////////////////

.open ".\saydos\files\BATTLE.COM",0

org 0x00000561
	ld hl,0x0900
.close

////////////////////////////////////////////////
// Shops
////////////////////////////////////////////////
.open ".\saydos\files\SMAP.COM",0
// Gil
.org 0x00002994
	.strn " G"
	
.org 0x00002A2D
	.strn "L"
	
.close

////////////////////////////////////////////////
// Weapon select
////////////////////////////////////////////////
.open ".\saydos\files\MENU.COM",0

.org 0x00000A31
	.strn "E-"
.close
	
////////////////////////////////////////////////
// DTE
////////////////////////////////////////////////

.open ".\saydos\files\MAIN.COM",0

.headersize 0x0
org 0x00002726
	.headersize 0x6726-0x00002726
	ld a,(ix)
	or a
	jr z,0x6742
	cp DTEMin

// Old datkuten code blanked to create a code cave
.headersize 0x0
org 0x000027B9
	.fill 0x45
org 0x000027B9
	.headersize 0x67B9-0x000027B9
	
	DTEPrint:
	// Check if within DTE table range
	cp DTEMin
	jr c,LessThan
	cp 0x80
	jp nc,GreaterThan
	
	// Setup indexer
	sub DTEMin
	add a,a
	
	push af
	pop hl
	
	ld l,h
	ld h,0x0
	
	// 0xF351 stores where the MBR is located in RAM
	// DTE table maps values 1A through 6F
	// Must be at the end of the MBR code
	// 0xBF is where the table is written, relative
	// to the start of the MBR
	ld bc,(0xF351)
	add hl,bc
	ld bc,0xBF
	add hl,bc
	
	// Print the first character in the DTE entry
	ld a,(hl)
	call 0x67ff
	call DifferingFunction
	call 0x679c
	
	inc hl
	
	// Return, which will print the next character
	// The same 3 functions calls above are called after this function as well.
	ld a,(hl)
	
	GreaterThan:
	LessThan:
	ret
	
	DTEPrintBattle:	
	ld hl,0x01
	ld (Temp),hl
	call DTEPrint
	ld hl,0x00
	ld (Temp),hl
	ret
	
	DifferingFunction:
	ld de,(Temp)
	jr c,DifferingFunctionA
	call 0x6826
	ret
	
	DifferingFunctionA:
	call 0xA280
	ret
.headersize 0x0

org 0x00002A04
	jp 0x6A12
.close

.open ".\saydos\files\BATTLE.COM",0
	.org 0x00002248
	.headersize 0xA248-0x00002248
	call DTEPrintBattle
	
	.headersize 0x0
	.org 0x00002244
		cp DTEMin
	
.close

////////////////////////////////////////////////
// Name selection
////////////////////////////////////////////////

.open ".\saydos\files\STARTUP.COM",0

// Prevent the last two rows from being selected
// Like in the NES version's translation
org 0x00000632
	cp 0x07
org 0x00000629
	ld  l,0x06
	
// Name selection: input text table
org 0x00000C59
	.strn "ABCDEFGHIJ"
	.strn "KLMNOPQRST"
	.strn "UVWXYZ',. " 
	.strn "0123456789"
	.strn "abcdefghij"
	.strn "klmnopqrst"
	.strn "uvwxyz-",0xC5,"!?"
.close

////////////////////////////////////////////////
// Party perish
////////////////////////////////////////////////

// Move perish string to the right
.open ".\saydos\files\BATTLE.COM",0
org 0x00000473
	ld hl,0x0B00
.close
