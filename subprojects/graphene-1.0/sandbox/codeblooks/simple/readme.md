```
gcc $(pkg-config --cflags gtk4) -o hello-world-gtk hello.c $(pkg-config --libs gtk4)
```
