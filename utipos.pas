unit uTipos;

{$mode objfpc}{$H+}

interface

uses
   Classes, SysUtils, contnrs, uEstado;

type
  //TPilhaString = specialize TStack<String>;

  TResultadoTransicao = record
    NovoEstado: TEstado;
    NovoSimboloPilha: string;
  end;

  TSetResultadoTransicao = array of TResultadoTransicao;

implementation

end.

