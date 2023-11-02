program project1;


{$LinkLib glfw}
{$LinkLib vulkan}
{$LinkLib dl}
{$LinkLib pthread}
{$LinkLib X11}
{$LinkLib Xxf86vm}
{$LinkLib Xrandr}
{$LinkLib Xi}
//{$LinkLib c}
//{$linklib stdc++}


{$LinkLib c}
{$linklib stdc++}
{$linklib gcc_s}
{$L main.o}

function main1(): Integer; cdecl; external;
function main2(): Integer; cdecl; external;

begin
//  main1();
  main2();
end.
