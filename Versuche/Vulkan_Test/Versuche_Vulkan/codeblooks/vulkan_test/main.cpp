#include <exception>
#include <string>
#include <iostream>
#include <SDL.h>
#include <vulkan/vulkan.h>
#include <vulkan/vulkan_core.h>


// https://docs.tizen.org/application/native/guides/graphics/vulkan/
// https://vkguide.dev/docs/chapter-0/code_walkthrough/

// --- SDL
SDL_Window *window;
SDL_Event event;


void VEinit_vulkan()
{
}

void VEinit()
{
  SDL_Init(SDL_INIT_VIDEO | SDL_INIT_EVENTS);
  window = SDL_CreateWindow("SDL Vulkan Sample", 100, 50, 640, 480, SDL_WINDOW_SHOWN | SDL_WINDOW_VULKAN);

  VEinit_vulkan();
}

void VEdraw()
{
  // draw
}

void VErun()
{
  bool quit = false;
  while(!quit) {
    while (SDL_PollEvent(&event)) {
      printf("SDL Event type :: %d\n", event.type);
      if (event.type == SDL_MOUSEBUTTONDOWN) {
        quit = true;
      }
      if (event.type == SDL_MOUSEMOTION) {
        printf("SDL_MOUSEMOTION Event!!\n");
      }
      if (event.type == SDL_QUIT) {
        quit = true;
        printf("quit");
      }
    }
  }
}

void VEcleanup()
{
  SDL_DestroyWindow(window);
  SDL_Quit();
}


int main( int argc, char * argv[] )
{
  VEinit();

  VEdraw();

  VErun();

  VEcleanup();





//    vkDestroyDevice(device, 0);
}
