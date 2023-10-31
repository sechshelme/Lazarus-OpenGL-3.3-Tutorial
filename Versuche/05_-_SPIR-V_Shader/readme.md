

https://docs.vulkan.org/tutorial/latest/03_Drawing_a_triangle/03_Drawing/03_Frames_in_flight.html

# Erforderliche Tools
```
sudo apt install glslang-tools
```

# Beispiele Shader in SPRI-V unwandeln

```
glslangValidator shader.vert -S vert --target-env opengl -o vert.spv
glslangValidator shader.frag -S frag --target-env opengl -o frag.spv
```



