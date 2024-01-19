program project1;

{$mode objfpc}
{$modeswitch externalclass}
{$modeswitch typehelpers}

uses
  JS,
  Classes,
  SysUtils,
  browserconsole,
  Web;

  // https://www.w3schools.com/jsref/tryit.asp?filename=tryjsref_onclick_win
// https://github.com/Kryuski/pas2js-for-delphi/blob/master/packages/chartjs/chartjs.pas

  type
    TColorElement = class external name 'Object' (TJSCSSStyleDeclaration)
      backgroundColor: String; external name 'backgroundColor';
      borderColor: String; external name 'borderColor';

      //borderWidth: Integer; external name 'borderWidth';
      //radius: JSValue; external name 'radius';
      //color: JSValue; external name 'color';
    end;

  function onclick(aEvent: TJSMouseEvent): boolean;
  begin
    //    TJSHTMLStyleElement(document.getElementsByTagName('BODY')[0]).style.:=nil;
  end;

  function ButtonClick(aEvent: TJSMouseEvent): boolean;
  begin
    TColorElement(TJSHTMLElement(document.getElementsByTagName('input')[0]).style).backgroundColor := 'red';
    TColorElement(TJSHTMLElement(document.getElementsByTagName('input')[0]).style).borderColor := 'yellow';
//    TColorElement(TJSHTMLElement(document.getElementsByTagName('input')[0]).style).color := 'green';


    TColorElement(TJSHTMLElement(document.getElementsByTagName('input')[1]).style).backgroundColor := 'blue';
    TColorElement(TJSHTMLElement(document.getElementsByTagName('body')[0]).style).backgroundColor := 'green';

    TJSHTMLElement(document.getElementsByTagName('input')[0]).style.cssText:=' background-color:red';
    TJSHTMLElement(document.getElementsByTagName('input')[0]).style.cssText:=' borderColor:green';
  end;

var
  Button1, Button2, row1, heading1, heading2, heading3, row2,
    row2_data_1, row2_data_2, row2_data_3, row3, row3_data_1,
    row3_data_2, row3_data_3, table1, thead1, tbody1: TJSElement;

begin
  Button1 := document.createElement('input');
  Button1['id'] := 'Button2_id';
  Button1['type'] := 'button';
  Button1['value'] := 'Button2';
//  Button1['style'] := 'background-color: #FFBBBB;';

  //  TJSHTMLElement(Button1).onclick := @ButtonClick;
  document.body.appendChild(Button1);

  Button2 := document.createElement('input');
  Button2['id'] := 'Button1_id';
  Button2['type'] := 'button';
  Button2['value'] := 'Button1';
//  Button2['style'] := 'background-color: #FFBBFF;';

  TJSHTMLElement(Button2).onclick := @ButtonClick;
  document.body.appendChild(Button2);

      TColorElement(TJSHTMLElement(document.getElementsByTagName('input')[0]).style).backgroundColor := 'white';

 // https://www.delftstack.com/de/howto/javascript/create-table-javascript/

 table1 := document.createElement('table');
 document.body.appendChild(table1);
 thead1 := document.createElement('thead');
 table1.appendChild(thead1);
 tbody1 := document.createElement('tbody');
// tbody1.appendChild(tbody1);


 // --- row1
      row1 := document.createElement('tr');
      heading1 := document.createElement('th');
      heading1.innerHTML:='Str. No.';
      heading2 := document.createElement('th');
      heading2.innerHTML:='Name';
      heading3 := document.createElement('th');
      heading3.innerHTML:='Company';

      row1.appendChild(heading1);
      row1.appendChild(heading2);
      row1.appendChild(heading3);

      table1.appendChild(row1);

      // --- row2
           row2 := document.createElement('tr');
           row2_data_1 := document.createElement('td');
           row2_data_1.innerHTML:='123';
           row2_data_2 := document.createElement('td');
           row2_data_2.innerHTML:='James Clerk';
           row2_data_3 := document.createElement('td');
           row2_data_3.innerHTML:='Netflix';

           row2.appendChild(row2_data_1);
           row2.appendChild(row2_data_2);
           row2.appendChild(row2_data_3);

           table1.appendChild(row2);

           // --- row3
                row3 := document.createElement('tr');
                row3_data_1 := document.createElement('td');
                row3_data_1.innerHTML:='456';
                row3_data_2 := document.createElement('td');
                row3_data_2.innerHTML:='Adam White';
                row3_data_3 := document.createElement('td');
                row3_data_3.innerHTML:='IBM';

                row2.appendChild(row3_data_1);
                row2.appendChild(row3_data_2);
                row2.appendChild(row3_data_3);

                table1.appendChild(row3);


  // Your code here
  window.onclick := @onclick;
end.
