

// gcc main.c -o main -lGL -lGLEW -lglfw -lshaderc



#include <GL/glew.h>
#include <SDL3/SDL.h>
#include <shaderc/shaderc.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

const char* vertex_shader_src =
    "#version 460 core\n"
    "layout(location = 0) in vec2 pos;\n"
    "void main() { gl_Position = vec4(pos, 0.0, 1.0); }\n";

const char* fragment_shader_src =
    "#version 460 core\n"
    "layout(location = 0) out vec4 color;\n"
    "void main() { color = vec4(1, 0.5, 0, 1); }\n";

GLuint compile_spirv(shaderc_shader_kind kind, const char* src) {
    shaderc_compiler_t compiler = shaderc_compiler_initialize();
    shaderc_compilation_result_t result = shaderc_compile_into_spv(
        compiler, src, strlen(src), kind, "shader.glsl", "main", NULL);
    if (shaderc_result_get_compilation_status(result) != shaderc_compilation_status_success) {
        fprintf(stderr, "Shaderc error: %s\n", shaderc_result_get_error_message(result));
        exit(1);
    }
    size_t spirv_size = shaderc_result_get_length(result);
    const void* spirv_data = shaderc_result_get_bytes(result);

    GLuint shader = glCreateShader(kind == shaderc_vertex_shader ? GL_VERTEX_SHADER : GL_FRAGMENT_SHADER);
    glShaderBinary(1, &shader, 0x9551 /*GL_SHADER_BINARY_FORMAT_SPIR_V*/, spirv_data, spirv_size);
    glSpecializeShader(shader, "main", 0, NULL, NULL);

    shaderc_result_release(result);
    shaderc_compiler_release(compiler);
    return shader;
}

int main(void) {
    if (SDL_Init(SDL_INIT_VIDEO) < 0) {
        fprintf(stderr, "SDL_Init failed: %s\n", SDL_GetError());
        return 1;
    }

    SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 4);
    SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 6);
    SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK, SDL_GL_CONTEXT_PROFILE_CORE);

    SDL_Window* window = SDL_CreateWindow("SPIR-V Triangle", 640, 480, SDL_WINDOW_OPENGL);
    if (!window) {
        fprintf(stderr, "SDL_CreateWindow failed: %s\n", SDL_GetError());
        SDL_Quit();
        return 1;
    }

    SDL_GLContext glctx = SDL_GL_CreateContext(window);
    if (!glctx) {
        fprintf(stderr, "SDL_GL_CreateContext failed: %s\n", SDL_GetError());
        SDL_DestroyWindow(window);
        SDL_Quit();
        return 1;
    }

    glewExperimental = GL_TRUE;
    if (glewInit() != GLEW_OK) {
        fprintf(stderr, "GLEW init failed\n");
        return 1;
    }

    if (!GLEW_ARB_gl_spirv) {
        fprintf(stderr, "GL_ARB_gl_spirv nicht verfügbar!\n");
        return 1;
    }

    float verts[] = { -0.5f, -0.5f,  0.5f, -0.5f,  0.0f, 0.5f };
    GLuint vao, vbo;
    glGenVertexArrays(1, &vao); glBindVertexArray(vao);
    glGenBuffers(1, &vbo); glBindBuffer(GL_ARRAY_BUFFER, vbo);
    glBufferData(GL_ARRAY_BUFFER, sizeof(verts), verts, GL_STATIC_DRAW);
    glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, 0, (void*)0);
    glEnableVertexAttribArray(0);

    GLuint vs = compile_spirv(shaderc_vertex_shader, vertex_shader_src);
    GLuint fs = compile_spirv(shaderc_fragment_shader, fragment_shader_src);
    GLuint prog = glCreateProgram();
    glAttachShader(prog, vs); glAttachShader(prog, fs);
    glLinkProgram(prog);

    int running = 1;
    while (running) {
        SDL_Event e;
        while (SDL_PollEvent(&e)) {
            if (e.type == SDL_EVENT_QUIT) running = 0;
        }
        glClear(GL_COLOR_BUFFER_BIT);
        glUseProgram(prog);
        glBindVertexArray(vao);
        glDrawArrays(GL_TRIANGLES, 0, 3);
        SDL_GL_SwapWindow(window);
    }

SDL_GL_DestroyContext(glctx);
    SDL_DestroyWindow(window);
    SDL_Quit();
    return 0;
}

