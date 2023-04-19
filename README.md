[//]: <> (This readme is in the markdown format. Please preview in a markdown parser.)

#  Final Fantasy MSX2: English Translation

## About
This repository contains source code for patches and tools to compile an English translation of Final Fantasy for the MSX2.

## Folders
* asm
	* Contains the asm files which are to be compiled with the armips fork that supports Z80.
* roms
	* Use this to store your ~~roms~~ disk images
    * Please place a Japanese disk image titled `Final Fantasy (1989)(Micro Cabin)(jp)(Disk 1 of 2)(Game Disk).dsk`.
* script
	* Contains the dump script in `Script.json`. It contains the Japanese script and the English translation.
	* You can also store xlsx backups of the script here.
* tables
	* Contains table files
		* Files prefixed with "CHR" specify byte to character mapping for the most of the script.
		* Files prefixed with "BIOS" specified the BIOS fontset. The game uses it for the boot screen and disk fomatting screen.
		* Files prefixed with "Dictionary" specify dictionary mapping. A dictionary can be mapped to multiple character values.
		* Files prefixed with "FindAndReplace" do some find and replace functions for things like squishy text.
* `graphics
	* Where compressed data is managed
	* Subfolder `uncompressed (new)` is where uncompressed custom translated assets are stored.
	* Subfolder `uncompressed (original)` is where the original uncompressed assets dumped from the disk image are stored.
* tools
	* cyproAce
		* A script editor 
	* spiro
		* Script dumper and inserter
	* armips
		* A fork of armips that supports z80 assembly language patches.
	* compression
		* [The (de)compressor.](https://github.com/romh-acking/final-fantasy-msx2-de-compressor)
	* saydos
		* [The file and sector extractor and disk image creation tool.](https://github.com/romh-acking/final-fantasy-msx2-say-dos-tool)

## Manual
Check out the repo [final-fantasy-msx2-en-manual](https://github.com/romh-acking/final-fantasy-msx2-en-manual) for manual resources.

## Instructions
The tools are coded in C#. You'll have to mess with Wine if you want them to run in Linux. You'll also have to rewrite the bat files, which aren't complicated at all.

* If you want to dump the script for whatever reason (the Japanese and English script are already included in this repository), you can dump it by executing the bat file "Dump.bat" by double clicking it.
* To generate a disk image file with the translation and patches included execute the bat file "Write.bat" by double clicking it.

## Changelog
* 2023 March 25th: 1.0
    * Initial release

## Credits

### Main Team
* FCandChill
    * ASM hacking
    * Utilities
    * Manual
* Her-saki
    * Manual translation
* TheMajinZenki
    * Manual translation

### Support
* Quibus#2625
* TFH|Fony#1064 

### Beta Testers
* Morhamms357#3536
* BigFive#4043
* Sylver#7257
* ArjanBakker#8999
* Creepy#3091
* PeachPie#4994
* xboxown#7869
