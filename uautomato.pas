unit uAutomato;

{$mode objfpc}{$H+}

interface

uses
   Classes, SysUtils, gstack, uTipos;
type



{ TAutomato }

TAutomato = class(TObject)
   private
     FPilha: TPilhaString;
     FEstadosPossiveis: TVetorEstados;

     function Transitar(pEstado: TEstado; pInput: string; pSimboloPilha: string): TSetResultadoTransicao;

   public
     constructor Create(const pEstadosPossiveis: TVetorEstados);
     destructor Destroy;override;
     procedure Execute(const pCadeia: String);
     property Pilha: TPilhaString read FPilha write FPilha;
end;
implementation

{ TAutomato }

function TAutomato.Transitar(pEstado: TEstado; pInput: string;
   pSimboloPilha: string): TSetResultadoTransicao;
begin

end;

constructor TAutomato.Create(const pEstadosPossiveis: TVetorEstados);
begin
   inherited Create;
   FEstadosPossiveis := pEstadosPossiveis;
   FPilha := TPilhaString.Create;
end;

destructor TAutomato.Destroy;
begin
   FPilha.Destroy;
   inherited Destroy;
end;

procedure TAutomato.Execute(const pCadeia: String);
begin

end;

end.

