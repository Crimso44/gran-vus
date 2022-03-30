
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
    38901: Result := 'Да';
    38902: Result := 'Нет';
    38903: Result := 'Сегодня';
    38904: Result := 'Очистить';

    // blob edit buttons
    38905: Result := '&OK';
    38906: Result := '&Отмена';
    38907: Result := '&Закрыть';

    38908: Result := 'Вы&резать';
    38909: Result := '&Копировать';
    38910: Result := '&Вставить';
    38911: Result := '&Удалить';
    38912: Result := '&Сохранить в файл...';
    38913: Result := '&Загрузить из файла...';

    38914: Result := 'Вы&резать';
    38915: Result := '&Копировать';
    38916: Result := '&Вставить';
    38917: Result := '&Удалить';
    38918: Result := '&Загрузить...';
    38919: Result := '&Сохранить...';

    38920: Result := 'Вырезать';
    38921: Result := 'Копировать';
    38922: Result := 'Вставить';
    38923: Result := 'Удалить';
    38924: Result := 'Загрузить из файла...';
    38925: Result := 'Сохранить в файл...';

    38926: Result := 'Инструменты';

    38927: Result := 'Ошибочная дата';

    38928: Result := 'СЕГОДНЯ';
    38929: Result := 'ВЧЕРА';
    38930: Result := 'ЗАВТРА';
    38931: Result := 'ВОСКРЕСЕНЬЕ';
    38932: Result := 'ПОНЕДЕЛЬНИК';
    38933: Result := 'ВТОРНИК';
    38934: Result := 'СРЕДА';
    38935: Result := 'ЧЕТВЕРГ';
    38936: Result := 'ПЯТНИЦА';
    38937: Result := 'СУББОТА';
    38938: Result := 'ПЕРВЫЙ';
    38939: Result := 'ВТОРОЙ';
    38940: Result := 'ТРЕТИЙ';
    38941: Result := 'ЧЕТВЕРТЫЙ';
    38942: Result := 'ПЯТЫЙ';
    38943: Result := 'ШЕСТОЙ';
    38944: Result := 'СЕДЬМОЙ';
    38945: Result := 'НАЧ.МЕС.';
    38946: Result := 'КОН.МЕС';
    38947: Result := 'СЕЙЧАС';

    38948: Result := 'Неправильный формат данных. Нажмите Esc для отмены редактирования';

    38949: Result := '&Undo';
    38950: Result := '&Redo';
    38952: Result := 'Вы&резать';
    38953: Result := '&Копировать';
    38954: Result := '&Вставить';
    38955: Result := '&Удалить';
    38956: Result := 'Выбрать &все';
  end;
end;

end.
