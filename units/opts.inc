//If "COREGL" is defined the glcorearb is used, otherwise dglOpenGL is used.
//The "core" is a subset of OpenGL, so dglOpenGL is a superset of glcorearb and legacy features
// MacOS only supports core features, so restricting to glcorearb is wise
// Some prefer glcorearb on Linux as it has an X dependency
// Using the core library ensures you can run on MacOS and ensures you do not use legacy features
//On the other hand, dglOpenGL allows you to mix legacy and modern features.
{$IFDEF DARWIN}
 {$DEFINE COREGL}
{$ENDIF}