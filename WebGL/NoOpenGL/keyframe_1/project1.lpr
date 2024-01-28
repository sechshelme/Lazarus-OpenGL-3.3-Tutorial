program project1;

{$mode objfpc}

uses
  JS,
  Classes,
  SysUtils,
  Web,
  browserconsole;

begin
  document.body.innerHTML +=
    '<div>' +
    '  <style>' +
    '    div {' +
    '      width: 100px;' +
    '      height: 100px;' +
    '      background: red;' +
    '      position: relative;' +
    '      animation: mymove 5s infinite;' +
    '    }' +
    '' +
    '    @keyframes mymove {' +
    '      from {top: 0px;}' +
    '      to {top: 200px;}' +
    '    }' +
    '  </style>' +
    '</div>';
end.
