unit uTipos;

{$mode objfpc}{$H+}

interface

uses
   Classes, SysUtils, uEstado;

type
  TResultadoTransicao = record
    NovoEstado: TEstado;
    NovoSimboloPilha: string;
  end;

  TSetResultadoTransicao = array of TResultadoTransicao;

implementation

end.

