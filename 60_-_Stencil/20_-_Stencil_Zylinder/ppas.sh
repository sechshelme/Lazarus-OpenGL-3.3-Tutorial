#!/bin/sh
DoExitAsm ()
{ echo "An error occurred while assembling $1"; exit 1; }
DoExitLink ()
{ echo "An error occurred while linking $1"; exit 1; }
echo Assembling project1
/usr/bin/as --64 -o /tmp/project1.o   /tmp/project1.s
if [ $? != 0 ]; then DoExitAsm project1; fi
rm /tmp/project1.s
echo Linking /n4800/DATEN/Programmierung/mit_GIT/Lazarus/Tutorial/OpenGL_3.3/60_-_Stencil/20_-_Stencil_Zylinder/project1
OFS=$IFS
IFS="
"
/usr/bin/ld.bfd -b elf64-x86-64 -m elf_x86_64  --dynamic-linker=/lib64/ld-linux-x86-64.so.2   -s    -L. -o /n4800/DATEN/Programmierung/mit_GIT/Lazarus/Tutorial/OpenGL_3.3/60_-_Stencil/20_-_Stencil_Zylinder/project1 -T /n4800/DATEN/Programmierung/mit_GIT/Lazarus/Tutorial/OpenGL_3.3/60_-_Stencil/20_-_Stencil_Zylinder/link8294.res -e _start
if [ $? != 0 ]; then DoExitLink /n4800/DATEN/Programmierung/mit_GIT/Lazarus/Tutorial/OpenGL_3.3/60_-_Stencil/20_-_Stencil_Zylinder/project1; fi
IFS=$OFS
