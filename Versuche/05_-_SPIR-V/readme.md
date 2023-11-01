

https://docs.vulkan.org/tutorial/latest/03_Drawing_a_triangle/03_Drawing/03_Frames_in_flight.html

# Erforderliche Tools
```
sudo apt install glslang-tools
```

## Beispiele Shader in SPRI-V unwandeln

```
glslangValidator shader.vert -S vert --target-env opengl -o vert.spv
glslangValidator shader.frag -S frag --target-env opengl -o frag.spv
```


# Für glslc
https://vulkan.lunarg.com/sdk/home
https://packages.lunarg.com/#

```
wget -qO- https://packages.lunarg.com/lunarg-signing-key-pub.asc | sudo tee /etc/apt/trusted.gpg.d/lunarg.asc
sudo wget -qO /etc/apt/sources.list.d/lunarg-vulkan-jammy.list https://packages.lunarg.com/vulkan/lunarg-vulkan-jammy.list
sudo apt update
sudo apt install vulkan-sdk
```

## Beispiele Shader in SPRI-V unwandeln
```
glslc -o vert.spv shader.vert
glslc -o frag.spv shader.frag 
```

# Tutorials
https://www.neilhenning.dev/wp-content/uploads/2015/03/AnIntroductionToSPIR-V.pdf





