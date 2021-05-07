program GranVUS;

{$R 'RTF.res' 'RTF.RC'}

uses
  Windows,
  Forms,
  SysUtils,
  fMain in 'fMain.pas' {fmMain},
  fAbout in 'fAbout.pas' {fmAbout},
  msg in 'Common\msg.pas',
  dMain in 'dMain.pas' {dmMain: TDataModule},
  fBaseLst in 'fBaseLst.pas' {fmBaseLst},
  fCfgPlugIns in 'fCfgPlugIns.pas' {fmCfgPlugIns},
  fPersonCard in 'fPersonCard.pas' {fmPersonForm},
  fPersLst in 'fPersLst.pas' {fmPersonList},
  fConfig in 'fConfig.pas' {fmConfig},
  MD5,
  fGetPsw in 'fGetPsw.pas' {fmGetPsw},
  fKbdMouHk in 'fKbdMouHk.pas' {fmKbdMouHk},
  misc,
  fRegister in 'fRegister.pas' {fmRegister},
  fNav in 'fNav.pas' {fmNav},
  fFltMgr in 'fFltMgr.pas' {fmFltMgr},
  uCrypt,
  fOrgPropOsnPer in 'fOrgPropOsnPer.pas' {fmOrgPropOsnPer},
  fOrgProp in 'fOrgProp.pas' {fmOrgProp},
  fOrgPropCommon in 'fOrgPropCommon.pas' {fmOrgPropCommon},
  fOrgPropVoenkom in 'fOrgPropVoenkom.pas' {fmOrgPropVoenkom},
  fOrgPropOKONH in 'fOrgPropOKONH.pas' {fmOrgPropOKONH},
  SaveEvents,
  fEventList in 'fEventList.pas' {fmEventList},
  fASAppointments in 'fASAppointments.pas' {fmASAppointments},
  fUsers in 'fUsers.pas' {fmUsers},
  fUserCard in 'fUserCard.pas' {fmUserCard},
  fEventFilter in 'fEventFilter.pas' {fmEventFilter},
  dEventListPrint in 'dEventListPrint.pas' {dmEventListPrint: TDataModule},
  fTPDP in 'fTPDP.pas' {fmTPDP},
  fTPDPPunkt in 'fTPDPPunkt.pas' {fmTPDPPunkt},
  fTPDPCond in 'fTPDPCond.pas' {fmTPDPCond},
  fTPDPPost in 'fTPDPPost.pas' {fmTPDPPost},
  dSPOBron in 'dSPOBron.pas' {dmSPOBron: TDataModule},
  IniSupport in 'Common\IniSupport.pas',
  fSplashProgress in 'fSplashProgress.pas' {frmSplashProgress},
  uVERSION in 'uVERSION.pas',
  fOrgVUZOnly in 'fOrgVUZOnly.pas' {fmOrgVUZOnly},
  CryptoAPI in 'Crypt\CryptoAPI.pas',
  fPersChangesLst in 'fPersChangesLst.pas' {fmPersonChangesList},
  ColumnCustomize in 'ColumnCustomize.pas' {ColumnCustomizeForm},
  fAppointments in 'fAppointments.pas' {fmAppointments},
  fParamDlg in 'fParamDlg.pas' {fmParamDlg},
  fAsfMtr in 'fAsfMtr.pas' {TfmAsfMtr},
  fAsfMtrList in 'fAsfMtrList.pas' {fmAsfMtrList},
  fASStaffList in 'fASStaffList.pas' {fmASStaffList},
  fSetFilter in 'fSetFilter.pas' {fxSetFilter},
  frmWUch1 in 'frmWUch1.pas' {fWUch1},
  frmWUch2 in 'frmWUch2.pas' {fWUch2},
  fMsgConfirm in 'fMsgConfirm.pas' {fMessageConfirm},
  fStaffList in 'fStaffList.pas' {fmStaffList},
  BirthDay in 'Common\BirthDay.pas',
  uMemoTable in 'uMemoTable.pas',
  fOrgPropContacts in 'fOrgPropContacts.pas' {fmOrgPropContacts},
  Num2Str in 'Common\Num2Str.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := sAppTitle;
  Application.HelpFile := 'GranVUS.HLP';
  IsDemoVersion(true);
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TdmMain, dmMain);
  Application.Run;
end.
