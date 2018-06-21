unit uAutomato;

{$mode objfpc}{$H+}

interface

uses
   Classes, SysUtils, uTipos, uEStado, uParamTransicao, strutils, uConstantes, contnrs;
type

{ TAutomato }

TAutomato = class(TObject)
   private
     FPilha: TStack;
     FEstadosPossiveis: TListaEstado;
     FEstadoAtual: TEstado;
     procedure ConfigurarEstados;
     procedure ConfigurarListaTransicoes(var pEstado: TEstado);
     function GetTransicaoInput(const pInput: string; const pEstado: TEstado): TListaParamTransicao;

     function Transitar(pEstado: TEstado; pInput: string; pSimboloPilha: string): TSetResultadoTransicao;

   public
     constructor Create;
     destructor Destroy;override;
     function Execute(const pCadeia: String): string;
     procedure IniciarPilha;
     property Pilha: TStack read FPilha write FPilha;
     property EstadosPossiveis: TListaEstado read FEstadosPossiveis;
end;
implementation

{ TAutomato }

procedure TAutomato.ConfigurarEstados;
var
   lEstado: TEstado;
   lIndex: Integer;
begin
   FEstadosPossiveis.Clear;

   lEstado := TEstado.Create('qi', False);
   FEstadosPossiveis.Add(lEstado);

   //Estado q0
   lEstado := TEstado.Create('q0', False);
   FEstadosPossiveis.Add(lEstado);

   lEstado := TEstado.Create('q1', False);
   FEstadosPossiveis.Add(lEstado);

   lEstado := TEstado.Create('q2', False);
   FEstadosPossiveis.Add(lEstado);

   lEstado := TEstado.Create('q3', True);
   FEstadosPossiveis.Add(lEstado);

   for lIndex := 0 to Pred(FEStadosPossiveis.Count) do
   begin
     lEstado := FEstadosPossiveis.Items[lIndex];
     ConfigurarListaTransicoes(lEstado);
   end;

end;

procedure TAutomato.ConfigurarListaTransicoes(var pEstado: TEstado);
var
   lTransicao: TParamTransicao;
begin
   if pEstado <> nil then
   begin
     //Estado inicial
     if pEstado.Id = 'q0' then
     begin
       lTransicao := TParamTransicao.Create('0', '', 'F', FEstadosPossiveis.ItemByID('q1'));
       pEstado.ListaParamTransicoes.Add(lTransicao);

       lTransicao := TParamTransicao.Create('1', '', '', FEstadosPossiveis.ItemByID('q1'));
       pEstado.ListaParamTransicoes.Add(lTransicao);
     end
     else if pEstado.Id = 'q1' then
     begin
       lTransicao := TParamTransicao.Create('0', 'X', 'XX', pEstado);
       pEstado.ListaParamTransicoes.Add(lTransicao);

       lTransicao := TParamTransicao.Create('0', 'F', 'XF', pEstado);
       pEstado.ListaParamTransicoes.Add(lTransicao);

       lTransicao := TParamTransicao.Create('1', 'X', '', FEstadosPossiveis.ItemByID('q2'));
       pEstado.ListaParamTransicoes.Add(lTransicao);
     end
     else if pEstado.Id = 'q2' then
     begin
       lTransicao := TParamTransicao.Create('1', 'X', '', pEstado);
       pEstado.ListaParamTransicoes.Add(lTransicao);

       lTransicao := TParamTransicao.Create('1', 'F', '', FEstadosPossiveis.ItemByID('q3'));
       pEstado.ListaParamTransicoes.Add(lTransicao);
     end
     //Estado final
     else if pEstado.Id = 'q3' then
     begin
       lTransicao := TParamTransicao.Create('1', '', '', pEstado);
       pEstado.ListaParamTransicoes.Add(lTransicao);
     end;
   end;
end;

function TAutomato.GetTransicaoInput(const pInput: string; const pEstado: TEstado): TListaParamTransicao;
var
   lParam: TParamTransicao;
   lIndex: Integer;
begin
   Result := TListaParamTransicao.Create;
   Result.OwnsObjects := False;
   for lIndex:= 0 to Pred(pEstado.ListaParamTransicoes.count) do
   begin
     lParam := pEstado.ListaParamTransicoes.Items[lIndex];
     if lParam.Imput = pInput then
     begin
       Result.Add(lParam);
     end;
   end;
end;

function TAutomato.Transitar(pEstado: TEstado; pInput: string;
   pSimboloPilha: string): TSetResultadoTransicao;
begin

end;

constructor TAutomato.Create;
begin
   inherited Create;
   FEstadosPossiveis := TListaEstado.Create;
   ConfigurarEstados;
   IniciarPilha;
end;

destructor TAutomato.Destroy;
begin
   FPilha.Destroy;
   FEstadosPossiveis.Destroy;
   inherited Destroy;
end;

function TAutomato.Execute(const pCadeia: String): string;
var
  lCharCadeia: Char;
  lTop: PChar;
  lTransicoes: TListaParamTransicao;
  lTrans: TParamTransicao;
  lIndexTran: Integer;
begin
   IniciarPilha;
   FEstadoAtual := FEstadosPossiveis.ItemByID('q0');

   for lCharCadeia in pCadeia do
   begin
      if not MatchStr(lCharCadeia, INPUT_ALPHABET) then
      begin
        FEstadoAtual := FEstadosPossiveis.ItemByID('qi');
        Break;
      end
      else
      begin

         lTransicoes := GetTransicaoInput(lCharCadeia, FEstadoAtual);
         try
           if lTransicoes.Count <= 0 then
           begin
              FEstadoAtual := FEstadosPossiveis.ItemByID('qi');
              break;
           end
           else
           begin

              lTop := FPilha.Pop;
              if lTop = STACK_GROUND then
              begin
                FPilha.Push(PChar(STACK_GROUND));
              end;

              for lIndexTran:= 0 to pred (lTransicoes.Count) do
              begin
                 lTrans := lTransicoes.Items[lIndexTran];
                 if (lTrans.SimboloPilhaCompara = lTop) or
                    (lTrans.SimboloPilhaCompara = '') then
                 begin
                    lTop := FPilha.Pop();
                    if lTrans.SimboloPilhaInsere <> '' then
                    begin
                       FPilha.Push(PChar(lTrans.SimboloPilhaInsere));
                    end;
                    FEstadoAtual := TEstado(lTrans.Destino);
                 end;
              end;
           end;
         finally
           lTransicoes.Free;
         end;
      end;
   end;

   if FEstadoAtual.Final then
   begin
     Result := 'Cadeia: ' + pCadeia + sLineBreak + 'Status: ' + 'Aceita!' + sLineBreak;
   end
   else
   begin
     Result := 'Cadeia: ' + pCadeia + sLineBreak + 'Status: ' + 'Rejeitada!' + sLineBreak;
   end;
end;

procedure TAutomato.IniciarPilha;
begin
   if not Assigned(FPilha) then
   begin
     FPilha := TStack.Create;
   end
   else
   begin
     while FPilha.Count > 0 do
     begin
        FPilha.Pop();
     end;
   end;
   FPilha.Push(PChar(STACK_GROUND));
end;

end.

