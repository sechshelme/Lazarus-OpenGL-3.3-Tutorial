// g++ *.cpp -o vulkan -lSDL2main -lSDL2 -lvulkan-1
// https://vulkan-tutorial.com/

#include <iostream>
using namespace std;

#include <SDL2/SDL.h>
SDL_Window *window;
char* window_name = "example SDL2 Vulkan application";

#include "vulkan_extern.h"
#include "vulkan_function.h"
Vulkan *vulkan;

int main(int argc, char *argv[])
{
    SDL_Init(SDL_INIT_EVERYTHING);
    window = SDL_CreateWindow(window_name,SDL_WINDOWPOS_CENTERED,SDL_WINDOWPOS_CENTERED,800,600,SDL_WINDOW_VULKAN | SDL_WINDOW_SHOWN);

    vulkan = new Vulkan();
    init_vulkan_extern(vulkan);

    SDL_Event event;
    bool running = true;
    while(running)
    {
        while(SDL_PollEvent(&event))
        {
            if(event.type == SDL_QUIT)
            {
                running = false;
            }
        }

        AcquireNextImage();

        ResetCommandBuffer();
        BeginCommandBuffer();
        {
            VkClearColorValue clear_color = {0.0f, 0.0f, 0.0f, 1.0f};
            VkClearDepthStencilValue clear_depth_stencil = {1.0f, 0};
            BeginRenderPass(clear_color,clear_depth_stencil);
            {

	    }
            EndRenderPass();
        }
        EndCommandBuffer();

        QueueSubmit();
	QueuePresent();
    }

    delete vulkan;
    vulkan = nullptr;

    SDL_DestroyWindow(window);
    window = nullptr;

    SDL_Quit();
    return 0;
}
