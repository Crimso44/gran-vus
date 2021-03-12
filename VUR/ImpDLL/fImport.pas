unit fImport;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ADODB, ExtCtrls, StdCtrls, ComCtrls, Buttons, ActnList, Db, Variants, dxmdaset;

type
  TfmImport = class(TForm)
    btnBack: TButton;
    btnNext: TButton;
    btnCancel: TButton;
    PC: TPageControl;
    tshInfo: TTabSheet;
    tshParams: TTabSheet;
    Bevel1: TBevel;
    pnlTop: TPanel;
    Image2: TImage;
    lbTop: TLabel;
    Label5: TLabel;
    edPath: TEdit;
    sbPath: TSpeedButton;
    tshProcess: TTabSheet;
    tshDone: TTabSheet;
    Label6: TLabel;
    Label7: TLabel;
    tmGo: TTimer;
    pbProc: TProgressBar;
    dbMain: TADOConnection;
    ActionList1: TActionList;
    actDummy: TAction;
    actShiftDummy: TAction;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Label4: TLabel;
    OpenDialog1: TOpenDialog;
    ds: TdxMemData;
    dstableName: TStringField;
    dsPointer: TIntegerField;
    cbUpdate: TCheckBox;
    qry: TADOQuery;
    dsmultiKey: TBooleanField;
    bvTop: TBevel;
    dsIDField: TStringField;
    dsKod: TBooleanField;
    dsKodField: TStringField;
    dsKodType: TIntegerField;
    dsInsert: TMemoField;
    dsUpdate: TMemoField;
    dsInsID: TMemoField;
    dsImportData: TdxMemData;
    dsImportDatatableName: TStringField;
    dsImportDatainnerId: TIntegerField;
    dsImportDataouterId: TStringField;
    dsIsIdentity: TBooleanField;
    dsmaxID: TIntegerField;
    procedure btnCancelClick(Sender: TObject);
    procedure tshInfoShow(Sender: TObject);
    procedure tshParamsShow(Sender: TObject);
    procedure tshProcessShow(Sender: TObject);
    procedure tshDoneShow(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure sbPathClick(Sender: TObject);
    procedure tmGoTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actDummyExecute(Sender: TObject);
    procedure actShiftDummyExecute(Sender: TObject);
  private
    { Private declarations }
    justclose: Boolean;

    procedure StepIt;
  public
    { Public declarations }
    schemaPath: string;
  end;


implementation

uses msg, FileCtrl, SaveEvents, MSXML2_TLB, fError, strUtils{, displayDSs};

{$R *.DFM}

procedure TfmImport.btnCancelClick(Sender: TObject);
begin
  if PC.ActivePage <> tshProcess then Close
  else ModalResult := mrCancel;
end;

procedure TfmImport.tshInfoShow(Sender: TObject);
begin
  btnBack.Enabled := false;
end;

procedure TfmImport.tshParamsShow(Sender: TObject);
begin
  lbTop.Caption := 'Выбор параметров импорта данных';
  btnBack.Enabled := true;
  pnlTop.Parent := tshParams;
  bvTop.Parent := tshParams;
end;

procedure TfmImport.tshProcessShow(Sender: TObject);
begin
  lbTop.Caption := 'Процесс импорта данных';
  btnBack.Visible:= false;
  btnNext.Visible := false;
  pnlTop.Parent := tshProcess;
  bvTop.Parent := tshProcess;
  tmGo.Enabled := true;
end;

procedure TfmImport.tshDoneShow(Sender: TObject);
begin
  lbTop.Caption := 'Импорт данных завершен';
  btnCancel.Caption := 'Закрыть';
  btnCancel.Default := true;
  pnlTop.Parent := tshDone;
  bvTop.Parent := tshDone;
end;

procedure TfmImport.btnBackClick(Sender: TObject);
begin
  PC.ActivePageIndex := PC.ActivePageIndex-1;
end;

procedure TfmImport.btnNextClick(Sender: TObject);
begin
  if PC.ActivePage=tshParams then
  begin
  //check params
    if Trim(edPath.Text) = EmptyStr then
    begin
      try edPath.SetFocus; except end;
      msg.ShowErr('Укажите размещение файлов на диске...');
      justclose := False;
      Exit;
    end
    else if not FileExists(edPath.Text) then
    begin
      try edPath.SetFocus; except end;
      msg.ShowErr('Файл не найден...');
      justclose := False;
      Exit;
    end;
  end;
  PC.ActivePageIndex := PC.ActivePageIndex+1;
end;

procedure TfmImport.sbPathClick(Sender: TObject);
begin
  if OpenDialog1.Execute then edPath.Text := OpenDialog1.FileName;
end;

procedure TfmImport.StepIt;
begin
  if ModalResult = mrCancel then
    if Confirm('Прервать процесс обмена данными?') then Abort
    else ModalResult := mrNone;
  pbProc.StepIt;
  Application.ProcessMessages;
end;

procedure TfmImport.tmGoTimer(Sender: TObject);
var
  XMLDoc: IXMLDOMDocument2;
  Schema: ISchema;
  nodes: TInterfaceList;

  procedure setLabel(txt: string);
  begin
    Label7.Caption := txt;
    Application.ProcessMessages;
  end;

  function GetDataType(SOMDataType: SOMITEMTYPE): TFieldType; overload;
  begin
    case SOMDataType of
      SOMITEM_DATATYPE: Result := ftUnknown;
      SOMITEM_DATATYPE_ANYTYPE: Result := ftUnknown;
      SOMITEM_DATATYPE_ANYURI: Result := ftUnknown;
      SOMITEM_DATATYPE_BASE64BINARY: Result := ftBlob;
      SOMITEM_DATATYPE_BOOLEAN: Result := ftBoolean;
      SOMITEM_DATATYPE_BYTE: Result := ftWord;
      SOMITEM_DATATYPE_DATE: Result := ftDate;
      SOMITEM_DATATYPE_DATETIME: Result := ftDateTime;
      SOMITEM_DATATYPE_DAY: Result := ftUnknown;
      SOMITEM_DATATYPE_DECIMAL: Result := ftFloat;
      SOMITEM_DATATYPE_DOUBLE: Result := ftFloat;
      SOMITEM_DATATYPE_DURATION: Result := ftUnknown;
      SOMITEM_DATATYPE_ENTITIES: Result := ftUnknown;
      SOMITEM_DATATYPE_ENTITY: Result := ftUnknown;
      SOMITEM_DATATYPE_FLOAT: Result := ftFloat;
      SOMITEM_DATATYPE_HEXBINARY: Result := ftBlob;
      SOMITEM_DATATYPE_ID: Result := ftUnknown;
      SOMITEM_DATATYPE_IDREF: Result := ftUnknown;
      SOMITEM_DATATYPE_IDREFS: Result := ftUnknown;
      SOMITEM_DATATYPE_INT: Result := ftInteger;
      SOMITEM_DATATYPE_INTEGER: Result := ftInteger;
      SOMITEM_DATATYPE_LANGUAGE: Result := ftUnknown;
      SOMITEM_DATATYPE_LONG: Result := ftLargeint;
      SOMITEM_DATATYPE_MONTH: Result := ftUnknown;
      SOMITEM_DATATYPE_MONTHDAY: Result := ftUnknown;
      SOMITEM_DATATYPE_NAME: Result := ftString;
      SOMITEM_DATATYPE_NCNAME: Result := ftString;
      SOMITEM_DATATYPE_NEGATIVEINTEGER: Result := ftInteger;
      SOMITEM_DATATYPE_NMTOKEN: Result := ftUnknown;
      SOMITEM_DATATYPE_NMTOKENS: Result := ftUnknown;
      SOMITEM_DATATYPE_NONNEGATIVEINTEGER: Result := ftInteger;
      SOMITEM_DATATYPE_NONPOSITIVEINTEGER: Result := ftInteger;
      SOMITEM_DATATYPE_NORMALIZEDSTRING: Result := ftString;
      SOMITEM_DATATYPE_NOTATION: Result := ftUnknown;
      SOMITEM_DATATYPE_POSITIVEINTEGER: Result := ftInteger;
      SOMITEM_DATATYPE_QNAME: Result := ftString;
      SOMITEM_DATATYPE_SHORT: Result := ftSmallint;
      SOMITEM_DATATYPE_STRING: Result := ftString;
      SOMITEM_DATATYPE_TIME: Result := ftTime;
      SOMITEM_DATATYPE_TOKEN: Result := ftUnknown;
      SOMITEM_DATATYPE_UNSIGNEDBYTE: Result := ftInteger;
      SOMITEM_DATATYPE_UNSIGNEDINT: Result := ftLargeInt;
      SOMITEM_DATATYPE_UNSIGNEDLONG: Result := ftLargeInt;
      SOMITEM_DATATYPE_UNSIGNEDSHORT: Result := ftInteger;
      SOMITEM_DATATYPE_YEAR: Result := ftUnknown;
      SOMITEM_DATATYPE_YEARMONTH: Result := ftUnknown;
      SOMITEM_DATATYPE_ANYSIMPLETYPE: Result := ftUnknown;
      else Result := ftUnknown;
    end;
  end;

  function GetSOMDataType(elem: ISchemaElement): SOMITEMTYPE;
  var
    elemtype: ISchemaType;
  begin
    elemtype := elem.type_;
    Result := elemtype.itemType;
    while (Result = SOMITEM_SIMPLETYPE) and (elemtype.baseTypes.length > 0) do
    begin
      Result := elemtype.baseTypes.item[0].itemType;
      elemtype := elemtype.baseTypes.item[0] as ISchemaType;
    end;
  end;

  function GetSchemaElement(elem: ISchemaElement; node: IXMLDOMNode): ISchemaElement; overload;
  begin
    Result := ((elem.type_ as ISchemaComplexType).
      contentModel.particles.itemByName(node.nodeName) as ISchemaElement);
  end;

  function GetSchemaElement(node: IXMLDOMNode): ISchemaElement; overload;
  begin
    Result := GetSchemaElement((Schema.elements.itemByName('Import') as ISchemaElement), node);
  end;

  function GetDataType(elem: ISchemaElement): TFieldType; overload;
  begin
    Result := GetDataType(GetSOMDataType(elem));
  end;

  function GetDataType(node: IXMLDOMNode): TFieldType; overload;
  begin
    Result := GetDataType(GetSchemaElement(GetSchemaElement(node.parentNode), node));
  end;

  function GetValue(node: IXMLDOMNode): WideString;
  begin
    Result := Trim(Copy(node.xml, Pos('>', node.xml) + 1, Pos('</', node.xml) - Pos('>', node.xml) - 1));
  end;

  function LookUp(outerId, tableName: String): Integer;
  var
    v: Variant;
  begin
    v := dsImportData.Lookup('outerId;tableName', VarArrayOf([outerId, tableName]), 'innerId');
    if v <> NULL then Result := v
    else Result := dsImportData.Lookup('tableName', tableName, 'innerId');
  end; 

  function GetID(node: IXMLDOMNode; var ID: Integer): Boolean;
  var
    s: String;
    child: IXMLDOMNode;
    elemField: ISchemaElement;
    vararr: array of Variant;
  begin
    if (not dsmultiKey.IsNull) and (dsmultiKey.Value) then
    begin
      child := node.firstChild;
      SetLength(vararr, 0);
      while child <> nil do
      begin
        elemField := GetSchemaElement(GetSchemaElement(node), child);
        try
          elemField.unhandledAttributes.getIndexFromQName('gr:key');
          SetLength(vararr, Length(vararr) + 1);
          vararr[Length(vararr) - 1] := NULL;
          vararr[Length(vararr) - 1] := LookUp(GetValue(child),
            elemField.unhandledAttributes.getValueFromQName('gr:refTable'));
        except
        end;
        if vararr[Length(vararr) - 1] = NULL then vararr[Length(vararr) - 1] := GetValue(child);
        child := child.nextSibling;
      end;
      Result := dsImportData.Locate(dsIDField.Value, vararr, []);
      vararr := nil;
    end
    else if dsKod.IsNull then
      Result := dsImportData.Locate('tableName', dstableName.Value, [])
    else
    begin
      child := node.firstChild;
      while child <> nil do
      begin
        if child.nodeName = dsKodField.Value then
        begin
          s := GetValue(child);
          Break;
        end;
        child := child.nextSibling;
      end;
      Result := dsImportData.Locate('outerId;tableName', VarArrayOf([s,dstableName.Value]), [])
    end;
    if Result then ID := dsImportDatainnerId.Value
  end;

  procedure ImportData;
  var
    i, ID: Integer;
    outerID: String;
    s: String;
    elem, elemField: ISchemaElement;
    node, child: IXMLDOMNode;
    insert: Boolean;
  begin
    try
      qry.SQL.Text := 'alter table ImportData alter column OuterID varchar(255) NOT NULL';
      qry.ExecSQL;

      dbMain.BeginTrans;
      ds.First;

      while not ds.Eof do
      begin
        if not dsPointer.IsNull then
        begin
          node := IXMLDOMNode(nodes[dsPointer.Value]);
          s := dstableName.Value;
          while True do
          begin
            elem := GetSchemaElement(node);
            qry.Close;
            qry.Parameters.Clear;
            insert := not GetID(node, ID);
            if insert or cbUpdate.Checked then
            begin
              qry.SQL.Text := IfThen(insert, dsInsert.Value, dsUpdate.Value);
              qry.Parameters.ParseSQL(qry.SQL.Text, True);
              child := node.firstChild;
              if qry.SQL.Text = '' then
              begin
                node := node.nextSibling;
                StepIt;
                if node = nil then Break
                else if s <> node.nodeName then Break
                else Continue;
              end;
              while child <> nil do
              begin
                if dsKodField.Value = child.nodeName then
                begin
                  outerID := GetValue(child);
                  if dsKod.IsNull then
                    if dsImportData.Locate('tableName', dstableName.Value, []) then
                    begin
                      dsImportData.Edit;
                      dsImportDataouterId.Value := outerID;
                      dsImportData.Post;
                    end;
                  if dsKod.Value then
                  begin
                    if qry.Parameters.FindParam(dsIDField.Value) <> nil then
                    begin
                      qry.Parameters.ParamByName(dsIDField.Value).DataType := ftInteger;
                      qry.Parameters.ParamByName(dsIDField.Value).Value := ID;
                    end;

                    if qry.Parameters.FindParam(child.nodeName) <> nil then
                    begin
                      qry.Parameters.ParamByName(child.nodeName).DataType := GetDataType(dsKodType.Value);
                      qry.Parameters.ParamByName(child.nodeName).Value := GetValue(child);
                      if (qry.Parameters.ParamByName(child.nodeName).DataType = ftString) and
                         (qry.Parameters.ParamByName(child.nodeName).Value = '') then
                        qry.Parameters.ParamByName(child.nodeName).Value := NULL;
                    end;
                  end
                  else if qry.Parameters.FindParam(child.nodeName) <> nil then
                  begin
                    qry.Parameters.ParamByName(child.nodeName).DataType := ftInteger;
                    qry.Parameters.ParamByName(child.nodeName).Value := ID;
                  end;
                end
                else if qry.Parameters.FindParam(child.nodeName) <> nil then
                begin
                  qry.Parameters.ParamByName(child.nodeName).DataType := GetDataType(child);
                  qry.Parameters.ParamByName(child.nodeName).Value := GetValue(child);
                  if (qry.Parameters.ParamByName(child.nodeName).DataType = ftString) and
                     (qry.Parameters.ParamByName(child.nodeName).Value = '') then
                    qry.Parameters.ParamByName(child.nodeName).Value := NULL;
                end
                else if qry.Parameters.FindParam(child.nodeName + 'Kod') <> nil then
                begin
                  elemField := GetSchemaElement(elem, child);
                  qry.Parameters.ParamByName(child.nodeName + 'Kod').DataType := GetDataType(elemField);
                  qry.Parameters.ParamByName(child.nodeName + 'Kod').Value :=
                    LookUp(GetValue(child), elemField.unhandledAttributes.getValueFromQName('gr:refTable'));
                  if (qry.Parameters.ParamByName(child.nodeName + 'Kod').DataType = ftString) and
                     (qry.Parameters.ParamByName(child.nodeName + 'Kod').Value = '') then
                    qry.Parameters.ParamByName(child.nodeName + 'Kod').Value := NULL;
                end;
                child := child.nextSibling;
              end;
              for i := 0 to qry.Parameters.Count - 1 do
              begin
                if qry.Parameters[i].DataType = ftUnknown then
                begin
                  qry.Parameters[i].DataType := ftString;
                  qry.Parameters[i].Value := NULL;
                end;
              end;
              qry.ExecSQL;
              if insert then
              begin
                dsImportData.Append;
                dsImportDatatableName.Value := dstableName.Value;
                if (not dsmultiKey.IsNull) and (dsmultiKey.Value) then
                begin
                  child := node.firstChild;
                  while child <> nil do
                  begin
                    elemField := GetSchemaElement(GetSchemaElement(node), child);
                    try
                      elemField.unhandledAttributes.getIndexFromQName('gr:key');
                      if qry.Parameters.FindParam(child.nodeName) <> nil then
                        dsImportData.FieldByName(child.nodeName).Value :=
                            qry.Parameters.ParamByName(child.nodeName).Value
                      else if qry.Parameters.FindParam(child.nodeName + 'Kod') <> nil then
                        dsImportData.FieldByName(child.nodeName).Value :=
                          qry.Parameters.ParamByName(child.nodeName + 'Kod').Value;
                    except
                    end;
                    child := child.nextSibling;
                  end;
                end
                else
                begin
                  child := node.firstChild;
                  while child <> nil do
                  begin
                    if child.nodeName = dsKodField.Value then
                    begin
                      dsImportDataouterId.Value := GetValue(child);
                      if dsIsIdentity.Value then
                      begin
                        qry.Close;
                        qry.Parameters.Clear;
                        qry.SQL.Text := 'select @@IDENTITY';
                        qry.Open;
                        dsImportDatainnerId.Value := qry.Fields[0].AsInteger;
                      end
                      else
                      begin
                        ds.Edit;
                        dsMaxID.Value := dsMaxID.Value + 1;
                        ds.Post;
                        dsImportDatainnerId.Value := dsMaxID.Value;
                      end;
                      Break;
                    end;
                    child := child.nextSibling;
                  end;
                end;
                dsImportData.Post;
              end;
              if insert and not dsInsID.IsNull and not dsMultiKey.Value then
              begin
                qry.Close;
                qry.Parameters.Clear;
                qry.SQL.Text := dsInsID.Value;
                qry.Parameters.ParseSQL(qry.SQL.Text, True);
                if qry.Parameters.FindParam('outerID') <> nil then
                begin
                  qry.Parameters.ParamByName('outerID').DataType := ftString;
                  qry.Parameters.ParamByName('outerID').Value := outerID;
                end;
                qry.ExecSQL;
              end;
            end;
            node := node.nextSibling;
            StepIt;
            if node = nil then Break
            else if s <> node.nodeName then Break;
          end;
        end;
        ds.Next;
      end;
      dbMain.CommitTrans;
    except
      try dbMain.RollbackTrans; except end;
      raise;
    end;
  end;

  procedure ParseXML;
    procedure CreateField(ds: TDataSet; fieldname: String; datatype: TDataType);
    var
      field: TField;
    begin
      ds.Close;
      if datatype = ftInteger then field := TIntegerField.Create(ds)
      else field := TStringField.Create(ds);
      field.FieldName := fieldname;
      field.DataSet := ds;
    end;
    procedure Load(dsFrom, dsTo: TDataSet);
    var
      i: Integer;
    begin
      dsFrom.First;
      while not dsFrom.Eof do
      begin
        dsTo.Append;
        for i := 0 to dsFrom.Fields.Count - 1 do
          dsTo.FieldByName(dsFrom.Fields[i].FieldName).Value := dsFrom.Fields[i].Value;
        dsTo.Post;
        dsFrom.Next;
      end;
    end;
  var
    elem, elemField: ISchemaElement;
    node: IXMLDOMNode;
    i, j, attrs: Integer;
    s, key, refTable, insert, insertselect, update, updatewhere, insertimpdata: String;
  begin
    s := '';
    node := XMLDoc.documentElement.firstChild;
    while node <> nil do
    begin
      if s <> node.nodeName then
      begin
        elem := GetSchemaElement(node);
        if ds.Locate('tableName', node.nodeName, []) then ds.Edit
        else
        begin
          ds.Append;
          dsTableName.Value := node.nodeName;
        end;
        dsPointer.Value := nodes.Add(node);
        ds.Post;
        s := node.nodeName;

        for i := 0 to (elem.type_ as ISchemaComplexType).ContentModel.particles.length - 1 do
        begin
          elemField := ((elem.type_ as ISchemaComplexType).ContentModel.particles[i] as ISchemaElement);
          for j := 0 to elemField.unhandledAttributes.length - 1 do
          begin
            if (elemField.unhandledAttributes.getQName(j) = 'gr:key') then
            begin
              ds.Locate('tableName', node.nodeName, []);
              ds.Edit;
              if dsmultiKey.IsNull then
              begin
                dsmultiKey.Value := False;
                dsKodType.Value := GetSOMDataType(elemField);
                dsKodField.Value := elemField.name;
                dsIDField.Value := elemField.unhandledAttributes.getValue(j);
                if elem.maxOccurs = -1 then
                  dsKod.Value := (dsIDField.Value <> dsKodField.Value);
              end
              else
              begin
                dsmultiKey.Value := True;
                if Pos(';', dsIDField.Value) = 0 then
                  if dsImportData.FindField(dsIDField.Value) = nil then
                    CreateField(dsImportData, dsIDField.Value, ftInteger);
                if dsImportData.FindField(elemField.unhandledAttributes.getValue(j)) = nil then
                  CreateField(dsImportData, elemField.unhandledAttributes.getValue(j), ftInteger);

                dsIDField.Value := dsIDField.Value + ';' + elemField.unhandledAttributes.getValue(j);
                dsKodField.Value := dsIDField.Value;
              end;

              ds.Post;
            end;
            if (elemField.unhandledAttributes.getQName(j) = 'gr:refTable') then
            begin
              if not ds.Locate('tableName', elemField.unhandledAttributes.getValue(j), []) then
              begin
                ds.Insert;
                dsTableName.Value := elemField.unhandledAttributes.getValue(j);
                if (elemField.type_.itemType = SOMITEM_SIMPLETYPE) and
                   (elemField.type_.unhandledAttributes.length > 0) then
                begin
                  for attrs := 0 to elemField.type_.unhandledAttributes.length - 1 do
                  begin
                    if elemField.type_.unhandledAttributes.getQName(attrs) = 'gr:key' then
                      dsIDField.Value := elemField.type_.unhandledAttributes.getValue(attrs)
                    else if elemField.type_.unhandledAttributes.getQName(attrs) = 'gr:kod' then
                    begin
                      dsKodField.Value := elemField.type_.unhandledAttributes.getValue(attrs);
                      dsKodType.Value := GetSOMDataType(elemField);
                    end;
                  end;
                  dsKod.Value := (dsIDField.Value <> dsKodField.Value);
                end;
                ds.Post;
              end;
            end;
          end;
        end;
      end;
      node := node.nextSibling;
      StepIt;
    end;

    pbProc.Position := ds.RecordCount;
    pbProc.Max := ds.RecordCount * 2;
    Application.ProcessMessages;
    dsImportData.Open;
    dsImportData.DisableControls;

    qry.Close;
    qry.Parameters.Clear;
    qry.SQL.Text := 'select innerId, outerId, tableName from ImportData';
    qry.Open;
    Load(qry, dsImportData);

    ds.First;
    while not ds.Eof do
    begin
      if (dsPointer.IsNull) and (dsIDField.IsNull) then
      begin
        ds.Delete;
        StepIt;
        Continue;
      end;

      node := IXMLDOMNode(nodes[dsPointer.Value]);
      elem := GetSchemaElement(node);

      if dsKod.IsNull then
      begin
        qry.Close;
        qry.Parameters.Clear;
        qry.SQL.Text := 'select top 1 ' + dsIDField.Value + ' as innerId, 0 as outerId, ''' +
                        dstableName.Value + ''' as tableName from ' + dstableName.Value;
        qry.Open;
        Load(qry, dsImportData);
      end
      else if dsKod.Value then
      begin
        qry.Close;
        qry.Parameters.Clear;
        qry.SQL.Text := 'select ' + dsIDField.Value + ' as innerId, ' + dsKodField.Value +
                        ' as outerId, ''' + dstableName.Value + ''' as tableName from ' + dstableName.Value;
        qry.Open;
        Load(qry, dsImportData);
      end
      else if dsmultiKey.Value then
      begin
        qry.Close;
        qry.Parameters.Clear;
        qry.SQL.Text := 'select ' + StringReplace(dsIDField.Value, ';', ',', [rfReplaceAll]) + ', ''' +
          dstableName.Value + ''' as tableName from ' + dstableName.Value;
        qry.Open;
        Load(qry, dsImportData);
      end;

      if not dsPointer.IsNull then
      begin
        qry.Close;
        qry.SQL.Text := 'select top 1 * from ' + elem.name;
        qry.Open;
        insert := 'insert into ' + elem.name + ' (';
        insertselect := ' select ';
        update := 'update ' + elem.name + ' set ';
        updatewhere := 'where ';
        insertimpdata := 'insert into ImportData (InnerId, OuterId, TableName, IDField) select ';
        for i := 0 to (elem.type_ as ISchemaComplexType).ContentModel.particles.length - 1 do
        begin
          elemField := ((elem.type_ as ISchemaComplexType).ContentModel.particles[i] as ISchemaElement);
          key := '';
          refTable := '';
          for j := 0 to elemField.unhandledAttributes.length - 1 do
          begin
            if (elemField.unhandledAttributes.getQName(j) = 'gr:key') then
              key := elemField.unhandledAttributes.getValue(j)
            else if (elemField.unhandledAttributes.getQName(j) = 'gr:refTable') then
              refTable := elemField.unhandledAttributes.getValue(j);
          end;
          if (key <> '') and ((refTable = '') and (not dsmultiKey.Value)) then
          begin
            ds.Edit;
            dsIsIdentity.Value := qry.FieldByName(key).DataType = ftAutoInc;
            ds.Post;
            if (not dsmultiKey.IsNull) and (not dsmultiKey.Value) and (not dsIsIdentity.Value) then
            begin
              qry.Close;
              qry.Parameters.Clear;
              qry.SQL.Text := 'select max(' + dsIDField.Value + ') from ' + dstableName.Value;
              qry.Open;
              ds.Edit;
              dsMaxID.Value := qry.Fields[0].AsInteger;
              ds.Post;
            end;
            if not dsIsIdentity.Value then
            begin
              if insert <> 'insert into ' + elem.name + ' (' then insert := insert + ', ';
              insert := insert + key;

              if insertselect <> ' select ' then insertselect := insertselect + ', ';
              if refTable = '' then
              begin
                if (Pos('Jet', dbMain.Provider) > 0) then
                begin
                  insertselect := insertselect + 'iif(IsNull(DMax(''' + key + ''', ''' + elem.name +
                    ''')), ' + '0, DMax(''' + key + ''', ''' + elem.name + ''')) + 1';

                  insertimpdata := insertimpdata + 'DMax(''' + key + ''', ''' + elem.name + ''')';
                end
                else
                begin
                  insertselect := insertselect + '(select IsNull(max(' + key + '), 0) + 1 from ' +
                                  elem.name + ')';

                  insertimpdata := insertimpdata + '(select IsNull(max(' + key + '), 0) from ' +
                                  elem.name + ')';
                end;
              end
              else insertselect := insertselect + ':' + key;

            end
            else insertimpdata := insertimpdata + '@@IDENTITY';
            if key <> elemField.name then
            begin
              if insert <> 'insert into ' + elem.name + ' (' then insert := insert + ', ';
              insert := insert + elemField.name;

              if insertselect <> ' select ' then insertselect := insertselect + ', ';
              insertselect := insertselect + ':' + elemField.name;
            end;
            if updatewhere <> 'where ' then updatewhere := updatewhere + ' and ';
            updatewhere := updatewhere + elemField.name + ' = :' + elemField.name;
          end
          else
          begin
            if refTable = '' then
            begin
              if insert <> 'insert into ' + elem.name + ' (' then insert := insert + ', ';
              insert := insert + elemField.name;
              
              if insertselect <> ' select ' then insertselect := insertselect + ', ';
              insertselect := insertselect + ':' + elemField.name;

              if update <> 'update ' + elem.name + ' set ' then update := update + ', ';
              update := update + elemField.name + ' = :' + elemField.name;
            end
            else
            begin
              if insert <> 'insert into ' + elem.name + ' (' then insert := insert + ', ';
              insert := insert + elemField.name;

              if insertselect <> ' select ' then insertselect := insertselect + ', ';
              insertselect := insertselect + ':' + elemField.name + 'Kod';

              if key <> '' then
              begin
                if updatewhere <> 'where ' then updatewhere := updatewhere + ' and ';
                updatewhere := updatewhere + elemField.name + ' = :' + elemField.name + 'Kod';
              end
              else
              begin
                if update <> 'update ' + elem.name + ' set ' then update := update + ', ';
                update := update + elemField.name + ' = :' + elemField.name + 'Kod';
              end;
            end;
          end;
        end;
        ds.Edit;
        insertimpdata := insertimpdata + ', :outerId, ''' + elem.name + ''', ''' + dsIDField.Value + '''';
        dsInsert.Value := insert + ') ' + insertselect;
        dsInsID.Value := IfThen(dsKod.Value, '', ' ' + insertimpdata);
        if update <> 'update ' + elem.name + ' set ' then dsUpdate.Value := update + ' ' + updatewhere
        else dsUpdate.Value := '';
        ds.Post;
      end;
      ds.Next;
      StepIt;
    end;
  end;

  procedure ValidateXML;
    procedure raiseError(err: IXMLDOMParseError);
    var
      i: Integer;
      s: String;
    begin
      if err.errorCode <> 0 then
      begin
        s := '';
//        for i := 0 to err.allErrors.length - 1 do
//          s := s + #13#10 + Trim(err.allErrors.item[i].reason);
        s := s + #13#10 + Trim(err.reason);
        raise Exception.Create(s);
      end;
    end;
  var
    Schemas: IXMLDOMSchemaCollection2;
    DOMSchema: IXMLDOMDocument2;
  begin
    XMLDoc := CoDOMDocument40.Create;
    XMLDoc.async := False;
//    XMLDoc.setProperty('MultipleErrorMessages', True);
    DOMSchema := CoDOMDocument40.Create;
    DOMSchema.async := False;
//    DOMSchema.setProperty('MultipleErrorMessages', True);
    setLabel('Проверка целостности xml файла...');
    if not XMLDoc.load(edPath.Text) then raiseError(XMLDoc.ParseError as IXMLDOMParseError)
    else
    begin
      StepIt;
      if not DOMSchema.load(schemaPath) then raiseError(DOMSchema.ParseError as IXMLDOMParseError)
      else
      begin
        StepIt;
        setLabel('Проверка правильности xml файла относительно схемы...');
        Schemas := CoXMLSchemaCache40.Create;
        Schemas.add('', DOMSchema);
        Schema := Schemas.getSchema('');
        XMLDoc.schemas := Schemas;
        raiseError(XMLDoc.validate as IXMLDOMParseError);
        //raiseError(XMLDoc.validate as IXMLDOMParseError2);
        StepIt;
      end;
    end
  end;
var
  exec: TADOQuery;
begin
  tmGo.Enabled := false;
  pbProc.Max := 5;
  Application.ProcessMessages;
  try
    if not FileExists(edPath.Text) then raise Exception.Create('Файл xml не найден!');
    StepIt;
    if not FileExists(schemaPath) then raise Exception.Create('Схема не найдена!');
    StepIt;
    ValidateXML;

    SetLabel('Анализ существующих данных...');
    qry.Close;
    qry.SQL.Text := 'select distinct tablename, IDField from ImportData';
    qry.Open;
    pbProc.Position := 0;
    pbProc.Max := qry.RecordCount;
    exec := TADOQuery.Create(nil);
    exec.Connection := qry.Connection;
    try
      while not qry.Eof do begin
        exec.SQL.Text := 'delete from ImportData where tablename = ''' + qry.Fields[0].AsString + '''' +
          ' and not exists(select 1 from ' + qry.Fields[0].AsString + ' where ' + qry.Fields[1].AsString +
          ' = ImportData.InnerID)';
        exec.ExecSQL;
        qry.Next;
        StepIt;
      end;
    finally
      exec.Free;
    end;

    nodes := TInterfaceList.Create;
    try
      setLabel('Анализ полученных данных...');
      pbProc.Position := 0;
      pbProc.Max := XMLDoc.documentElement.childNodes.length * 2;
      ds.Open;
      ds.DisableControls;
      dsImportData.Open;
      dsImportData.DisableControls;
      ParseXML;

//      DisplayDataSets(ds, dsImportData);
      pbProc.Position := 0;
      pbProc.Max := XMLDoc.documentElement.childNodes.length;
      setLabel('Импортирование данных...');
      ImportData;
    finally
      nodes.Free;
    end;
    PC.ActivePage := tshDone;
  except
    on EAbort do Close;
    on E: Exception do
    begin
      SaveEvent(dbMain, evs_Import_Failed, '', [E.ClassName + ': ' + E.Message]);
      ShowErr(Label7.Caption, E.Message);
      Close;
    end;
  end;
  SaveEvent(dbMain, evs_Import, '', [edPath.Text]);
  if justclose then Close;
end;

procedure TfmImport.FormCreate(Sender: TObject);
begin
  justclose := False;
  PC.ActivePageIndex := 0;
  if ParamStr(1) <> '' then begin
    justclose := True;
    PC.ActivePageIndex := 1;
    if ParamStr(1) = '/u' then
    begin
      cbUpdate.Checked := True;
      EdPath.Text := ParamStr(2);
    end
    else EdPath.Text := ParamStr(1);
    btnNextClick(nil);
  end;
end;

procedure TfmImport.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssCtrl in Shift) and (Key=VK_TAB) then Key := 0; 
end;

procedure TfmImport.actDummyExecute(Sender: TObject);
begin
//
end;

procedure TfmImport.actShiftDummyExecute(Sender: TObject);
begin
//
end;

end.
