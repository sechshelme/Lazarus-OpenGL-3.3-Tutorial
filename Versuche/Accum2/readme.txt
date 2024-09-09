Motion Blur
-----------

This project is very similar to a previous one called Render To Texture. It also uses glCopyToTexture and redraws the previous scene before rendering the new scene. At each step the previous scene is drawn 10% darker to make it fade away. 

The proper way to do motion blur would be to use the accumulation buffer, but that is only supported on a hardware level on non-commercial cards. If you try it on your GeForce you would probably get around 1-2 fps.

The code would look something like ...

    glClear(GL_ACCUM_BUFFER_BIT);
    for I :=0 to 9 do
    begin
      RenderScene(I);
      glAccum(GL_ACCUM, 1/10);
    end;
    glAccum(GL_RETURN, 1.0);


Keys : 
  UP and DOWN arrows to add remove blur effect.


If you have any queries or bug reports, please mail me

Code : Jan Horn
Mail : jhorn@global.co.za
Web  : http://www.sulaco.co.za
       http://home.global.co.za/~jhorn