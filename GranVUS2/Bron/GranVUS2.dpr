program GranVUS2;

uses
  Forms,
  fMain in 'fMain.pas' {fmMain},
  fAbout in 'fAbout.pas' {fmAbout},
  rdialogs in 'Common\rdialogs.pas',
  msg in 'Common\msg.pas',
  IniSupport in 'Common\IniSupport.pas',
  dMain in 'dMain.pas' {dmMain: TDataModule},
  fBaseLst in 'fBaseLst.pas' {fmBaseLst},
  fCfgPlugIns in 'fCfgPlugIns.pas' {fmCfgPlugIns},
  fSubjCard in 'fSubjCard.pas' {fmSubjCard},
  fOrgLst in 'fOrgLst.pas' {fmOrgList},
  fSubjLst in 'fSubjLst.pas' {fmSubjList},
  fConfig in 'fConfig.pas' {fmConfig},
  MD5 in 'Common\MD5.PAS',
  fKbdMouHk in 'fKbdMouHk.pas' {fmKbdMouHk},
  exec in 'Common\exec.pas',
  fFltMgr in 'fFltMgr.pas' {fmFltMgr},
  fOrgProp in 'fOrgProp.pas' {fmOrgProp},
  fOrgPropCommon in 'fOrgPropCommon.pas' {fmOrgPropCommon},
  fOrgPropContacts in 'fOrgPropContacts.pas' {fmOrgPropContacts},
  fOrgPropOsnPer in 'fOrgPropOsnPer.pas' {fmOrgPropOsnPer},
  fOrgPropOKONH in 'fOrgPropOKONH.pas' {fmOrgPropOKONH},
  fGetPsw in 'fGetPsw.pas' {fmGetPsw},
  fUsers in 'fUsers.pas' {fmUsers},
  fUserCard in 'fUserCard.pas' {fmUserCard},
  SaveEvents in 'Common\SaveEvents.pas',
  fEventFilter in 'fEventFilter.pas' {fmEventFilter},
  fEventList in 'fEventList.pas' {fmEventList},
  dEventListPrint in 'dEventListPrint.pas' {dmEventListPrint: TDataModule},
  fGeneralQty in 'fGeneralQty.pas' {fmGeneralQty},
  fExportSPO in 'fExportSPO.pas' {fmExportSPO},
  fImportSPO in 'fImportSPO.pas' {fmImportSPO},
  fImportSPOOrg in 'fImportSPOOrg.pas' {fmImportSPOOrg},
  uVERSION in 'uVERSION.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := sAppTitle;
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TdmMain, dmMain);
  Application.Run;
end.
