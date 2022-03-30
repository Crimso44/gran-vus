
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       Express inplace editors const                               }
{                                                                   }
{       Copyright (c) 1998-2012 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit dxEdStr;

interface

{$I dxEdVer.inc}

const
  dxSTextTrue                        = 38901;  //'True'
  dxSTextFalse                       = 38902;  //'False'
  dxSDatePopupToday                  = 38903;  //'Today'
  dxSDatePopupClear                  = 38904;  //'Clear'

  dxSBlobButtonOK                    = 38905;  //'OK'
  dxSBlobButtonCancel                = 38906;  //'Cancel'
  dxSBlobButtonClose                 = 38907;  //'Close'

  dxSBlobPopupCut                    = 38908;  // 'Cu&t'
  dxSBlobPopupCopy                   = 38909;  // '&Copy'
  dxSBlobPopupPaste                  = 38910;  // '&Paste'
  dxSBlobPopupDelete                 = 38911;  // '&Delete'
  dxSBlobPopupSave                   = 38912;  // '&Save To File...'
  dxSBlobPopupLoad                   = 38913;  // '&Load From File...'

  dxSToolBarButtonCaptionCut         = 38914;  // Cut
  dxSToolBarButtonCaptionCopy        = 38915;  // Copy
  dxSToolBarButtonCaptionPaste       = 38916;  // Paste
  dxSToolBarButtonCaptionDelete      = 38917;  // Delete
  dxSToolBarButtonCaptionLoad        = 38918;  // Load
  dxSToolBarButtonCaptionSave        = 38919;  // Save

  dxSToolBarButtonHintCut            = 38920;  // Cut
  dxSToolBarButtonHintCopy           = 38921;  // Copy
  dxSToolBarButtonHintPaste          = 38922;  // Paste
  dxSToolBarButtonHintDelete         = 38923;  // Delete
  dxSToolBarButtonHintLoad           = 38924;  // Load
  dxSToolBarButtonHintSave           = 38925;  // Save

  dxSToolBarCaption                  = 38926;  // Toolbox

  dxSDateError                       = 38927;  // Invalida Date

  dxSDateToday                       = 38928;  // TODAY
  dxSDateYesterday                   = 38929;  // YESTERDAY
  dxSDateTomorrow                    = 38930;  // TOMORROW
  dxSDateSunday                      = 38931;  // SUNDAY
  dxSDateMonday                      = 38932;  // MONDAY
  dxSDateTuesday                     = 38933;  // TUESDAY
  dxSDateWednesday                   = 38934;  // WEDNESDAY
  dxSDateThursday                    = 38935;  // THURSDAY
  dxSDateFriday                      = 38936;  // FRIDAY
  dxSDateSaturday                    = 38937;  // SATURDAY
  dxSDateFirst                       = 38938;  // FIRST
  dxSDateSecond                      = 38939;  // SECOND
  dxSDateThird                       = 38940;  // THIRD
  dxSDateFourth                      = 38941;  // FOURTH
  dxSDateFifth                       = 38942;  // FIFTH
  dxSDateSixth                       = 38943;  // SIXTH
  dxSDateSeventh                     = 38944;  // SEVENTH
  dxSDateBOM                         = 38945;  // BOM
  dxSDateEOM                         = 38946;  // EOM
  dxSDateNow                         = 38947;  // NOW

  dxSValidateEditErrorText           = 38948;  // Invalid input value. Use escape key to abandon changes

  dxSEditUndoCaption                 = 38949; // '&Undo'
  dxSEditRedoCaption                 = 38950; // '&Redo'
  dxSEditCutCaption                  = 38952; // 'Cu&t'
  dxSEditCopyCaption                 = 38953; // '&Copy'
  dxSEditPasteCaption                = 38954; // '&Paste'
  dxSEditDeleteCaption               = 38955; // '&Delete'
  dxSEditSelectAllCaption            = 38956; // 'Select &All'

function LoadStrEdStr(id: Integer): string;


implementation

{$R dxEdStr.res}

function LoadStrEdStr(id: Integer): string;
begin
  Result := '';
  case id of
    //dxGrClms strings
    38901: Result := '��';
    38902: Result := '���';
    38903: Result := '�������';
    38904: Result := '��������';

    // blob edit buttons
    38905: Result := '&OK';
    38906: Result := '&������';
    38907: Result := '&�������';

    38908: Result := '��&������';
    38909: Result := '&����������';
    38910: Result := '&��������';
    38911: Result := '&�������';
    38912: Result := '&��������� � ����...';
    38913: Result := '&��������� �� �����...';

    38914: Result := '��&������';
    38915: Result := '&����������';
    38916: Result := '&��������';
    38917: Result := '&�������';
    38918: Result := '&���������...';
    38919: Result := '&���������...';

    38920: Result := '��������';
    38921: Result := '����������';
    38922: Result := '��������';
    38923: Result := '�������';
    38924: Result := '��������� �� �����...';
    38925: Result := '��������� � ����...';

    38926: Result := '�����������';

    38927: Result := '��������� ����';

    38928: Result := '�������';
    38929: Result := '�����';
    38930: Result := '������';
    38931: Result := '�����������';
    38932: Result := '�����������';
    38933: Result := '�������';
    38934: Result := '�����';
    38935: Result := '�������';
    38936: Result := '�������';
    38937: Result := '�������';
    38938: Result := '������';
    38939: Result := '������';
    38940: Result := '������';
    38941: Result := '���������';
    38942: Result := '�����';
    38943: Result := '������';
    38944: Result := '�������';
    38945: Result := '���.���.';
    38946: Result := '���.���';
    38947: Result := '������';

    38948: Result := '������������ ������ ������. ������� Esc ��� ������ ��������������';

    38949: Result := '&Undo';
    38950: Result := '&Redo';
    38952: Result := '��&������';
    38953: Result := '&����������';
    38954: Result := '&��������';
    38955: Result := '&�������';
    38956: Result := '������� &���';
  end;
end;

end.
