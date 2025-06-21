/*
  Linux:
 gcc main.c -o main -lmgl

  Windows:
  Folgende Datei muss im Stamm-Ordner des Projektes sein libSDL2main.a
  x86_64-w64-mingw32-gcc main.c -o main.exe -lmgl -mwindows -I/usr/local/include -L.
*/


#include <mgl2/mgl_cf.h>
int main()
{
  HMGL gr = mgl_create_graph(600, 400);
  mgl_fplot(gr, "sin(pi*x)", "", "");
  mgl_write_frame(gr, "test.bmp", "");
  mgl_write_frame(gr, "test.svg", "");
  mgl_write_frame(gr, "test.png", "");
  mgl_delete_graph(gr);
}
