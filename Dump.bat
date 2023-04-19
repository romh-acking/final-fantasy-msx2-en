::Folders
set projectFolder=%cd%
set extractedAssetsFolder=%projectFolder%\saydos
set extractedFileAssetsFolder=%extractedAssetsFolder%\files

set spiroFolder=%projectFolder%\tools\spiro
set saydosToolFolder=%projectFolder%\tools\saydos

::Roms
set baseImage=%projectFolder%\roms\Final Fantasy (1989)(Micro Cabin)(jp)(Disk 1 of 2)(Game Disk).dsk

::Compression
set uncompressedOldPath=%projectFolder%\graphics\uncompressed (original)
set compressionToolFolder=%projectFolder%\tools\compression

cd "%projectFolder%"

::Extract file and sectors from disk image
"%saydosToolFolder%\SayDos.exe" "Dump" "%baseImage%" "%extractedAssetsFolder%"

::Compression
del "%uncompressedOldPath%\*.bin"
"%compressionToolFolder%\FF MSX GFX.exe" Dump "0x0" "%extractedFileAssetsFolder%\FONT.PIC" "%uncompressedOldPath%\FONT.bin"
"%compressionToolFolder%\FF MSX GFX.exe" Dump "0x0" "%extractedFileAssetsFolder%\OPMSG.PIC" "%uncompressedOldPath%\OPMSG.bin"
"%compressionToolFolder%\FF MSX GFX.exe" Dump "0x0" "%extractedFileAssetsFolder%\OPENGRP.PIC" "%uncompressedOldPath%\OPENGRP.bin"

::Dump script
"%spiroFolder%\Spiro.exe" /ProjectDirectory "%projectFolder%" /DumpScript /Verbose
@pause