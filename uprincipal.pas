unit uPrincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, uAutomato, uConstantes;

type

  { TfrmPrincipal }

  TfrmPrincipal = class(TForm)
     btnIniciar: TButton;
     btnSelecionaArquivo: TButton;
     edtCaminhoArquivo: TEdit;
     Label1: TLabel;
     memoArquivo: TMemo;
     memoLog: TMemo;
     memoPilha: TMemo;
     openDlg: TOpenDialog;
     pnlFundo: TPanel;
     procedure btnIniciarClick(Sender: TObject);
     procedure btnSelecionaArquivoClick(Sender: TObject);
     procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
     procedure FormCreate(Sender: TObject);
  private
     const
        DESC_EDT_ARQ = 'Selecione o arquivo com as cadeias a serem testadas';
     var
        FArquivo: TStringList;
     procedure ValidaArquivo;
     procedure Iniciar;
  public

  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.lfm}

{ TfrmPrincipal }

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin

end;

procedure TfrmPrincipal.ValidaArquivo;
begin
   if not FileExists(edtCaminhoArquivo.Text) then
   begin
     ShowMessage('Arquivo inexistente!');
     Abort;
   end
   else if ExtractFileExt(edtCaminhoArquivo.Text) <> '.txt' then
   begin
     ShowMessage('O arquivo deve ter a extensão txt!');
     edtCaminhoArquivo.Text := DESC_EDT_ARQ;
     Abort;
   end;
end;

procedure TfrmPrincipal.Iniciar;
var
   lAutomato: TAutomato;
   lLinha: String;
begin
   memoLog.Clear;
   lAutomato := TAutomato.Create;
   lAutomato.MemoLogPilha := memoPilha;
   try
      if Assigned(FArquivo) then
      begin
        FArquivo.Clear;
      end
      else
      begin
        FArquivo := TStringList.Create;
      end;

      FArquivo.LoadFromFile(edtCaminhoArquivo.Text);
      for lLinha in FArquivo do
      begin
         memoLog.Lines.Add(lAutomato.Execute(lLinha));
      end;

   finally
     lAutomato.Free;;
   end;
end;

procedure TfrmPrincipal.btnSelecionaArquivoClick(Sender: TObject);
begin
   if openDlg.Execute then
   begin
      edtCaminhoArquivo.Text := openDlg.FileName;
      ValidaArquivo;
      memoArquivo.Lines.LoadFromFile(edtCaminhoArquivo.Text);
   end
   else
   begin
     if edtCaminhoArquivo.Text = '' then
     begin
        edtCaminhoArquivo.Text := DESC_EDT_ARQ;
     end;
   end;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
    if Assigned(FArquivo) then
    begin
       FArquivo.Destroy;
    end;
    CloseAction := caFree;
end;

procedure TfrmPrincipal.btnIniciarClick(Sender: TObject);
begin
   Iniciar;
end;

end.

