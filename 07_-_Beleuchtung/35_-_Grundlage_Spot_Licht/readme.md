<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>07 - Beleuchtung</h1></b>
    <b><h2>35 - Grundlage Spot Licht</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Dieses Beispiel zeigt, wie ein Spotlicht berechnet wird.<br>
Zum besseren Verständnis, wird das ganze ohne OpenGL als 2D auf einem Canvas gezeigt.<br>
<hr><br>
Deklarationen der benütigenten Variablen.<br>
<pre><code>type
  TVec2 = array[0..1] of single;</font>

var
  LichtOefffnung: single;
  LichtPos, LichtRichtung: TVec2;</pre></code>
Entspricht dem <b>vec2</b> von <b>GLSL</b>.<br>
<pre><code>function vec2(x, y: single): TVec2; inline;
begin
  Result[0] := x;</font>
  Result[1] := y;</font>
end;</pre></code>
Entspricht dem <b>normalize(vec2)</b> von <b>GLSL</b>.<br>
Dies normalisiert den 2D-Vektor.<br>
<pre><code>function normalize(v: TVec2): TVec2;
var
  i: integer;
  l: single;
begin
  l := Sqrt(Sqr(v[0]) + Sqr(v[1]));</font>
  if l = 0 then begin</font>
    l := 1.0;</font>
  end;
  for i := 0 to 1 do begin</font>
    Result[i] := v[i] / l;
  end;
end;</pre></code>
Entspricht dem <b>dot(vec2)</b> von <b>GLSL</b>.<br>
Hier wird das Skalarprodukt aus 2 Vektoren berechnent.<br>
<b>arccos(Result)</b>, gibt den Winkel der beiden Vektoren im Bogenmass aus.<br>
<pre><code>function dot(v1, v2: TVec2): single;
begin
  Result := ((v1[0] * v2[0] + v1[1] * v2[1]) / (sqrt(v1[0] * v1[0] + v1[1] * v1[1]) * sqrt(v2[0] * v2[0] + v2[1] * v2[1])));
end;</pre></code>
Startwerte für die Lichtparameter.<br>
<pre><code>procedure TForm1.FormCreate(Sender: TObject);
begin
  LichtOefffnung := 8; // Ausstrahl-Winkel 45°  ( PI / 8 )</font>
  LichtPos := vec2(200, 100);</font>
  LichtRichtung := vec2(2, 2);</font>
end;</pre></code>
Die Maustasten ändern die Licht und Austrahl-Position.<br>
<pre><code>procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  case Button of
    mbLeft: begin
      LichtRichtung[0] := x - LichtPos[0];</font>
      LichtRichtung[1] := y - LichtPos[1];</font>
    end;
    mbRight: begin
      LichtPos[0] := x;</font>
      LichtPos[1] := y;</font>
    end;
  end;
  Invalidate;
end;</pre></code>
Das Mausrad ändert den Austrahlwinkel.<br>
<pre><code>function isCone(x, y: integer): boolean;
var
  winkel: single;
  lr, lp: TVec2;
begin
  // Lichtrichtung Normalisieren.
  lr := normalize(LichtRichtung);

  // Lichtposition inkremtal berechnen.
  lp :=vec2(x - LichtPos[0], y - LichtPos[1]);</font>

  // Lichtposition Normlisieren.
  lp := normalize(lp);

  // Skalarprodukt berechen.
  winkel := dot(lr, lp);

  // Prüfen, ob sicher der Pixel im Lichtstrahl befindet.
  Result := (winkel > cos(pi / LichtOefffnung));
end;</pre></code>
Zeichen der ganzen Scene.<br>
<pre><code>procedure TForm1.FormPaint(Sender: TObject);
var
  x, y: integer;
begin
  for x := 0 to ClientWidth - 1 do begin
    for y := 0 to ClientHeight - 1 do begin
      if isCone(x, y) then begin
        Canvas.Pixels[x, y] := clYellow;
      end else begin
        Canvas.Pixels[x, y] := clBlack;
      end;
    end;
  end;
end;</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
