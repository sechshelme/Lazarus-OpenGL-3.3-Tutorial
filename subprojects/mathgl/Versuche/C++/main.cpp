#include <mgl2/mgl.h>

void smgl_indirect(mglGraph *gr) {
  gr->SubPlot(1, 1, 0, "");	
  gr->Title("SubData vs Evaluate");
  mglData in(9), arg(99), e, s;
  gr->Fill(in, "x^3/1.1");	
  gr->Fill(arg, "4*x+4");
  gr->Plot(in, "ko ");		
  gr->Box();
  e = in.Evaluate(arg, false);	
  gr->Plot(e, "b.", "legend 'Evaluate'");
  s = in.SubData(arg);	
  gr->Plot(s, "y.", "legend 'SubData'");
  gr->Legend(2);
}

int main(int ,char **) {
  mglGraph gr;
  gr.Alpha(true); 
  gr.Light(true);
  smgl_indirect(&gr);          
  gr.WritePNG("test.png"); 
  return 0;
}
