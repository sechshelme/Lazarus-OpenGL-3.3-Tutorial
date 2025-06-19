unit status;

interface

uses
  ctypes;

{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


{ Copyright 2018 The Shaderc Authors. All rights reserved. }
{ }
{ Licensed under the Apache License, Version 2.0 (the "License"); }
{ you may not use this file except in compliance with the License. }
{ You may obtain a copy of the License at }
{ }
{     http://www.apache.org/licenses/LICENSE-2.0 }
{ }
{ Unless required by applicable law or agreed to in writing, software }
{ distributed under the License is distributed on an "AS IS" BASIS, }
{ WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. }
{ See the License for the specific language governing permissions and }
{ limitations under the License. }
{$ifndef SHADERC_STATUS_H_}
{$define SHADERC_STATUS_H_}
{ C++ extern C conditionnal removed }
{ Indicate the status of a compilation. }
{ error stage deduction }
{ unexpected failure }
type
  Pshaderc_compilation_status = ^Tshaderc_compilation_status;
  Tshaderc_compilation_status =  Longint;
  Const
    shaderc_compilation_status_success = 0;
    shaderc_compilation_status_invalid_stage = 1;
    shaderc_compilation_status_compilation_error = 2;
    shaderc_compilation_status_internal_error = 3;
    shaderc_compilation_status_null_result_object = 4;
    shaderc_compilation_status_invalid_assembly = 5;
    shaderc_compilation_status_validation_error = 6;
    shaderc_compilation_status_transformation_error = 7;
    shaderc_compilation_status_configuration_error = 8;
;
{ C++ end of extern C conditionnal removed }
{ __cplusplus }
{$endif}
{ SHADERC_STATUS_H_ }

// === Konventiert am: 19-6-25 14:35:43 ===


implementation



end.
