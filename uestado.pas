unit uEstado;

{$mode objfpc}{$H+}

interface

uses
   Classes, SysUtils, contnrs, uParamTransicao;

type

   { TEstado }

   TEstado = class(TObject)
     private
       FId: string;
       FFinal: Boolean;
       FListaParamTransicoes: TListaParamTransicao;
     public
       constructor Create(const pId: string; const pFinal: boolean);
       destructor Destroy;override;

       function GetProximoEstado(const pInput: string): TEstado;

       property Id:string read FId;
       property Final: Boolean read FFinal default False;
       property ListaParamTransicoes: TListaParamTransicao read FListaParamTransicoes write FListaParamTransicoes;
    end;

   { TListaEstado }

   TListaEstado = class(TObjectList)
     private
       function GetItem(const pIndex: integer): TEstado;
       procedure SetItem(const pIndex: integer; pValue: TEstado);
     public
       function ItemByID(const pID: string): TEstado;
       property Items[index: Integer]: TEstado read GetItem write SetItem;
   end;

implementation

{ TListaEstado }

function TListaEstado.GetItem(const pIndex: integer): TEstado;
begin
   result := TEstado(inherited Items[pIndex]);
end;

procedure TListaEstado.SetItem(const pIndex: integer; pValue: TEstado);
begin
   Items[pIndex] := pValue;
end;

function TListaEstado.ItemByID(const pID: string): TEstado;
var
   lIndex: integer;
begin
   Result := nil;
   for lIndex := 0 to pred(Self.Count) do
   begin
     if Self.Items[lIndex].Fid = pID then
     begin
       Result := Self.Items[lIndex];
     end;
   end;
end;

{ TEstado }

constructor TEstado.Create(const pId: string; const pFinal: boolean);
begin
   inherited Create;
   FId    := pId;
   FFinal := pFinal;
   FListaParamTransicoes := TListaParamTransicao.Create();
end;

destructor TEstado.Destroy;
begin
   FListaParamTransicoes.Destroy;
   inherited Destroy;
end;

function TEstado.GetProximoEstado(const pInput: string): TEstado;
var
   lIndex: integer;
   lParam: TParamTransicao;
begin
   //for lIndex:= 0 to Pred(Self.FListaParamTransicoes.count) then
   begin
      lParam := self.FListaParamTransicoes.Items[lIndex];

   end;

end;

end.

