unit uAutomato;

{$mode objfpc}{$H+}

interface

uses
   Classes, SysUtils, uEStado, uParamTransicao, strutils, uConstantes, contnrs,
   StdCtrls;
type

{ TAutomato }

TAutomato = class(TObject)
   private
      var
        FPilha: TStack;
        FEstadosPossiveis: TListaEstado;
        FEstadoAtual: TEstado;
        FMemoLogPilha: TMemo;
        FCharInsere: Char;
        FStrRev: string;
        FTopStr: string;
        FvetIns: array of string;
        FVetStackShow: array of string;
     procedure ConfigurarEstados;
     procedure ConfigurarListaTransicoes(var pEstado: TEstado);
     procedure Push(const pTrans: TParamTransicao);
     procedure ProcessaTransicao(const pTransicoes: TListaParamTransicao);
     function Pop: string;
     function Peek: string;
     function EscrevePilha: string;
     function GetTransicaoInput(const pInput: string; const pEstado: TEstado): TListaParamTransicao;
   public
     constructor Create;
     destructor Destroy;override;
     function Execute(const pCadeia: String): string;
     procedure IniciarPilha;
     property Pilha: TStack read FPilha write FPilha;
     property EstadosPossiveis: TListaEstado read FEstadosPossiveis;
     property MemoLogPilha: TMemo read FMemoLogPilha write FMemoLogPilha;
end;
implementation

{ TAutomato }

procedure TAutomato.ConfigurarEstados;
var
   lEstado: TEstado;
   lIndex: Integer;
begin
   FEstadosPossiveis.Clear;

   lEstado := TEstado.Create('qe', False);
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

procedure TAutomato.Push(const pTrans: TParamTransicao);
var
   lIndex: integer;
begin
   if pTrans.SimboloPilhaInsere <> '' then
   begin
     FStrRev := ReverseString(pTrans.SimboloPilhaInsere);
     for FCharInsere in FStrRev do
     begin
       lIndex := Length(FvetIns);
       SetLength(FvetIns, lIndex + 1);
       FvetIns[lIndex] := FCharInsere;
       FPilha.Push(PChar(FvetIns[lIndex]));
     end;
   end;
end;

procedure TAutomato.ProcessaTransicao(const pTransicoes: TListaParamTransicao);
var
   lIndexTran: integer;
   lTrans: TParamTransicao;
begin
   for lIndexTran:= 0 to pred (pTransicoes.Count) do
   begin
      FTopStr := Self.Peek;
      lTrans  := pTransicoes.Items[lIndexTran];

      if (UpperCase(lTrans.SimboloPilhaCompara) = UpperCase(FTopStr)) or
         (lTrans.SimboloPilhaCompara = '') then
      begin
         Self.Pop;
         Self.Push(lTrans);
         FEstadoAtual := TEstado(lTrans.Destino);
         Exit;
      end;
   end;
end;

function TAutomato.Pop: string;
begin
   Result := PChar(FPilha.Pop)^;
   if FPilha.Count = 0 then
   begin
     FPilha.Push(PChar(STACK_GROUND));
   end;
end;

function TAutomato.Peek: string;
begin
   Result := PChar(FPilha.Peek)^;
end;

function TAutomato.EscrevePilha: string;
var
   lIndice: integer;
begin
   Result := '';
   if FPilha.Count > 0 then
   begin
      SetLength(FVetStackShow, 0);

      while FPilha.Count > 0 do
      begin
        lIndice := Length(FVetStackShow);
        SetLength(FVetStackShow, lIndice + 1);
        FVetStackShow[lIndice] := PChar(FPilha.Pop)^;
      end;

      for lIndice := Pred(Length(FVetStackShow)) downto 0 do
      begin
         FPilha.Push(PChar(FVetStackShow[lIndice]));
         Result := Result + FVetStackShow[lIndice];
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

constructor TAutomato.Create;
begin
   inherited Create;
   FEstadosPossiveis := TListaEstado.Create;
   ConfigurarEstados;
   IniciarPilha;
   SetLength(FvetIns, 0);
   SetLength(FVetStackShow, 0);
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
  lTransicoes: TListaParamTransicao;
  lLogPilha: string;
begin
   IniciarPilha;
   FEstadoAtual := FEstadosPossiveis.ItemByID('q0');

   for lCharCadeia in pCadeia do
   begin
     lLogPilha := Self.EscrevePilha;
     if lLogPilha <> EmptyStr then
     begin
        FMemoLogPilha.Lines.Add(lLogPilha);
     end;

     if MatchStr(UnicodeString(lCharCadeia), INPUT_ALPHABET) then
      begin
         lTransicoes := GetTransicaoInput(lCharCadeia, FEstadoAtual);
         try
            if lTransicoes.Count > 0 then
            begin
               ProcessaTransicao(lTransicoes);
            end
            else
            begin
               FEstadoAtual := FEstadosPossiveis.ItemByID('qe');
               break;
            end;
         finally
            lTransicoes.Free;
         end;
      end
      else
      begin
         FEstadoAtual := FEstadosPossiveis.ItemByID('qe');
         Break;
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

