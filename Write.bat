::Folders
set projectFolder=%cd%
set spiroFolder=%projectFolder%\tools\spiro
set extractedAssetsFolder=%projectFolder%\saydos
set extractedFileAssetsFolder=%extractedAssetsFolder%\files

set armipsFolder=%projectFolder%\tools\armips
set saydosToolFolder=%projectFolder%\tools\saydos
set compressionToolFolder=%projectFolder%\tools\compression

set saydosFiles=%extractedAssetsFolder%\files

::Compression
set uncompressedOldPath=%projectFolder%\graphics\uncompressed (original)
set uncompressedNewPath=%projectFolder%\graphics\uncompressed (new)
set compressedNewPath=%projectFolder%\graphics\compressed (new)

::Roms
set baseImage=%projectFolder%\roms\Final Fantasy (1989)(Micro Cabin)(jp)(Disk 1 of 2)(Game Disk).dsk
set newImage=%projectFolder%\roms\Final Fantasy (NEW).dsk

cd "%projectFolder%"

del "%newImage%"
copy "%baseImage%" "%newImage%"

::Extract file and sectors from disk image
"%saydosToolFolder%\SayDos.exe" "Dump" "%baseImage%" "%extractedAssetsFolder%"

::Write script
"%spiroFolder%\Spiro.exe" /ProjectDirectory "%projectFolder%" /Write /Verbose

::Add compressed graphics
"%compressionToolFolder%\FF MSX GFX.exe" Write "%uncompressedNewPath%\FONT.bin" "%saydosFiles%\FONT.PIC"
"%compressionToolFolder%\FF MSX GFX.exe" Write "%uncompressedNewPath%\OPMSG.bin" "%saydosFiles%\OPMSG.PIC"
"%compressionToolFolder%\FF MSX GFX.exe" Write "%uncompressedNewPath%\OPENGRP.bin" "%saydosFiles%\OPENGRP.PIC"

::Armips scripts
"%armipsFolder%\armips.exe" "%projectFolder%\asm\main.asm"

"%saydosToolFolder%\SayDos.exe" "Write" "%newImage%" "%extractedAssetsFolder%"

"%newImage%"
@pause