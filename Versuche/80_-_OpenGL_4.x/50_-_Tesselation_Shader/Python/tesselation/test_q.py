import inspect, glfw, numpy
from OpenGL.GL import *
from OpenGL.GL import shaders

glfw.init()
tile_size = 88
tile_count = 8
width = tile_size * tile_count
glfw.window_hint(glfw.SAMPLES, 16)
window = glfw.create_window(width, width, 'tessellation demo', None, None)
glfw.make_context_current(window)
glBindVertexArray(glGenVertexArrays(1))
triangle = numpy.array([
    [-0.9, -0.9, 0.5],  # lower left
    [ 0.9, -0.9, 0.5],  # lower right
    [ 0.9,  0.5, 0.5],  # top
    [-0.9,  0.5, 0.5],  # top
], dtype=numpy.float32)
glBindBuffer(GL_ARRAY_BUFFER, glGenBuffers(1))
glBufferData(GL_ARRAY_BUFFER, triangle, GL_STATIC_DRAW)
glEnableVertexAttribArray(0)
glVertexAttribPointer(index=0, size=3, type=GL_FLOAT, normalized=False, stride=0, pointer=None)
program = shaders.compileProgram(
    shaders.compileShader(source=inspect.cleandoc('''
        #version 460 core
        in vec3 aPos;
        void main() {
            gl_Position = vec4(aPos, 1);
        }
    '''), shaderType=GL_VERTEX_SHADER),
    # Tessellation control shader not defined here because default is OK.
    shaders.compileShader(source=inspect.cleandoc('''
        #version 460 core
        layout(quads) in;
        void main() {
            gl_Position = (gl_TessCoord[0] * gl_in[0].gl_Position) +
                          (gl_TessCoord[1] * gl_in[1].gl_Position) +
                          (gl_TessCoord[2] * gl_in[2].gl_Position);
        }
    '''), shaderType=GL_TESS_EVALUATION_SHADER),
    shaders.compileShader(source=inspect.cleandoc('''
        #version 460 core
        out vec4 fragColor;
        void main() {
            fragColor = vec4(1, 0,0, 1);  // dark gray
        }
    '''), shaderType=GL_FRAGMENT_SHADER),)
glUseProgram(program)
glPolygonMode(GL_FRONT_AND_BACK, GL_LINE)
glPatchParameteri(GL_PATCH_VERTICES, 4)
glClearColor(0.06, 0.95, 0.95, 1)  # pale gray
outer_levels = numpy.array([1, 1, 1, 1], dtype=numpy.float32)
inner_levels = numpy.array([1, 1], dtype=numpy.float32)
while not glfw.window_should_close(window):
    glClear(GL_COLOR_BUFFER_BIT)
    for outer in range(tile_count + 1):  # increase outer tessellation factors left to right
        for inner in range(tile_count + 1):  # inner tesselation factors top to bottom
            glViewport(outer * tile_size, width - inner * tile_size, tile_size, tile_size)
            outer_levels[:] = [outer + 1] * 4  # range 1 to 9; zero means no triangles at all
            inner_levels[:] = [inner] * 2  # range 0 to 8
            glPatchParameterfv(GL_PATCH_DEFAULT_OUTER_LEVEL, outer_levels)
            glPatchParameterfv(GL_PATCH_DEFAULT_INNER_LEVEL, inner_levels)
            glDrawArrays(GL_PATCHES, 0, 6)
    glfw.swap_buffers(window)
    glfw.poll_events()
glfw.terminate()
