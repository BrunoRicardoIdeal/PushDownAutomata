unit uParamTransicao;

{$mode objfpc}{$H+}

interface

uses
   Classes, SysUtils, contnrs;
type

  { TParamTransicao }

  TParamTransicao = class(TObject)
    private
      FInput: string;
      FSimboloPilhaCompara: string;
      FSimboloPilhaInsere: string;
      FDestino: TObject;
    public
      constructor Create(const pInput: string;
       const pSimboloPilhaCompara, pSimboloPilhaInsere: string;
       const pDestino: TObject);
      destructor destroy;override;

      property Imput: string read FInput;
      property SimboloPilhaCompara: string read FSimboloPilhaCompara;
      property SimboloPilhaInsere: string read FSimboloPilhaInsere;
      property Destino: TObject read FDestino;
  end;

  { TListaParamTransicao }

  TListaParamTransicao = class(TObjectList)
    private
      function GetItem(const pIndex: integer): TParamTransicao;
      procedure SetItem(const pIndex: integer; pValue: TParamTransicao);
    public
      property Items[Idx: Integer]: TParamTransicao read GetItem write SetItem;
  end;

implementation

{ TListaParamTransicao }

function TListaParamTransicao.GetItem(const pIndex: integer): TParamTransicao;
begin
   result := TParamTransicao(inherited Items[pIndex]);
end;

procedure TListaParamTransicao.SetItem(const pIndex: integer;
   pValue: TParamTransicao);
begin
   Items[pIndex] := pValue;
end;

{ TParamTransicao }

constructor TParamTransicao.Create(const pInput: string;
  const pSimboloPilhaCompara, pSimboloPilhaInsere: string;
  const pDestino: TObject);
begin
  FInput  := pInput;
  FSimboloPilhaCompara := pSimboloPilhaCompara;
  FSimboloPilhaInsere := pSimboloPilhaInsere;;
  FDestino := pDestino;
end;

destructor TParamTransicao.destroy;
begin
  inherited destroy;
end;

end.

