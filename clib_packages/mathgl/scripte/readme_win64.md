https://mathgl.sourceforge.net/
https://mathgl.sourceforge.net/doc_en/Download.html#Download
https://sourceforge.net/projects/mathgl/files/mathgl/mathgl%208.0/mathgl-8.0.1.tar.gz/download?use_mirror=deac-fra




```bash
mkdir build_win64
cd build_win64
cmake -S ../mathgl-8.0.1/ -B . \
  --install-prefix ~/win64_local\
  -DCMAKE_CXX_COMPILER="/usr/bin/x86_64-w64-mingw32-g++" \
  -DCMAKE_C_COMPILER="/usr/bin/x86_64-w64-mingw32-gcc" \
  -DCMAKE_RC_COMPILER="/usr/bin/x86_64-w64-mingw32-windres" \
  -DCMAKE_FIND_ROOT_PATH="/usr/x86_64-w64-mingw32" \
  -DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE="BOTH" \
  -DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY="ONLY" \
  -DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM="BOTH" \
  -DCMAKE_SYSTEM_NAME="Windows" \
  -DFREETYPE_INCLUDE_DIR_freetype2="~/win64_local/include/freetype2" \
  -DFREETYPE_INCLUDE_DIR_ft2build="~/win64_local/include/freetype2"
make -j16
sudo make install
cd ../..

