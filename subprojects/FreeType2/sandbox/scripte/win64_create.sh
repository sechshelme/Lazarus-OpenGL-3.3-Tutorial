git clone https://github.com/freetype/freetype.git
echo [binaries] > win64cross.tmp
echo c = \'"x86_64-w64-mingw32-gcc'" >> win64cross.tmp
echo cpp = \'"x86_64-w64-mingw32-g++'" >> win64cross.tmp
echo ar = \'"x86_64-w64-mingw32-ar'" >> win64cross.tmp
echo strip = \'"x86_64-w64-mingw32-strip'" >> win64cross.tmp
echo exe_wrapper = \'"wine64'" >> win64cross.tmp
echo windres = \'"x86_64-w64-mingw32-windres'" >> win64cross.tmp
echo >> win64cross.tmp
echo [host_machine] >> win64cross.tmp
echo system = \'"windows'" >> win64cross.tmp
echo cpu_family = \'"x86_64'" >> win64cross.tmp
echo cpu = \'"x86_64'" >> win64cross.tmp
echo endian = \'"little'" >> win64cross.tmp 
mkdir build_win64
cd build_win64
meson setup --cross-file ../win64cross.tmp --buildtype=debugoptimized --strip -Db_ndebug=true  ../freetype/
ninja -j16
sudo ninja install
cd ..
rm win64cross.tmp

