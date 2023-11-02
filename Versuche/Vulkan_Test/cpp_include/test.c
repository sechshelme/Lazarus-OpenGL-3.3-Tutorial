#include <iostream>
#include <vector>


// ++ test.c  -c


extern "C"{

  void print() {
      std::vector<char> buffer(1024);

      printf("Hello\n");
  }
 
  int myfunc() {
    return 12345678;
  }

}
