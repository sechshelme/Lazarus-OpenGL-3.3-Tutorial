unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, gl,
  GLext,
  Clipbrd, Menus, OpenGLContext;

type

  { TForm1 }

  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    Memo1: TMemo;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
  private        { public declarations }
    OpenGLControl1: TOpenGLControl;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  units: GLint;
begin
  OpenGLControl1 := TOpenGLControl.Create(Self);
//  OpenGLControl1.OpenGLMajorVersion := 3;  // evtl. auf 0 setzen
//  OpenGLControl1.OpenGLMinorVersion := 3;  // evtl. auf 0 setzen
  OpenGLControl1.Parent := Self;
  OpenGLControl1.Visible := False;
  OpenGLControl1.Align := alClient;
  OpenGLControl1.MakeCurrent;

//  Load_GL_VERSION_3_3;
//  Load_GLADE;

  Memo1.Text :=
    'GL_VENDOR: ' + glGetString(GL_VENDOR) + #13#10#13#10 + 'GL_RENDERER: ' +
    glGetString(GL_RENDERER) + #13#10#13#10 + 'GL_VERSION: ' +
    glGetString(GL_VERSION) + #13#10#13#10 + 'GL_SHADING_LANGUAGE_VERSION: ' +
    glGetString(GL_SHADING_LANGUAGE_VERSION) + #13#10#13#10 + 'GL_EXTENSIONS: ' +
    glGetString(GL_EXTENSIONS);

//  glGetIntegerv(GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS, @units);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  //  DeactivateRenderingContext;
  OpenGLControl1.Free;
end;

procedure TForm1.MenuItem1Click(Sender: TObject);
begin
  Clipboard.AsText := Memo1.Text;
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  Close;
end;

end.
