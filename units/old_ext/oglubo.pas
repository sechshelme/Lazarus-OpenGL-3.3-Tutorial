unit oglUBO;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Dialogs,
  oglglad_gl, oglShader;

type

  { TUBO }

  TUBO = class(TObject)
  private
    fBindingPoint, UBO: GLuint;
    fBufferSize: integer;
  public
    constructor Create(Shader: TShader; UniformName: PGLchar; size: GLsizeiptr; BindingPoint: GLuint);
    destructor Destroy; override;

    procedure Bind;
    procedure UpdateBuffer(Data: PGLvoid);
  end;

implementation

{ TUBO }

constructor TUBO.Create(Shader: TShader; UniformName: PGLchar; size: GLsizeiptr; BindingPoint: GLuint);
begin
  inherited Create;
  fBindingPoint := BindingPoint;
  fBufferSize := size;

  glGenBuffers(1, @UBO);

  glBindBuffer(GL_UNIFORM_BUFFER, UBO);
  glBufferData(GL_UNIFORM_BUFFER, size, nil, GL_DYNAMIC_DRAW);

  glUniformBlockBinding(Shader.ID, Shader.UniformBlockIndex(UniformName), fBindingPoint);
  glBindBufferBase(GL_UNIFORM_BUFFER, fBindingPoint, UBO);
end;

destructor TUBO.Destroy;
begin
  glDeleteBuffers(1, @UBO);
  inherited Destroy;
end;

procedure TUBO.Bind;
begin
  glBindBuffer(GL_UNIFORM_BUFFER, UBO);
  glBindBufferBase(GL_UNIFORM_BUFFER, fBindingPoint, UBO);
end;

procedure TUBO.UpdateBuffer(Data: PGLvoid);
begin
  glBindBuffer(GL_UNIFORM_BUFFER, UBO);
  glBufferSubData(GL_UNIFORM_BUFFER, 0, fBufferSize, Data);
end;

end.
