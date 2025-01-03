## Lazarus OpenGL 3.3 Tutorial

Sourcen gehören zu dem Wiki in DGL:
- [Lazarus OpenGL 3.3 Tutorial](https://wiki.delphigl.com/index.php/Lazarus_-_OpenGL_3.3_Tutorial)

Bitte Kritik und Feedback hier schreiben: 
- [**Issues**](https://github.com/sechshelme/Lazarus-OpenGL-3.3-Tutorial/issues)
- [OpenGL Forum](https://delphigl.com/forum/viewtopic.php?f=13&t=11565&p=100919#p100919)
- [Lazarus Forum]( http://www.lazarusforum.de/viewtopic.php?f=29&t=11373&p=101685&hilit=opengl+3.3#p101685)

Auf Github hat es zum Teil Projekte, welche im Wiki nicht vorhanden/beschrieben sind, diese befinden sich in Arbeit oder sind Fehlerhaft.

Tutorial direkt auf GitHub:
- [Inhaltsverzeichniss Tutorial](wiki.md)

## Neuerungen:

| Datum | Änderungen 
| :---: | ---
| 22.11.2024 | Bug im Beispiel"xx_-_Einrichten_und_Einstieg/xx_-_Context_erzeugen" behoben.
| 21.11.2024 | Mindesanforderung von FPC/Lazarus angepasst.
| 20.05.2024 | Neu Package **ogl_package_nolcl** hinzugefügt.
| 20.04.2024 | **dglopengl.pas** durch **oglglad_gl.pas** ersetzt.
| 20.08.2023 | Neue Beispiele bei Geometrie-Shader.
| 05.06.2022 | Diese readme.me optisch gestaltet.
| 11.04.2022 | Tutorial direkt bei den Sourcen intergriert, anhand einzelner "readme.md" Dateien in den einzelnen Ordner.
| 02.05.2020 | readme.me in jedem Unterverzeichniss mit Images eingefügt.
| 28.10.2018 | Bug behoben bei **Normalize**.
| 30.07.2018 | Fehler bei Verwendung von **Nur einer Array** wurde behoben, es wurden versehentlicht zweimal die Daten in den Vertex-Buffer geschrieben.
| 27.07.2018 | Verwendung von Instancen.
| 14.07.2018 | Funktionen in **oglVektor** und **oglMatrix** optimiert.
| 20.06.2018 | **Matrix.Multiply** wurde aus oglMatrix **entfernt**, dafür ist es möglich Matrizen direkt zu multiplizieren.<br>**Matrix := Matrix * Matrix**
| 08.05.2018 | Textur-Array
| 28.04.2018 | Objekte mit Alpha-Blending sortieren, so das man die unschönen Überlappungen verhindern kann.
| 08.04.2018 | Bump-Mapping
| 25.03.2018 | UBO-Tutorial fertig gestellt.
| 23.03.2018 | Die Vertex-Funktionen wurden aus der oglMatrix Unit entfernt und in eine seperate Unit oglVetex ausgelagert.<br>Die Classe TMatrix wurde entfernt und durch Type Helper ersetzt, somit hat man nun die Möglichkeit die Matrizen auch in einer UBO zu verwenden.
| 16.03.2018 | Im Ordner "HTML-Tutorial" befindet sich das Tutorial in einer HTML-Version.
| 15.01.2018 | Tutorial auf GITHUB hochgeladen.
| 10.04.2017 | Tutorial das erste mal veröffentlicht.

## Fremde Tutorial
- https://learnopengl.com/Advanced-OpenGL/Geometry-Shader
- https://open.gl/geometry
- https://paroj.github.io/gltut/index.html
- https://www.songho.ca/opengl/index.html
- https://ogldev.org/index.html

## Info-Seiten zu OpenGL
- https://docs.gl
- https://registry.khronos.org/OpenGL/specs/gl/glspec33.compatibility.pdf

## Header Generator
- [glad](https://glad.dav1d.de/)  
- [glad2](https://gen.glad.sh//) (Kein Pascal)
- [Infos zu glad](glad.md)

## GLFW Libs bauen
- [Anleitung](Create_GLFW_Libs.md)

## Verwandtes mit OpenGL

### WebGL
- https://www.khronos.org/webgl/
- Sampler
  - https://webglsamples.org/


### WebGPU
- https://www.w3.org/TR/webgpu/
- Sampler:
  - https://webgpu.github.io/webgpu-samples/?sample=helloTriangle

#### Installation Linux
- Download: https://www.google.com/intl/de/chrome/dev/
```bash
$ google-chrome-unstable --enable-unsafe-webgpu --enable-features=Vulkan
```
Mehr Infos: 
- https://stackoverflow.com/questions/72294876/i-enable-webgpu-in-chrome-dev-and-it-still-doesnt-work
- https://askubuntu.com/questions/299345/how-to-enable-webgl-in-chrome-on-ubuntu
- https://developer.chrome.com/blog/webgpu-release?hl=de
- https://developer.chrome.com/blog/webgpu-release?hl=en

#### Installation Windows
- Chrome läuft auf Anhieb

## Schlagwörter: 
Tutorial Lazarus FPC Pascal Delphi OpenGL 3.3 Core Vector Vektor Vertex Matrix 3D


