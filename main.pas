unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.CheckLst, Vcl.Buttons, Vcl.ExtCtrls, IniFiles, Unit_PW, System.IOUtils, Math,
  VclTee.TeeGDIPlus, VCLTee.TeEngine, VCLTee.Series, VCLTee.TeeProcs, System.Types,
  VCLTee.Chart, System.StrUtils;

const
  OIWidth  = 2600;
  OIHeight = 2200;
  RMax = 5000;
  TraceMax = 1000 ;
type
  TImgData = record
    Data : TData;
    PMax,PMin : double;
  end;
  TFN = array[0..3] of string ;
  TSDataInfo = record
    X,Y:smallint;
    VDir : boolean;
    Connected : boolean;
  end;
  TSPoint = record
    X,Y:smallint;
    Rank : longint;
    BaseP : shortint;
  end;

  TR = record
    Rank : Shortint;
    Coupled : boolean;
    Pathed : array[1..4,0..TraceMax] of TPoint;
    Count : array[1..4] of word;
    Leng : array[1..4] of double;
    ConnectedTo : array[1..4] of word;
  end;

  TRDataInfo = record
    St,Ed:word;
    Dir : byte;
  end;
  TRPoint = record
    X,Y : smallint;
  end;

type
  TForm_main = class(TForm)
    GroupBox3: TGroupBox;
    Panel2: TPanel;
    SB_Help: TSpeedButton;
    SB_ViewInfo: TSpeedButton;
    BB_Proc: TBitBtn;
    CB_Ext: TComboBox;
    CB_AllCK: TCheckBox;
    RB_Proc3: TRadioButton;
    Panel3: TPanel;
    CLB_File: TCheckListBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Memo: TRichEdit;
    SB: TStatusBar;
    Label1: TLabel;
    Edit_FN: TEdit;
    SB_FOpen: TSpeedButton;
    CB_FType: TComboBox;
    Edit_OW: TEdit;
    Label2: TLabel;
    Edit_OH: TEdit;
    Edit_PW: TEdit;
    SB_Copy: TSpeedButton;
    Edit_PH: TEdit;
    Edit_OFFX: TEdit;
    Label3: TLabel;
    Edit_OFFY: TEdit;
    Label4: TLabel;
    Label17: TLabel;
    CB_PT: TComboBox;
    Label18: TLabel;
    Edit_Dig: TEdit;
    UD_Dig: TUpDown;
    CB_Calc_Dist: TCheckBox;
    BB_Calc_Dist: TBitBtn;
    Label10: TLabel;
    CB_M: TComboBox;
    BB_Sort: TBitBtn;
    BB_Connect: TBitBtn;
    CB_FixP: TCheckBox;
    Label8: TLabel;
    Edit_BASE: TEdit;
    CB_Ang: TCheckBox;
    SB_CLR_List: TSpeedButton;
    SG_FixList: TStringGrid;
    Label31: TLabel;
    Edit_PV: TEdit;
    SB_Clear_Pen: TSpeedButton;
    BB_Unwrap: TBitBtn;
    CB_Auto_level: TCheckBox;
    CB_Unwrap: TCheckBox;
    CB_Connect: TCheckBox;
    CB_Sort: TCheckBox;
    GroupBox4: TGroupBox;
    OpenDialog1: TOpenDialog;
    Chart1: TChart;
    Series1: TLineSeries;
    CB_Mon: TCheckBox;
    Panel1: TPanel;
    BB_Load: TBitBtn;
    Edit_ImgNo: TEdit;
    UD_ImgNo: TUpDown;
    BB_Save: TBitBtn;
    BB_Do_Unwrap: TBitBtn;
    BB_Cont: TBitBtn;
    BB_Stop: TBitBtn;
    BB_Step: TBitBtn;
    Edit_End: TEdit;
    Label5: TLabel;
    Edit_ST: TEdit;
    Label7: TLabel;
    BB_Copy_Cond: TBitBtn;
    Label37: TLabel;
    Edit_Dir: TEdit;
    SB_TagList_Reload: TSpeedButton;
    SB_Dir: TSpeedButton;
    BB_STOP_Proc: TBitBtn;
    RB_Compled: TRadioButton;
    Panel4: TPanel;
    CB_Dir2: TCheckBox;
    Bevel1: TBevel;
    RG_Dir: TRadioGroup;
    UD_Base: TUpDown;
    Label6: TLabel;
    Edit_BKFN: TEdit;
    SB_BKFN: TSpeedButton;
    CB_Ser: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SB_FOpenClick(Sender: TObject);
    procedure SB_Clear_PenClick(Sender: TObject);

    procedure Init_PInfo(Sender: TObject);
    procedure Calc_Ph(Sender: TObject);
    procedure Load_Data(Sender: TObject);
    procedure Load_Data_Sub(FN:string;Sender: TObject);
    procedure BB_LoadClick(Sender: TObject);
    procedure UD_ImgNoClick(Sender: TObject; Button: TUDBtnType);

    function CalcDist(Xo,Yo:smallint;mode:byte;BASE:double;CalMode,CalMode2:byte; lAng:boolean):double;
    procedure BB_Calc_DistClick(Sender: TObject);

    procedure SwapInfo(Lo,Hi:Integer);
    procedure QuickSort2(var ldata: array of double; lst, lend: Int64);
    procedure BB_SortClick(Sender: TObject);

    procedure Draw_Unwrapping(Sender: TObject);
    procedure Init_PData(Sender: TObject);
    procedure BB_ConnectClick(Sender: TObject);
    procedure Calc_JP(Sender: TObject);

    procedure Correct_Pi(Sender: TObject);

    procedure BB_UnwrapClick(Sender: TObject);

    procedure BB_Do_UnwrapClick(Sender: TObject);
    procedure BB_SaveClick(Sender: TObject);
    procedure BB_StepClick(Sender: TObject);
    procedure BB_ContClick(Sender: TObject);
    procedure BB_StopClick(Sender: TObject);
    procedure CB_AllCKClick(Sender: TObject);
    procedure CLB_FileClick(Sender: TObject);
    procedure SB_ViewInfoClick(Sender: TObject);

    procedure OpenTag(Sender: TObject);
    procedure WriteProc3(Sender: TObject);
    procedure WriteComped(Sender: TObject);

    procedure BB_Copy_CondClick(Sender: TObject);
    procedure BB_ProcClick(Sender: TObject);
    procedure SB_HelpClick(Sender: TObject);
    procedure SB_DirClick(Sender: TObject);
    procedure SB_TagList_ReloadClick(Sender: TObject);
    procedure BB_STOP_ProcClick(Sender: TObject);
    procedure SB_CLR_ListClick(Sender: TObject);
    procedure SB_BKFNClick(Sender: TObject);
  private
    { Private 宣言 }
  public
    { Public 宣言 }
  end;

var
  Form_main: TForm_main;
  Go : boolean;
  TagFN : string;

  ImgData, BKImgData : array[0..4] of TImgData;
  SData     : array of double;
  SDataInfo : array of TSDataInfo;
  SPoint  : array[0..OIHeight,0..OIWidth] of TSPoint;
  RList   : array[0..OIWidth*OIHeight] of TList;
  PH,PW,PMax,JumpP,RestPJ : longint;

  SIData     : array[0..6] of TData;

  CLMAPParam : double;
  PSPoint : ^TSPoint;

  //領域検索用変数
  SList : TList;
  lPointer  : ^TRPoint;

  EData : array[-1..2100,-1..2100] of boolean;
  InPointer : array[0..OIWidth*OIHeight] of TRPoint;
  TRCP1,TRCP2,PMAPP1,PMAPP2 : double;

  SSData: array[0..2] of double;

  //領域選択、変更ルーチン用の変数 05.03.26
  SelData :array[0..OIHeight,0..OIWidth] of boolean;
  SelPData : array[1..2000000] of TPoint;
  StP : TPoint;
  FirstP : boolean;

implementation

{$R *.dfm}

uses Unit_SAKAS, Unit_ABOUT;

function MyStr(InpV:double;F,S:byte):string;
var
  TmpStr : string;
begin
  Str(InpV:F:S,TmpStr);
  MyStr := TmpStr;
end;

procedure TForm_main.FormCreate(Sender: TObject);
var
  Ini: TIniFile;
  i,j:longint;
begin
  Ini := TIniFile.Create( ChangeFileExt( Application.ExeName, '.INI' ) );
  try
    Top     := Ini.ReadInteger( 'Form_Main', 'Top', 100 );
    Left    := Ini.ReadInteger( 'Form_Main', 'Left', 100 );
    Width   := Ini.ReadInteger( 'Form_Main', 'Width', 750 );
    Height  := Ini.ReadInteger( 'Form_Main', 'Height', 500 );
    if Ini.ReadBool( 'Form_Main', 'InitMax', false ) then
      WindowState := wsMaximized
    else
      WindowState := wsNormal;

    Edit_Dir.Text := Ini.ReadString( 'Param', 'Tag_Dir', '' );

    Edit_OW.Text  := Ini.ReadString( 'Param', 'OW', '1000' );
    Edit_OH.Text  := Ini.ReadString( 'Param', 'OH', '500' );
    Edit_PW.Text  := Ini.ReadString( 'Param', 'PW', '1000' );
    Edit_PH.Text  := Ini.ReadString( 'Param', 'PH', '500' );
    Edit_OFFX.Text  := Ini.ReadString( 'Param', 'OFFX', '0' );
    Edit_OFFY.Text  := Ini.ReadString( 'Param', 'OFFY', '0' );

    Edit_FN.Text  := Ini.ReadString( 'Param', 'FN', '' );
    Edit_BKFN.Text  := Ini.ReadString( 'Param', 'BKFN', '' );
    CB_Ser.Checked := Ini.ReadBool( 'Param', 'Ser', false );

    CB_FType.ItemIndex := Ini.ReadInteger( 'Param', 'File_Format', 2 );
    CB_PT.ItemIndex := Ini.ReadInteger( 'Param', 'Phase_Type', 0 );
    UD_Dig.Position := Ini.ReadInteger( 'Param', 'File_Dig', 0 );

    CB_M.ItemIndex := Ini.ReadInteger( 'Param', 'UnWrap_Method', 1);
    RG_Dir.ItemIndex := Ini.ReadInteger( 'Param', 'UnWrap_Dir', 1);
    Edit_BASE.Text := Ini.ReadString( 'Param', 'UnWrap_Factor', '' );
    Edit_ST.Text := Ini.ReadString( 'Param', 'Start_No', '' );
    Edit_End.Text := Ini.ReadString( 'Param', 'End_No', '' );

    UD_ImgNo.Position :=Ini.ReadInteger( 'Param', 'Img_No', 10 );
  finally
    Ini.Free;
  end;

  for j:=0 to OIHeight-1 do
    for i:=0 to OIWidth do
      RList[j*OIWidth+i] := TList.Create;
  SG_FixList.Cells[0,0] := 'X';
  SG_FixList.Cells[1,0] := 'Y';
  SG_FixList.Cells[2,0] := 'dP';

  New(PSPoint);
  New(lPointer);
  SList := TList.Create;
  SList.Clear;

  SB_Clear_PenClick(Sender);
end;

procedure TForm_main.FormDestroy(Sender: TObject);
var
  Ini: TIniFile;
  i,j:longint;
begin
  for j:=0 to OIHeight-1 do
    for i:=0 to OIWidth do
    begin
      RList[j*OIWidth+i].Clear;
      //RList[j*1030+i].Free;
    end;

  PSPoint := nil;
  Dispose(PSPoint);
  lPointer := nil;
  Dispose(lPointer);
  SList.Clear;
  SList.Free;

  Ini := TIniFile.Create( ChangeFileExt( Application.ExeName, '.INI' ) );
  try
    Ini.WriteInteger( 'Form_Main', 'Top', Top);
    Ini.WriteInteger( 'Form_Main', 'Left', Left);
    Ini.WriteInteger( 'Form_Main', 'Width', Width );
    Ini.WriteInteger( 'Form_Main', 'Height', Height );

    Ini.WriteBool( 'Form_Main', 'InitMax', WindowState = wsMaximized );
    Ini.WriteString( 'Param', 'Tag_Dir', Edit_Dir.Text );

    Ini.WriteString( 'Param', 'OW', Edit_OW.Text );
    Ini.WriteString( 'Param', 'OH', Edit_OH.Text );
    Ini.WriteString( 'Param', 'PW', Edit_PW.Text );
    Ini.WriteString( 'Param', 'PH', Edit_PH.Text );
    Ini.WriteString( 'Param', 'OFFX', Edit_OFFX.Text );
    Ini.WriteString( 'Param', 'OFFY', Edit_OFFY.Text );

    Ini.WriteString( 'Param', 'FN', Edit_FN.Text );
    Ini.WriteString( 'Param', 'BKFN', Edit_BKFN.Text );
    Ini.WriteBool( 'Param', 'Ser', CB_Ser.Checked );

    Ini.WriteInteger( 'Param', 'File_Format', CB_FType.ItemIndex );
    Ini.WriteInteger( 'Param', 'Phase_Type',CB_PT.ItemIndex   );
    Ini.WriteInteger( 'Param', 'File_Dig', UD_Dig.Position );

    Ini.WriteInteger( 'Param', 'UnWrap_Method', CB_M.ItemIndex );
    Ini.WriteInteger( 'Param', 'UnWrap_Dir', RG_Dir.ItemIndex);
    Ini.WriteString( 'Param', 'UnWrap_Factor', Edit_BASE.Text );
    Ini.WriteString( 'Param', 'Start_No', Edit_ST.Text );
    Ini.WriteString( 'Param', 'End_No', Edit_End.Text );

    Ini.WriteInteger( 'Param', 'Img_No', UD_ImgNo.Position );
  finally
    Ini.Free;
  end;
end;

procedure TForm_main.SB_Clear_PenClick(Sender: TObject);
var
  i,j:longint;
begin
  FirstP := true;
  for j:=0 to PH-1 do
    for i:=0 to PW-1 do
      SelData[j,i] := false;
end;

procedure TForm_main.SB_CLR_ListClick(Sender: TObject);
var
  i,j:longint;
begin
  for j:=1 to SG_FixList.RowCount-1 do
    for i:=0 to SG_FixList.ColCount-1 do
      SG_FixList.Cells[i,j] := '';
  SG_FixList.Cells[1,1] := '';

end;

procedure TForm_main.SB_DirClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Edit_Dir.Text := ExtractFilePath(OpenDialog1.FileName);
    SB_TagList_ReloadClick(Sender);
  end;
end;

procedure TForm_main.SB_FOpenClick(Sender: TObject);
var
  TmpStr,lStr :string;
  li:longint;
begin
  if OpenDialog1.Execute then
  begin
    if CB_Ser.Checked then
    begin
      TmpStr := OpenDialog1.FileName;
      lStr := '';
      li:=Length(TmpStr);
      while (TmpStr[li]<>'_') and (li>0) do
      begin
        lStr := TmpStr[li]+lStr;
        Dec(li);
      end;
      Edit_FN.Text := Copy(TmpStr,1,li);
    end
    else
      Edit_FN.Text := OpenDialog1.FileName;
  end;
end;

procedure TForm_main.SB_BKFNClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
    Edit_BKFN.Text := OpenDialog1.FileName;
end;




procedure TForm_main.SB_HelpClick(Sender: TObject);
begin
  AboutBox.ShowModal;
end;

procedure TForm_main.SB_TagList_ReloadClick(Sender: TObject);
var
  Path: String;
  FileList: TStringDynArray;
  FileName: String;
begin
  if Edit_Dir.Text<>'' then
  begin
    CLB_File.Items.Clear;
    Path := ExtractFilePath(Edit_Dir.Text);

    FileList := TDirectory.GetFiles(Path, CB_Ext.Items[CB_Ext.ItemIndex] , TSearchOption.soTopDirectoryOnly);
    for FileName in FileList do
    begin
      CLB_File.Items.Add(FileName);
    end;
  end;

end;

procedure TForm_main.Init_PInfo(Sender: TObject);
begin
  Form_PW.PW := StrToInt(Edit_PW.Text);
  Form_PW.PH := StrToInt(Edit_PH.Text);
  Form_PW.OW := StrToInt(Edit_OW.Text);
  Form_PW.OH := StrToInt(Edit_OH.Text);
  Form_PW.OFFX := StrToInt(Edit_OFFX.Text);
  Form_PW.OFFY := StrToInt(Edit_OFFY.Text);

  PW := Form_PW.PW;
  PH := Form_PW.PH;

  Finalize(SData);
  Finalize(SDataInfo);

  SetLength(SData,(PW+1)*(PH+1)*2);
  Memo.Lines.Add('Length of SData :'+High(SData).ToString);

  SetLength(SDataInfo,(PW+1)*(PH+1)*2);
end;


procedure TForm_main.Calc_Ph(Sender: TObject);
var
  i,j:longint;
  Re, Im, BKRe, BKIm, Re2, Im2, Amp, Phase, BKAmp, BKPh:double;
begin
  //re&im
  if Edit_BKFN.Text = '' then
  begin
    if CB_PT.ItemIndex=0 then
    begin
      for j:=0 to PH-1 do
        for i:=0 to PW-1 do
        begin
          Re := ImgData[1].Data[j,i];
          Im := ImgData[2].Data[j,i];
          ImgData[1].Data[j,i] := ArcTan2(Re,Im);
          ImgData[2].Data[j,i] := Sqrt(Sqr(Re)+Sqr(Im));
          ImgData[0].Data[j,i] := ImgData[1].Data[j,i];
        end;
    end
    else
    begin
      for j:=0 to PH-1 do
        for i:=0 to PW-1 do
          ImgData[0].Data[j,i] := ImgData[1].Data[j,i];
    end;
  end
  else
  begin
    if CB_PT.ItemIndex=0 then
    begin
      for j:=0 to PH-1 do
        for i:=0 to PW-1 do
        begin
          Re := ImgData[1].Data[j,i];
          Im := ImgData[2].Data[j,i];
          BKRe := BKImgData[1].Data[j,i];
          BKIm := BKImgData[2].Data[j,i];

          if (Sqr(BKRe)+Sqr(BKIm))<>0 then
          begin
            Re2 := (Re*BKRe+Im*BKIm)/(Sqr(BKRe)+Sqr(BKIm));
            Im2 := (Im*BKRe-Re*BKIm)/(Sqr(BKRe)+Sqr(BKIm));
          end
          else
          begin
            Re2 :=0;
            Im2 :=0;
          end;

          ImgData[1].Data[j,i] := ArcTan2(Re2,Im2);
          ImgData[2].Data[j,i] := Sqrt(Sqr(Re2)+Sqr(Im2));
          ImgData[0].Data[j,i] := ImgData[1].Data[j,i];
        end;
    end
    else
    begin
      for j:=0 to PH-1 do
        for i:=0 to PW-1 do
        begin
          Amp := ImgData[2].Data[j,i];
          Phase := ImgData[1].Data[j,i];
          Re := Amp*Cos(Phase);
          Im := Amp*Sin(Phase);

          BKAmp := BKImgData[2].Data[j,i];
          BKPh := BKImgData[1].Data[j,i];
          BKRe := BKAmp*Cos(BKPh);
          BKIm := BKAmp*Sin(BKPh);

          if (Sqr(BKRe)+Sqr(BKIm))<>0 then
          begin
            Re2 := (Re*BKRe+Im*BKIm)/(Sqr(BKRe)+Sqr(BKIm));
            Im2 := (Im*BKRe-Re*BKIm)/(Sqr(BKRe)+Sqr(BKIm));
          end;

          ImgData[1].Data[j,i] := ArcTan2(Re2,Im2);
          ImgData[2].Data[j,i] := Sqrt(Sqr(Re2)+Sqr(Im2));
          ImgData[0].Data[j,i] := ImgData[1].Data[j,i];
        end;
    end;
  end;

end;

procedure TForm_main.Load_Data_Sub(FN:string;Sender: TObject);
begin
  if CB_FType.ItemIndex =0 then
  begin
    if CB_PT.ItemIndex=0 then
      begin
      Form_PW.Load_SglData(FN+'.re',Sender);
      ImgData[1].Data := Form_PW.PData;
      Form_PW.Load_SglData(FN+'.im',Sender);
      ImgData[2].Data := Form_PW.PData;
    end
    else
    begin
      Form_PW.Load_SglData(FN+'.amp',Sender);
      ImgData[2].Data := Form_PW.PData;
      Form_PW.Load_SglData(FN+'.ph',Sender);
      ImgData[1].Data := Form_PW.PData;
    end;
  end
  else
  begin
    if CB_PT.ItemIndex=0 then
    begin
      Form_PW.Load_Data(FN+'.re',Sender);
      ImgData[1].Data := Form_PW.PData;
      Form_PW.Load_Data(FN+'.im',Sender);
      ImgData[2].Data := Form_PW.PData;
    end
    else
    begin
      Form_PW.Load_Data(FN+'.amp',Sender);
      ImgData[2].Data := Form_PW.PData;
      Form_PW.Load_Data(FN+'.ph',Sender);
      ImgData[1].Data := Form_PW.PData;
    end;
  end;
end;

procedure TForm_main.Load_Data(Sender: TObject);
var
  BFN, BKBFN : string;
begin
  Init_PInfo(Sender);

  if CB_Ser.Checked then
  begin
    if Edit_ImgNo.Text<>'' then
      BFN := Edit_FN.Text+UD_ImgNo.Position.ToString
    else
      BFN := Edit_FN.Text;
  end
  else
  begin
    BFN := Edit_FN.Text;
    BKBFN := Edit_BKFN.Text;
  end;

  if BKBFN<>'' then
  begin
    Load_Data_Sub(BKBFN,Sender);
    BKImgData := ImgData;
  end;

  Load_Data_Sub(BFN,Sender);

  Calc_PH(Sender);

  Form_PW.PData := ImgData[0].Data;

  SIData[1] := ImgData[1].Data;
  SIData[2] := ImgData[2].Data;
  SIData[3] := ImgData[3].Data;
  SIData[4] := ImgData[4].Data;
end;



procedure TForm_main.BB_LoadClick(Sender: TObject);
begin
  Load_Data(Sender);
  Form_PW.Edit_PMin.Text := '-3.14';
  Form_PW.Edit_PMax.Text := '3.14';

  Form_PW.Draw_Data(Sender);
  Form_PW.Show;
end;


procedure TForm_main.UD_ImgNoClick(Sender: TObject; Button: TUDBtnType);
begin
  BB_LoadClick(Sender);
end;






//*******************************************************
//***************位相差計算ルーチン********************
//*******************************************************
//複素空間の距離を計算

procedure InitSData;
var
  i:longint;
begin
  for i:=0 to PW*PH*2-1 do
  begin
    SData[i] := 1e10;
    SDataInfo[i].X := 0;
    SDataInfo[i].Y := 0;
    SDataInfo[i].VDir := false;
    SDataInfo[i].Connected := false;
  end;
end;
function TForm_main.CalcDist(Xo, Yo: smallint; mode: byte; BASE: double;
  CalMode, CalMode2: byte; lAng:boolean): double;
var
  X1,X2,X3,Y1,Y2,Y3 : word;
  d1,d2,d3,d4,ro,r1,r2,r3,io,i1,i2,i3,ang,Dist,r:double;
begin
  Dist := 0;
  if mode=1 then
  begin
    X1 := Xo+1;
    X2 := Xo+1;
    X3 := Xo+1;
    Y1 := Yo-1;
    Y2 := Yo;
    Y3 := Yo+1;
    {X1 := Xo+1;   //サイノグラム用斜め
    X2 := Xo+1;
    X3 := Xo;
    Y1 := Yo;
    Y2 := Yo+1;
    Y3 := Yo+1;}
  end
  else
  begin
    X1 := Xo-1;
    X2 := Xo;
    X3 := Xo+1;
    Y1 := Yo+1;
    Y2 := Yo+1;
    Y3 := Yo+1;
    {X1 := Xo-1;   //サイノグラム用斜め
    X2 := Xo-1;
    X3 := Xo;
    Y1 := Yo;
    Y2 := Yo+1;
    Y3 := Yo+1;}
  end;

  case CalMode of
    0:begin
        ro := ImgData[2].Data[Yo,Xo]*cos(ImgData[1].Data[Yo,Xo]);
        r1 := ImgData[2].Data[Y1,X1]*cos(ImgData[1].Data[Y1,X1]);
        r2 := ImgData[2].Data[Y2,X2]*cos(ImgData[1].Data[Y2,X2]);
        r3 := ImgData[2].Data[Y3,X3]*cos(ImgData[1].Data[Yo,X3]);

        io := ImgData[2].Data[Yo,Xo]*sin(ImgData[1].Data[Yo,Xo]);
        i1 := ImgData[2].Data[Y1,X1]*sin(ImgData[1].Data[Y1,X1]);
        i2 := ImgData[2].Data[Y2,X2]*sin(ImgData[1].Data[Y2,X2]);
        i3 := ImgData[2].Data[Y3,X3]*sin(ImgData[1].Data[Yo,X3]);

        d1 := 0.5*Sqrt(Sqr(ro-r1)+Sqr(io-i1));
        d2 :=     Sqrt(Sqr(ro-r2)+Sqr(io-i2));
        d3 := 0.5*Sqrt(Sqr(ro-r3)+Sqr(io-i3));
        Dist := (d1+d2+d3)/3;
      end;
    1:begin
        ro := 1/(ImgData[2].Data[Yo,Xo]*cos(ImgData[1].Data[Yo,Xo])+BASE);
        r1 := 1/(ImgData[2].Data[Y1,X1]*cos(ImgData[1].Data[Y1,X1])+BASE);
        r2 := 1/(ImgData[2].Data[Y2,X2]*cos(ImgData[1].Data[Y2,X2])+BASE);
        r3 := 1/(ImgData[2].Data[Y3,X3]*cos(ImgData[1].Data[Yo,X3])+BASE);

        io := 1/(ImgData[2].Data[Yo,Xo]*sin(ImgData[1].Data[Yo,Xo])+BASE);
        i1 := 1/(ImgData[2].Data[Y1,X1]*sin(ImgData[1].Data[Y1,X1])+BASE);
        i2 := 1/(ImgData[2].Data[Y2,X2]*sin(ImgData[1].Data[Y2,X2])+BASE);
        i3 := 1/(ImgData[2].Data[Y3,X3]*sin(ImgData[1].Data[Yo,X3])+BASE);

        d1 := 0.5*Sqrt(Sqr(ro-r1)+Sqr(io-i1));
        d2 :=     Sqrt(Sqr(ro-r2)+Sqr(io-i2));
        d3 := 0.5*Sqrt(Sqr(ro-r3)+Sqr(io-i3));
        Dist := (d1+d2+d3)/3;
      end;
    2,3,4:
      begin
        d1 :=ImgData[2].Data[Yo,Xo];
        d2 :=ImgData[2].Data[Y1,X1];
        d3 :=ImgData[2].Data[Y2,X2];
        d4 :=ImgData[2].Data[Y3,X3];
        ang := Abs(ImgData[1].Data[Yo,Xo]-ImgData[1].Data[Y2,X2]);
        if ang>Pi then ang := 2*Pi-ang;
        if d1+d3+0.2*d2+0.2*d4<>0 then
          case CalMode of
            2:if lAng then
                Dist := ang
              else
                Dist := 1;
            3:if lAng then
                Dist := ang/(d1+d3+0.2*d2+0.2*d4)
              else
                Dist := 1/(d1+d3+0.2*d2+0.2*d4);
            4:if lAng then
                Dist := ang*abs(d3-d1)/(d1+d3+0.2*d2+0.2*d4)
              else
                Dist := abs(d3-d1)/(d1+d3+0.2*d2+0.2*d4);
          end
        else
          Dist := 100;
      end;
    5:begin
        d1 := (ImgData[2].PMax-ImgData[2].Data[Yo,Xo])/(ImgData[2].PMax-ImgData[2].PMin);
        d2 := (ImgData[2].PMax-ImgData[2].Data[Y1,X1])/(ImgData[2].PMax-ImgData[2].PMin);
        d3 := (ImgData[2].PMax-ImgData[2].Data[Y2,X2])/(ImgData[2].PMax-ImgData[2].PMin);
        d4 := (ImgData[2].PMax-ImgData[2].Data[Y3,X3])/(ImgData[2].PMax-ImgData[2].PMin);
        ang := Abs(ImgData[1].Data[Yo,Xo]-ImgData[1].Data[Y2,X2]);
        if ang>Pi then ang := 2*Pi-ang;
        if lAng then
          Dist := ang*(d1+d3+0.2*d2+0.2*d4)
        else
          Dist := (d1+d3+0.2*d2+0.2*d4)
      end;
    6:begin
        d1 := (ImgData[2].PMax-ImgData[2].Data[Yo,Xo]);
        d2 := (ImgData[2].PMax-ImgData[2].Data[Y1,X1]);
        d3 := (ImgData[2].PMax-ImgData[2].Data[Y2,X2]);
        d4 := (ImgData[2].PMax-ImgData[2].Data[Y3,X3]);
        ang := Abs(ImgData[1].Data[Yo,Xo]-ImgData[1].Data[Y2,X2]);
        if ang>Pi then ang := 2*Pi-ang;
        if lAng then
          Dist := Power(ang,0.35)*(Ln(d1+1)+Ln(d3+1)+0.2*Ln(d2+1)+0.2*Ln(d4+1))
        else
          Dist := (Ln(d1+1)+Ln(d3+1)+0.2*Ln(d2+1)+0.2*Ln(d4+1));
      end;
  end;
  r:=PW/PH;
  case CalMode2 of
    6://像の中心から行う
      Dist := Dist*(0.01+Sqrt(Sqr(Xo-PW div 2)+Sqr(Yo-PH div 2)))/
                      Sqrt(Sqr(PW div 2)+Sqr(PH div 2));
    2://像の左から行う
      Dist := Dist*(1+Xo);
    10://像の右から行う
      Dist := Dist*(1+(PW-Xo));
    4://像の上から行う
      Dist := Dist*(1+Yo/30);
    8://像の下から行う
      Dist := Dist*(1+(PH-Yo)/30);

//    6://像の横中心から行う
//      Dist := Dist*(1+Abs(PW/2-Xo));

    7://像の下横中心から行う
//      Dist := Dist*(1+Base*{Sqrt}({Sqr}Abs(PW/2-Xo)+{Sqr}(PH-Yo)*r));
      Dist := Dist*(1+Base*Sqrt(Sqr(PW/2-Xo)+Sqr(PH-Yo)));
    5://像の上横中心から行う
      Dist := Dist*(1+Base*{Sqrt}({Sqr}Abs(PW/2-Xo)+{Sqr}(Yo)*r));

    3://像の左下から行う
      Dist := Dist*(1+Base*(Xo+(PH-Yo)*r));
    9://像の右上から行う
      Dist := Dist*(1+Base*((PW-Xo)+Yo*r));
    1://像の左上から行う
      Dist := Dist*(1+Base*(Xo+Yo*r));
    11://像の右下から行う
      Dist := Dist*(1+Base*((PW-Xo)+(PH-Yo)*r));
  end;

  Dist := ImgData[3].Data[Yo,Xo]*Dist;
  CalcDist := Dist;
  ImgData[4].Data[Yo,Xo] := Dist;
end;

procedure TForm_main.BB_Calc_DistClick(Sender: TObject);
var
  i,j, lDir, lMode:longint;
  lMax,TmpDbl{,Ratio},Base: double;
  lAng : boolean;
begin
  //位相ジャンプ重み関数の初期化
  for j:=0 to PH-1 do
    for i:=0 to PW-1 do
      ImgData[3].Data[j,i] := 1;

  SB.Panels[1].Text := 'Calc Distance ';
  Application.ProcessMessages;
  lMax := 0;
  lMode :=CB_M.ItemIndex;
  if CB_Dir2.Checked then
    lDir := RG_Dir.ItemIndex+1
  else
    lDir := 0;
  Base := UD_Base.Position;
  lAng := CB_Ang.Checked;

  InitSData;

  for j:=1 to PH-2 do
    for i:=0 to PW-2 do
    begin
      TmpDbl := CalcDist(i,j,1,Base,lMode,lDir,lAng);
      if TmpDbl>lMax then lMax := TmpDbl;
      SData[i+(j-1)*PW] := TmpDbl;
      SDataInfo[i+(j-1)*PW].X := i;
      SDataInfo[i+(j-1)*PW].Y := j;
      SDataInfo[i+(j-1)*PW].VDir := false;
    end;
  for j:=0 to PH-2 do
    for i:=1 to PW-2 do
    begin
      TmpDbl := CalcDist(i,j,2,Base,lMode,lDir,lAng);
      if TmpDbl>lMax then lMax := TmpDbl;
      SData[i+j*PW+PH*PW] := TmpDbl;
      SDataInfo[i+j*PW+PH*PW].X := i;
      SDataInfo[i+j*PW+PH*PW].Y := j;
      SDataInfo[i+j*PW+PH*PW].VDir := true;
    end;
  Label10.Caption := 'Max Diff : '+FloatToStr(lMax);
end;

//*******************************************************
//*****************ソート計算ルーチン********************
//*******************************************************

procedure TForm_Main.SwapInfo(Lo, Hi: Integer);
var
  lSDataInfo : TSDataInfo;
begin
  lSDataInfo := SDataInfo[Lo];
  SDataInfo[Lo] := SDataInfo[Hi];
  SDataInfo[Hi] := lSDataInfo;
end;


procedure TForm_main.QuickSort2(var ldata: array of double; lst, lend: Int64);
var
  i,j: Int64;
  t,n : double;
begin
  repeat
    i := lst;
    j := lend;
    n := ldata[(i+j) div 2];	 	// 比較の基準値を配列の中央の値に設定
    repeat
      while ldata[i] < n do			// 配列の昇順に、基準値より大きい値を検索
        Inc(i);
      while ldata[j] > n do			// 配列の降順に、基準値より小さい値を検索
          Dec(j);
      if i <= j then					// 入れ替え
      begin
        t := ldata[i];
        ldata[i] := ldata[j];
        ldata[j] := t;
        SwapInfo(i,j);
        Inc(i);
        Dec(j);
      end;
    until i > j;					// iとjが交差するまで繰り返す
    if lst < j then				// 開始よりも降順に検索したjが大きい場合、
      QuickSort2(ldata,lst,j);				// QuickSort2を実行
    lst := i;						// 先頭位置を更新
  until i >= lend;					// ここまでの手順を昇順に検索したiが終了値
end;

procedure TForm_main.BB_SortClick(Sender: TObject);
begin
  SB.Panels[1].Text := 'Sorting...';
  Application.ProcessMessages;

  QuickSort2(SData, Low(SData), High(SData));
  PMax := PW*PH*2-PW*2-PH*2;

  SB.Panels[1].Text := '';
end;



//*******************************************************
//***************アンラップ計算ルーチン******************
//*******************************************************

procedure TForm_main.Draw_Unwrapping(Sender: TObject);
var
  i,j:longint;
begin
  for j:=0 to PH-1 do
    for i:=0 to PW-1 do
      ImgData[0].Data[j,i] := SPoint[j,i].BaseP ;
  SIData[5] := ImgData[0].Data;
  Form_PW.UD_Tpro.Position := 5;
  Form_PW.PData := SIData[5];
  Form_PW.Draw_Data(Sender);
end;


procedure TForm_main.Init_PData(Sender: TObject);
var
  i,j,lx,ly,lxo,lyo:longint;
begin
  for j:=0 to PH-1 do
    for i:=0 to PW-1 do
    begin
      SPoint[j,i].X := i;
      SPoint[j,i].Y := j;
      SPoint[j,i].BaseP := 0;
      SPoint[j,i].Rank :=j*PW+i;
      RList[j*PW+i].Clear;
      RList[j*PW+i].Add(Addr(SPoint[j,i]));
    end;
  if (SG_FixList.Cells[0,1] <>'') and (CB_FixP.Checked) then
  begin
    lxo := StrToInt(SG_FixList.Cells[0,1]);
    lyo := StrToInt(SG_FixList.Cells[1,1]);
    for i:=2 to SG_FixList.RowCount-1 do
    begin
      if SG_FixList.Cells[0,i] <>'' then
      begin
        lx := StrToInt(SG_FixList.Cells[0,i]);
        ly := StrToInt(SG_FixList.Cells[1,i]);
        SPoint[ly,lx].Rank := SPoint[lyo,lxo].Rank;
        SPoint[ly,lx].BaseP := SPoint[lyo,lxo].BaseP+StrToInt(SG_FixList.Cells[2,i]);
        RList[lyo*PW+lxo].Add(Addr(SPoint[ly,lx]));
        RList[ly*PW+lx].Clear;
      end;
    end;
  end;
end;

function ExCalcdP(P1,P2,A1,A2,dPMax:double):longint;
var
  ldP{,dA} : double;
  lBase : shortint;
begin
  ldP := P1-P2;
  lBase := 0;

  if Abs(ldP)<Pi then
    ExCalcdP := lBase
  else
    if ldP>0 then
      ExCalcdP := 1+lBase
    else
      ExCalcdP := -1+lBase;
end;

function GetPJump(CX,CY,NCX,NCY:word;Mode:longint;dPMax:double):integer;
var
  P1,P2,Abs1,Abs2 : double;
begin
  P1 := ImgData[1].Data[CY,CX];
  P2 := ImgData[1].Data[NCY,NCX];
  Abs1 := ImgData[2].Data[CY,CX];
  Abs2 := ImgData[2].Data[NCY,NCX];
  GetPJump := ExCalcdP(P1,P2,Abs1,Abs2,dPMax);
end;

procedure PConnect(i:longint;dPMax:double;Mode:byte);
var
  CX,CY,NX,NY:word;
  li,OldRank,NewRank,PJump:longint;
begin
  CX := SDataInfo[i].X;
  CY := SDataInfo[i].Y;
  begin
    if SDataInfo[i].VDir then
    begin
      NX := CX;
      NY := CY+1;
    end
    else
    begin
      NX := CX+1;
      NY := CY;
    end;
    OldRank :=SPoint[NY,NX].Rank;
    NewRank :=SPoint[CY,CX].Rank;
    if (SPoint[NY,NX].Rank<>SPoint[CY,CX].Rank) then
    begin
      PJump := GetPJump(CX,CY,NX,NY,i,dPMax)+(SPoint[CY,CX].BaseP-SPoint[NY,NX].BaseP);
      if RList[OldRank].Count>RList[NewRank].Count then
      begin
        li := OldRank;
        OldRank := NewRank;
        NewRank := li;
        PJump := -PJump;
      end;
      for li:=1 to RList[OldRank].Count do
      begin
        PSPoint := RList[OldRank].Items[li-1];
        SPoint[PSPoint^.Y,PSPoint^.X].Rank := NewRank;
        SPoint[PSPoint^.Y,PSPoint^.X].BaseP :=SPoint[PSPoint^.Y,PSPoint^.X].BaseP+PJump;
        RList[NewRank].Add(RList[OldRank].Items[li-1]);
      end;
      RList[OldRank].Clear;
    end;
    SDataInfo[i].Connected := true;
  end;;
end;


procedure TForm_main.BB_ConnectClick(Sender: TObject);
var
  i:longint;
  dPMax : double;
begin
  Init_PData(Sender);
  dPMax := {StrToFloat(Edit_DPMAX.Text)}10000;
  i:=0;
  repeat
    PConnect(i,dPMax,0);
    Inc(i);
    if ((i mod 100000 =0) and (CB_Mon.Checked)) then
    begin
      SB.Panels[1].Text := 'Connecting : '+IntToStr(i);
      Draw_Unwrapping(Sender);
    end;
    if not(Go) then Exit;
    Application.ProcessMessages;
  until (i>={PMax}PW*PH*2) {or (SData[i]>dPMax)};
  if CB_Mon.Checked then
    Draw_Unwrapping(Sender);
  SB.Panels[0].Text := '';
end;

procedure TForm_main.Calc_JP(Sender: TObject);
var
  i,j:longint;
begin
  JumpP := 0;
  for j:=0 to PH-2 do
    for i:=0 to PW-2 do
      if (Abs(ImgData[0].Data[j,i] - ImgData[0].Data[j,i+1])>Pi) then
        Inc(JumpP);
end;


procedure TForm_main.Correct_Pi(Sender: TObject);
var
  i,j,k :longint;
  TmpPh : double;
  ROI  : longint;
begin
  TmpPh := 0;
  ROI := 20;
  for j:=1 to ROI do
    for i:=1 to ROI do
      TmpPh := TmpPh+Form_PW.PData[j,i];
  TmpPh := TmpPh / ((ROI)*(ROI));
  k := Round(TmpPh / (2*Pi));
  for j:=0 to PH-1 do
    for i:=0 to PW-1 do
      Form_PW.PData[j,i] := Form_PW.PData[j,i]-k*2*Pi;
end;


procedure TForm_main.BB_UnwrapClick(Sender: TObject);
var
  i,j:longint;
begin
  for j:=0 to PH-1 do
    for i:=0 to PW-1 do
      ImgData[0].Data[j,i] := ImgData[1].Data[j,i]+SPoint[j,i].BaseP*2*Pi;

  SIData[6] :=  ImgData[0].Data;
  Form_PW.PData :=  SIData[6] ;
  Form_PW.UD_Tpro.Position := 6;

  Correct_Pi(Sender);

  if CB_Auto_level.Checked then
    Form_PW.Get_PMinMax;

  Form_PW.Draw_Data(Sender);
  Application.ProcessMessages;
  for j:=0 to PH-1 do
    for i:=0 to PW-1 do
      RList[j*OIWidth+i].Clear;

end;

procedure TForm_main.BB_Do_UnwrapClick(Sender: TObject);
begin
  Go := true;

  if CB_Calc_Dist.Checked then
    BB_Calc_DistClick(Sender);
  if CB_Sort.Checked then
    BB_SortClick(Sender);
  if CB_Connect.Checked then
    BB_ConnectClick(Sender);
  if CB_Unwrap.Checked then
    BB_UnwrapClick(Sender);
  Calc_JP(Sender);
  Memo.Lines.Add(TimeToStr(Now)+','+UD_ImgNo.Position.ToString+', '+JumpP.ToString);
end;

procedure TForm_main.BB_SaveClick(Sender: TObject);
var
  BFN, BDir : string;
begin
  if CB_Ser.Checked then
  begin
    if Edit_ImgNo.Text<>'' then
    begin
      BFN := Edit_FN.Text;
      Bdir := TDirectory.GetParent(TDirectory.GetParent(ExtractFilePath(BFN)))+'\uw';
      if not(TDirectory.Exists(BDir)) then
        MkDir(BDir);
      Form_PW.Save_Data(BDir+'\'+ExtractFileName(BFN)+'u_'+Edit_ImgNo.Text,Sender);
    end
    else
      Form_PW.Save_Data(Edit_FN.Text+'_u',Sender);
  end
  else
    Form_PW.Save_Data(Edit_FN.Text+'_u',Sender);
end;


procedure TForm_main.BB_StepClick(Sender: TObject);
var
  BFN, BDir : string;
begin
  BFN := Edit_FN.Text;
  Bdir := TDirectory.GetParent(TDirectory.GetParent(ExtractFilePath(BFN)))+'\uw';
  if not(TDirectory.Exists(BDir)) then
    MkDir(BDir);
  UD_ImgNo.Position := UD_ImgNo.Position;
  BB_LoadClick(Sender);
  BB_Do_UnwrapClick(Sender);
  Form_PW.Save_Data(BDir+'\'+ExtractFileName(BFN)+'u_'+UD_ImgNo.Position.ToString,Sender);
  UD_ImgNo.Position := UD_ImgNo.Position+1;
end;

procedure TForm_main.BB_ContClick(Sender: TObject);
var
  i,j,k:longint;
  BFN, BDir : string;
begin
  PSPoint := nil;
  Dispose(PSPoint);
  New(PSPoint);

  lPointer := nil;
  Dispose(lPointer);
  New(lPointer);

  SList.Clear;

  SB_Clear_PenClick(Sender);
  for j:=0 to OIHeight-1 do
    for i:=0 to OIWidth do
      RList[j*OIWidth+i].Clear;

  Series1.Clear;
  Memo.Lines.Clear;
  Memo.Lines.Add('Unwrapping... ');
  Memo.Lines.Add('Method : '+CB_M.ItemIndex.ToString);
  Memo.Lines.Add('Dir : '+RG_Dir.ItemIndex.ToString);
  Memo.Lines.Add('Dir Power : '+Edit_Base.Text);
  Memo.Lines.Add('Fix Connection : '+CB_FixP.Checked.ToString);

  if (SG_FixList.Cells[0,1] <>'') and (CB_FixP.Checked) then
  begin
    for i:=1 to SG_FixList.RowCount-1 do
    begin
      if SG_FixList.Cells[0,i] <>'' then
        Memo.Lines.Add(SG_FixList.Cells[0,i]+','+SG_FixList.Cells[1,i]+','+SG_FixList.Cells[2,i]);
    end;
  end;

  Go := true;
  BFN := Edit_FN.Text;
  Bdir := TDirectory.GetParent(TDirectory.GetParent(ExtractFilePath(BFN)))+'\uw';
  if not(TDirectory.Exists(BDir)) then
    MkDir(BDir);

  for k:= StrToInt(Edit_ST.Text) to StrToInt(Edit_End.Text) do
  begin
    SB.Panels[0].Text := 'Unwrapping : '+k.ToString;
    Application.ProcessMessages;

    UD_ImgNo.Position := k;
    Load_Data(Sender);
    BB_Do_UnwrapClick(Sender);
    if not(Go) then
      exit;

    Calc_JP(Sender);
    Series1.AddXY(k,JumpP);

    Form_PW.Save_Data(BDir+'\'+ExtractFileName(BFN)+'u_'+k.ToString,Sender);
  end;

  Memo.Lines.SaveToFile(BDir+'\'+ExtractFileName(BFN)+'_memo.txt');
  //ShowMessage('Unwrapping Completed!');

  WriteProc3(Sender);
end;

procedure TForm_main.BB_StopClick(Sender: TObject);
begin
  Go := false;
end;








procedure TForm_main.BB_STOP_ProcClick(Sender: TObject);
var
  li:longint;
begin
  for li:=0 to CLB_File.Items.Count-1 do
    CLB_File.Checked[li] := false;
  Go := false;
end;

procedure TForm_main.CB_AllCKClick(Sender: TObject);
var
  li:longint;
begin
  for li:=0 to CLB_File.Items.Count-1 do
    CLB_File.Checked[li] := CB_AllCK.Checked;
end;

procedure TForm_main.CLB_FileClick(Sender: TObject);
begin
  TagFN :=  CLB_File.Items[CLB_File.ItemIndex];
  OpenTag(Sender);
  if Form_SAKAS.Showing then
    SB_ViewInfoClick(Sender);
end;

procedure TForm_main.SB_ViewInfoClick(Sender: TObject);
begin
  if CLB_File.ItemIndex>=0 then
  begin
    Form_SAKAS.Tag_FN := CLB_File.Items[CLB_File.ItemIndex];
    if Form_SAKAS.Tag_FN<>'' then
      Form_SAKAS.Load_Karte(Form_SAKAS.Tag_FN,Sender);
  end;
  Form_SAKAS.Show;
end;

procedure TForm_main.BB_ProcClick(Sender: TObject);
var
  li:longint;
begin
  for li:=0 to CLB_File.Items.Count-1 do
  begin
    CLB_File.ItemIndex := li;
    CLB_FileClick(Sender);
    if CLB_File.Checked[li] then
    begin
      TagFN :=  CLB_File.Items[CLB_File.ItemIndex];
      OpenTag(Sender);
      BB_ContClick(Sender);
      WriteProc3(Sender);
      CLB_File.Checked[li] := false;
    end;
  end;
end;

procedure TForm_main.OpenTag(Sender: TObject);
var
  Ini: TIniFile;
  TmpStr : string;
begin
  RB_Proc3.Checked := false;
  RB_Compled.Checked:=false;
  Edit_FN.Text := '';

  if UpperCase(ExtractFileExt(TagFN)) = '.TAG' then
  begin
    Ini := TIniFile.Create(TagFN);
    try
      TmpStr := Ini.ReadString('Proc_2','File_Name','');
      TmpStr := ReplaceStr(TmpStr,'*','');

      if TmpStr<>'' then
      begin
        TmpStr[1] := TagFN[1];
        Edit_FN.Text := TmpStr;

        Edit_OW.Text := IntToStr(Ini.ReadInteger( 'Proc_2', 'Width', 2048));
        Edit_OH.Text := IntToStr(Ini.ReadInteger( 'Proc_2', 'Height', 2048));
        Edit_ST.Text := IntToStr(Ini.ReadInteger( 'Proc_2', 'Sino_ST', 0));
        Edit_End.Text := IntToStr(Ini.ReadInteger( 'Proc_2', 'Sino_End', 1000));
        CB_FType.ItemIndex := Ini.ReadInteger( 'Proc_2', 'Format', 3)-2;

        //Proc_3_Data
        if Ini.SectionExists('Proc_3') then
          RB_Proc3.Checked := true;
        if Ini.ValueExists('Proc_3', 'Width') then
          Edit_PW.Text := IntToStr(Ini.ReadInteger( 'Proc_3', 'Width', 2048))
        else
          Edit_PW.Text := Edit_OW.Text;

        if Ini.ValueExists('Proc_3', 'Height') then
          Edit_PH.Text := IntToStr(Ini.ReadInteger( 'Proc_3', 'Height', 2048))
        else
          Edit_PH.Text := Edit_OH.Text;

        if Ini.ValueExists('Proc_3', 'Offset_X') then
          Edit_OFFX.Text := IntToStr(Ini.ReadInteger( 'Proc_3', 'Offset_X', 0))
        else
          Edit_OFFX.Text := '0';

        if Ini.ValueExists('Proc_3', 'Offset_Y') then
          Edit_OFFY.Text := IntToStr(Ini.ReadInteger( 'Proc_3', 'Offset_Y', 0))
        else
          Edit_OFFY.Text := '0';

        if Ini.ValueExists( 'Proc_3', 'Sino_ST') then
          Edit_ST.Text := IntToStr(Ini.ReadInteger( 'Proc_3', 'Sino_ST', 50));
        if Ini.ValueExists( 'Proc_3', 'Sino_End') then
          Edit_End.Text := IntToStr(Ini.ReadInteger( 'Proc_3', 'Sino_End', 950));

        if Ini.ValueExists('Proc_3', 'PhaseType') then
          CB_PT.ItemIndex := Ini.ReadInteger( 'Proc_3', 'PhaseType',0);

        if Ini.ValueExists('Proc_3','UW_Method') then
          CB_M.ItemIndex := Ini.ReadInteger('Proc_3','UW_Method',1);
        if Ini.ValueExists('Proc_3','UW_Dir') then
          RG_Dir.ItemIndex := Ini.ReadInteger('Proc_3','UW_Dir',1);
        if Ini.ValueExists('Proc_3','UW_Ang') then
          CB_Ang.Checked := Ini.ReadBool('Proc_3','UW_Ang',true);
        if Ini.ValueExists('Proc_3','UW_Power') then
          Edit_Base.Text := Ini.ReadString('Proc_3','UW_Power', '1');

        if Ini.ReadString( 'Proc_3', 'Status','')='Completed' then
          RB_Compled.Checked:=true;
      end;
    finally
      Ini.Free;
    end;
  end;
end;

procedure TForm_main.WriteComped(Sender: TObject);
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(Edit_FN.Text+'.tag');
  try
    Ini.WriteString( 'Proc_3', 'Status', 'Completed');
  finally
    Ini.Free;
  end;
end;

procedure TForm_main.WriteProc3(Sender: TObject);
var
  BFN, BDir,lFN : string;
  Ini: TIniFile;
begin
  if UpperCase(ExtractFileExt(TagFN)) = '.TAG' then
  try
    Ini := TIniFile.Create(TagFN);
    //Proc_3
    Ini.WriteString( 'Proc_3', 'Method', 'Phase Unwrap');

    BFN := Edit_FN.Text;
    Bdir := TDirectory.GetParent(TDirectory.GetParent(ExtractFilePath(BFN)))+'\uw\';
    lFN :=TPath.GetFileNameWithoutExtension(BFN);
    Ini.WriteString( 'Proc_3', 'File_Name', BDir+lFN+'u_*');
    Ini.WriteInteger('Proc_3','Image_Numer',StrToInt(Edit_End.Text)-StrToInt(Edit_ST.Text)+1);

    Ini.WriteInteger( 'Proc_3', 'Width', StrToInt(Edit_PW.Text));
    Ini.WriteInteger( 'Proc_3', 'Height', StrToInt(Edit_PH.Text));
    Ini.WriteInteger( 'Proc_3', 'Offset_X', StrToInt(Edit_OffX.Text));
    Ini.WriteInteger( 'Proc_3', 'Offset_Y', StrToInt(Edit_OffY.Text));
    Ini.WriteInteger( 'Proc_3', 'Format', 3);

    Ini.WriteInteger( 'Proc_3', 'Sino_ST', StrToInt(Edit_ST.Text));
    Ini.WriteInteger( 'Proc_3', 'Sino_End', StrToInt(Edit_End.Text));

    Ini.WriteInteger('Proc_3','UW_Method',CB_M.ItemIndex );
    Ini.WriteInteger('Proc_3','UW_Dir',RG_Dir.ItemIndex  );
    Ini.WriteBool('Proc_3','UW_Ang',CB_Ang.Checked  );
    Ini.WriteString('Proc_3','UW_Power', Edit_Base.Text);
  finally
    Ini.Free;
  end;
end;

procedure TForm_main.BB_Copy_CondClick(Sender: TObject);
begin
  WriteProc3(Sender);
end;


end.
