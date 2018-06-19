unit uTipos;

{$mode objfpc}{$H+}

interface

uses
   Classes, SysUtils, gstack;

type

  TEstado = record
    Id: string;
    EstadoFinal: Boolean;
  end;

  TVetorEstados = array of TEstado;

  TPilhaString = specialize TStack<string>;

  TResultadoTransicao = record
    NovoEstado: TEstado;
    NovoSimboloPilha: string;
  end;

  TSetResultadoTransicao = array of TResultadoTransicao;

implementation

end.

