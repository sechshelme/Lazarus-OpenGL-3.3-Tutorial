# Linux
```bash
cmake ../glfw/ -DBUILD_SHARED_LIBS=ON
```


# Windows Cross-Compiler
```bash
cmake -S ../glfw/ -B . -DCMAKE_CXX_COMPILER="/usr/bin/x86_64-w64-mingw32-g++" -DCMAKE_C_COMPILER="/usr/bin/x86_64-w64-mingw32-gcc" -DCMAKE_RC_COMPILER="/usr/bin/x86_64-w64-mingw32-windres" -DCMAKE_FIND_ROOT_PATH="/usr/x86_64-w64-mingw32" -DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE="BOTH" -DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY="ONLY" -DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM="BOTH" -DCMAKE_SYSTEM_NAME="Windows" -DBUILD_SHARED_LIBS=ON
```

# Mehr Infos
https://www.glfw.org/docs/3.3/compile.html



