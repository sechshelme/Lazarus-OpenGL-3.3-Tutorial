(*
Eine kleine Beschreibung der wichtigsten Funktionen in <b>GLSL</b>
Die Funktionen werden in Pascal-Code umgesetzt, so das man sieht, was die Funktionen machen.
Die meisten Funktionen funktionieren in <b>GLSL</b> auch mit <b>vec2</b>, <b>vec3</b>, <b>vev4</b>.

*)


(*
<b>min</b>
*)
//code+
function min(value, min: single): single;
begin
  if value < min then begin
    Result := min;
  end else begin
    Result := value;
  end;
end;
//code-

(*
<b>max</b>
*)
//code+
function max(value, max: single): single;
begin
  if value > max then begin
    Result := max;
  end else begin
    Result := value;
  end;
end;
//code-

(*
<b>clamp</b>
*)
//code+
function clamp(value, min, max: single): single;
begin
  if value < min then begin
    Result := min;
  end else if value > max then begin
    Result := max;
  end else begin
    Result := value;
  end;
end;
//code-


