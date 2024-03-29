program project1;
uses
cthreads,
Math;

{$linklib stdc++}
//{$linklib gcc_s}
{$linklib gcc_eh}
{$LinkLib c}


{$LinkLib glfw}
{$LinkLib vulkan}

//{$LinkLib dl}
//{$LinkLib pthread}
//{$LinkLib X11}
//{$LinkLib Xxf86vm}
//{$LinkLib Xrandr}
//{$LinkLib Xi}

{$L main.o}

//function main1(): Integer; cdecl; external;
function main2(): Integer; cdecl; external;

begin
    SetExceptionMask([exDenormalized, exInvalidOp, exOverflow, exPrecision, exUnderflow, exZeroDivide]);
//  main1();
  main2();
end.
