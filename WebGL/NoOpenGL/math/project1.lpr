program project1;

{$mode objfpc}

uses
  JS, Classes, SysUtils, Web,browserconsole, Math;

// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/E

const MathLog10E: Double; external name 'Math.LOG10E';

function Tan(const A : Double): Double; external name 'Math.tan';
function ArcTan(const A : Double): Double; external name 'Math.atan';
function ArcTan2(const y, x : Double): Double; external name 'Math.atan2';
function ArcTanh(const A : Double): Double; external name 'Math.atanh';
function cbrt(const A : Double): Double; external name 'Math.cbrt';
function clz32(const A : Double): Double; external name 'Math.clz32';

begin
  Writeln(siMathLog10E);

  Writeln(truPower(1));


  Writeln('Ende');
end.
