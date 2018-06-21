program AutomatoDePilha;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, uPrincipal, uConstantes, uEStado, uParamTransicao
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Initialize;
   Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.

