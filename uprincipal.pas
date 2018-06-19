unit uPrincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  uAutomato, uTipos, uConstantes;

type

  { TForm1 }

  TForm1 = class(TForm)
     btnIniciar: TButton;
     btnSelecionaArquivo: TButton;
     edtCaminhoArquivo: TEdit;
     Label1: TLabel;
     openDlg: TOpenDialog;
     procedure btnIniciarClick(Sender: TObject);
     procedure btnSelecionaArquivoClick(Sender: TObject);
     procedure FormCreate(Sender: TObject);
  private
     const
        DESC_EDT_ARQ = 'Selecione o arquivo com as cadeias a serem testadas';
     procedure ValidaArquivo;
     procedure Iniciar;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

procedure TForm1.ValidaArquivo;
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

procedure TForm1.Iniciar;
var
   lAutomato: TAutomato;
   lEstadosP: TVetorEstados;
begin
   SetLength(lEstadosP, 4);

   lEstadosP[0].EstadoFinal:= True;
   lEstadosP[0].Id := 'q0';

   lAutomato := TAutomato.Create(lEstadosP);
   lAutomato.;
end;

procedure TForm1.btnSelecionaArquivoClick(Sender: TObject);
begin
   if openDlg.Execute then
   begin
      edtCaminhoArquivo.Text := openDlg.FileName;
      ValidaArquivo;
   end
   else
   begin
     if edtCaminhoArquivo.Text = '' then
     begin
        edtCaminhoArquivo.Text := DESC_EDT_ARQ;
     end;
   end;
end;

procedure TForm1.btnIniciarClick(Sender: TObject);

begin
   ValidaArquivo;

end;

end.

