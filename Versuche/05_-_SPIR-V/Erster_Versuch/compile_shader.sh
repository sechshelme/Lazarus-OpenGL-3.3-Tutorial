# glslangValidator shader.vert -S vert --target-env vulkan1.2 -o vert.spv
# glslangValidator shader.frag -S frag --target-env vulkan1.2 -o frag.spv
# glslangValidator shader.vert -S vert --target-env vulkan1.0 -o vert.spv
# glslangValidator shader.frag -S frag --target-env vulkan1.0 -o frag.spv
# glslangValidator shader.vert -S vert --target-env opengl -o vert.spv
# glslangValidator shader.frag -S frag --target-env opengl -o frag.spv
glslc -o vert.spv shader.vert
glslc -o frag.spv shader.frag 

