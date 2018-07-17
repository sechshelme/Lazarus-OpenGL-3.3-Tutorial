unit oglUBO;

{$mode objfpc}{$H+}

interface       // Achtung fehlerhaft !

uses
  Classes, SysUtils, Dialogs,
  dglOpenGL, oglShader;

// Achtung !  Darf nicht zuviel aufgerufen werden.

type

  { TUBO }

  TUBO = class(TObject)
  private
    BindingPoint, UBO: GLuint;
  public
    constructor Create(Shader: TShader; UniformName: PGLchar; size: GLsizeiptr);
    destructor Destroy; override;

    procedure UpdateBuffer(Data: PGLvoid; size: GLsizeiptr);
  end;

  TMaterialUBO=class(TUBO)

  end;


implementation

{ TUBO }

constructor TUBO.Create(Shader: TShader; UniformName: PGLchar; size: GLsizeiptr);
const
  BPInc: GLuint = 0;
var
  id: GLuint;
begin
  inherited Create;
  BindingPoint := BPInc;
  Inc(BPInc);

  glGenBuffers(1, @UBO);
  id := glGetUniformBlockIndex(Shader.ID, UniformName);
  if id = GL_INVALID_INDEX then begin
    ShowMessage(UniformName + ' ' + IntToStr(GL_INVALID_INDEX));
    Exit;
  end;

  glBindBuffer(GL_UNIFORM_BUFFER, UBO);
  glBufferData(GL_UNIFORM_BUFFER, size, nil, GL_DYNAMIC_DRAW);

  glUniformBlockBinding(Shader.ID, id, BindingPoint);
  glBindBufferBase(GL_UNIFORM_BUFFER, BindingPoint, UBO);
end;

destructor TUBO.Destroy;
begin
  glDeleteBuffers(1, @UBO);
  inherited Destroy;
end;

procedure TUBO.UpdateBuffer(Data: PGLvoid; size: GLsizeiptr);
begin
  glBindBuffer(GL_UNIFORM_BUFFER, UBO);
  glBufferSubData(GL_UNIFORM_BUFFER, 0, size, Data);
end;

end.
