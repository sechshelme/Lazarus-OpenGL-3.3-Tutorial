# 60 - Stencil
## 15 - Stencil

![image.png](image.png)


---
Den Textur-Puffer deklarieren.

```pascal
var
  Textur: TTexturBuffer;
```

Textur-Puffer erzeugen.

```pascal
procedure TForm1.CreateScene;
begin
  Textur := TTexturBuffer.Create;
  Textur.LoadTextures('mauer.bmp');
```

Am Ende muss man die Klasse noch frei geben.

```pascal
procedure TForm1.FormDestroy(Sender: TObject);
begin
  Textur.Free;
```


---
**Vertex-Shader:**

---
**Fragment-Shader:**

