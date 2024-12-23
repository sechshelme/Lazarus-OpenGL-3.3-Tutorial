program project1;

uses
  Math,
  mgl_pas;

  procedure main;
  var
    gr: HMGL;
  begin
    gr := mgl_create_graph(600, 400);
    mgl_fplot(gr, 'sin(pi*x)', '', '');
    mgl_write_frame(gr, 'test.bmp', '');
    mgl_write_frame(gr, 'test.svg', '');
    mgl_write_frame(gr, 'test.png', '');

    mgl_delete_graph(gr);

  end;

begin
  SetExceptionMask([exDenormalized, exInvalidOp, exOverflow, exPrecision, exUnderflow, exZeroDivide]);
  main;
end.
