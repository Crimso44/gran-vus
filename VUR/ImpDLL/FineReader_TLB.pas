unit FineReader_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : 1.2
// File generated on 09.04.2008 12:36:06 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Program Files\ABBYY FineReader 6.0 Scripting Edition\Finereader.exe\1 (1)
// LIBID: {39803000-E1EF-11D5-824C-008048AE8B26}
// LCID: 0
// Helpfile: C:\Program Files\ABBYY FineReader 6.0 Scripting Edition\Scripting Edition\FRScripting_Help_English.chm
// HelpString: ABBYY FineReader 6.0 Type Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
// Parent TypeLibrary:
//   (0) v3.2 AIDISFRTlbr, (C:\Program Files\AIDIS 6.51\ScanWS\AIDISFRTlbr.ocx)
// Errors:
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Parameter 'Type' of ICharParams.SetFont changed to 'Type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Parameter 'Type' of IBlocks.AddNew changed to 'Type_'
//   Hint: Parameter 'to' of IBlocks.Renumber changed to 'to_'
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, OleServer, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  FineReaderMajorVersion = 6;
  FineReaderMinorVersion = 0;

  LIBID_FineReader: TGUID = '{39803000-E1EF-11D5-824C-008048AE8B26}';

  IID_IBlock: TGUID = '{39801016-E1EF-11D5-824C-008048AE8B26}';
  IID_IRegion: TGUID = '{3980101C-E1EF-11D5-824C-008048AE8B26}';
  IID_ITextBlockProperties: TGUID = '{39801021-E1EF-11D5-824C-008048AE8B26}';
  IID_IText: TGUID = '{3980101D-E1EF-11D5-824C-008048AE8B26}';
  IID_IParagraphs: TGUID = '{3980101E-E1EF-11D5-824C-008048AE8B26}';
  IID_IParagraph: TGUID = '{39801020-E1EF-11D5-824C-008048AE8B26}';
  IID_ICharParams: TGUID = '{39801028-E1EF-11D5-824C-008048AE8B26}';
  IID_IBarcodeBlockProperties: TGUID = '{39801022-E1EF-11D5-824C-008048AE8B26}';
  IID_ITableBlockProperties: TGUID = '{39801023-E1EF-11D5-824C-008048AE8B26}';
  IID_ITableCells: TGUID = '{39801024-E1EF-11D5-824C-008048AE8B26}';
  IID_ITableCell: TGUID = '{39801025-E1EF-11D5-824C-008048AE8B26}';
  IID_IBlackSeparator: TGUID = '{39801018-E1EF-11D5-824C-008048AE8B26}';
  IID_ITextSelection: TGUID = '{3980101B-E1EF-11D5-824C-008048AE8B26}';
  IID_IImageDocument: TGUID = '{3980101A-E1EF-11D5-824C-008048AE8B26}';
  IID_IImage: TGUID = '{39801026-E1EF-11D5-824C-008048AE8B26}';
  IID_IImageModification: TGUID = '{39801027-E1EF-11D5-824C-008048AE8B26}';
  IID_IBlocks: TGUID = '{39801017-E1EF-11D5-824C-008048AE8B26}';
  IID_IBlackSeparators: TGUID = '{39801019-E1EF-11D5-824C-008048AE8B26}';
  IID_IApplication: TGUID = '{39801001-E1EF-11D5-824C-008048AE8B26}';
  IID_ISettings: TGUID = '{39801002-E1EF-11D5-824C-008048AE8B26}';
  IID_IStringsCollection: TGUID = '{3980100C-E1EF-11D5-824C-008048AE8B26}';
  IID_IBatchPagesCollection: TGUID = '{39801006-E1EF-11D5-824C-008048AE8B26}';
  IID_IBatchPage: TGUID = '{39801004-E1EF-11D5-824C-008048AE8B26}';
  IID_IBatchEvent: TGUID = '{39801008-E1EF-11D5-824C-008048AE8B26}';
  IID_IBatchWindow: TGUID = '{39801009-E1EF-11D5-824C-008048AE8B26}';
  IID_IImageWindow: TGUID = '{3980100A-E1EF-11D5-824C-008048AE8B26}';
  IID_ITextWindow: TGUID = '{3980100B-E1EF-11D5-824C-008048AE8B26}';
  IID_IBatch: TGUID = '{39801003-E1EF-11D5-824C-008048AE8B26}';
  IID_IBatchPages: TGUID = '{39801005-E1EF-11D5-824C-008048AE8B26}';
  IID_IBatchOptions: TGUID = '{39801007-E1EF-11D5-824C-008048AE8B26}';
  IID_IRTFExportParams: TGUID = '{39801010-E1EF-11D5-824C-008048AE8B26}';
  IID_IXLExportParams: TGUID = '{39801012-E1EF-11D5-824C-008048AE8B26}';
  IID_IPDFExportParams: TGUID = '{39801015-E1EF-11D5-824C-008048AE8B26}';
  IID_IDBFExportParams: TGUID = '{39801013-E1EF-11D5-824C-008048AE8B26}';
  IID_IHTMLExportParams: TGUID = '{39801014-E1EF-11D5-824C-008048AE8B26}';
  IID_ITextExportParams: TGUID = '{39801011-E1EF-11D5-824C-008048AE8B26}';
  IID_IToolbar: TGUID = '{3980100D-E1EF-11D5-824C-008048AE8B26}';
  DIID_IApplicationEvents: TGUID = '{3980100E-E1EF-11D5-824C-008048AE8B26}';
  CLASS_Application: TGUID = '{39802001-E1EF-11D5-824C-008048AE8B26}';
  CLASS_Settings: TGUID = '{39802002-E1EF-11D5-824C-008048AE8B26}';
  CLASS_BatchWindow: TGUID = '{39802009-E1EF-11D5-824C-008048AE8B26}';
  CLASS_ImageWindow: TGUID = '{3980200A-E1EF-11D5-824C-008048AE8B26}';
  CLASS_TextWindow: TGUID = '{3980200B-E1EF-11D5-824C-008048AE8B26}';
  CLASS_Batch: TGUID = '{39802003-E1EF-11D5-824C-008048AE8B26}';
  CLASS_toolbar: TGUID = '{3980200D-E1EF-11D5-824C-008048AE8B26}';
  CLASS_BatchPage: TGUID = '{39802004-E1EF-11D5-824C-008048AE8B26}';
  CLASS_BatchPages: TGUID = '{39802005-E1EF-11D5-824C-008048AE8B26}';
  CLASS_BatchPagesCollection: TGUID = '{39802006-E1EF-11D5-824C-008048AE8B26}';
  CLASS_BatchEvent: TGUID = '{39802008-E1EF-11D5-824C-008048AE8B26}';
  CLASS_BatchOptions: TGUID = '{39802007-E1EF-11D5-824C-008048AE8B26}';
  CLASS_RTFExportParams: TGUID = '{39802010-E1EF-11D5-824C-008048AE8B26}';
  CLASS_TextExportParams: TGUID = '{39802011-E1EF-11D5-824C-008048AE8B26}';
  CLASS_XLExportParams: TGUID = '{39802012-E1EF-11D5-824C-008048AE8B26}';
  CLASS_DBFExportParams: TGUID = '{39802013-E1EF-11D5-824C-008048AE8B26}';
  CLASS_HTMLExportParams: TGUID = '{39802014-E1EF-11D5-824C-008048AE8B26}';
  CLASS_PDFExportParams: TGUID = '{39802015-E1EF-11D5-824C-008048AE8B26}';
  CLASS_StringsCollection: TGUID = '{3980200C-E1EF-11D5-824C-008048AE8B26}';
  CLASS_textSelection: TGUID = '{3980201B-E1EF-11D5-824C-008048AE8B26}';
  CLASS_Region: TGUID = '{3980201C-E1EF-11D5-824C-008048AE8B26}';
  CLASS_ImageDocument: TGUID = '{3980201A-E1EF-11D5-824C-008048AE8B26}';
  CLASS_Image: TGUID = '{39802026-E1EF-11D5-824C-008048AE8B26}';
  CLASS_imageModification: TGUID = '{39802027-E1EF-11D5-824C-008048AE8B26}';
  CLASS_Text: TGUID = '{3980201D-E1EF-11D5-824C-008048AE8B26}';
  CLASS_Paragraphs: TGUID = '{3980201E-E1EF-11D5-824C-008048AE8B26}';
  CLASS_Paragraph: TGUID = '{39802020-E1EF-11D5-824C-008048AE8B26}';
  CLASS_TableCells: TGUID = '{39802024-E1EF-11D5-824C-008048AE8B26}';
  CLASS_TableCell: TGUID = '{39802025-E1EF-11D5-824C-008048AE8B26}';
  CLASS_Blocks: TGUID = '{39802017-E1EF-11D5-824C-008048AE8B26}';
  CLASS_block: TGUID = '{39802016-E1EF-11D5-824C-008048AE8B26}';
  CLASS_BlackSeparators: TGUID = '{39802019-E1EF-11D5-824C-008048AE8B26}';
  CLASS_BlackSeparator: TGUID = '{39802018-E1EF-11D5-824C-008048AE8B26}';
  CLASS_TextBlockProperties: TGUID = '{39802021-E1EF-11D5-824C-008048AE8B26}';
  CLASS_BarcodeBlockProperties: TGUID = '{39802022-E1EF-11D5-824C-008048AE8B26}';
  CLASS_TableBlockProperties: TGUID = '{39802023-E1EF-11D5-824C-008048AE8B26}';
  CLASS_CharParams: TGUID = '{39802028-E1EF-11D5-824C-008048AE8B26}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum BlockTypeEnum
type
  BlockTypeEnum = TOleEnum;
const
  BT_Text = $00000000;
  BT_Picture = $00000001;
  BT_Table = $00000002;
  BT_Barcode = $00000003;
  BT_AutoAnalysis = $00000004;

// Constants for enum TextTypeEnum
type
  TextTypeEnum = TOleEnum;
const
  TT_Default = $00000000;
  TT_Normal = $00000001;
  TT_Typewriter = $00000002;
  TT_Matrix = $00000003;

// Constants for enum TextOrientationEnum
type
  TextOrientationEnum = TOleEnum;
const
  TO_Normal = $00000000;
  TO_RotatedClockwise = $00000001;
  TO_RotatedUpsidedown = $00000002;
  TO_RotatedCounterclockwise = $00000003;

// Constants for enum FontTypeEnum
type
  FontTypeEnum = TOleEnum;
const
  FT_Serif = $00000000;
  FT_SansSerif = $00000001;
  FT_MonoSpace = $00000002;

// Constants for enum BarcodeTypeEnum
type
  BarcodeTypeEnum = TOleEnum;
const
  BT_Unknown = $00000000;
  BT_Code39 = $00000001;
  BT_Check_Code39 = $00000002;
  BT_Interleaved25 = $00000004;
  BT_Check_Interleaved25 = $00000008;
  BT_EAN13 = $00000010;
  BT_Code128 = $00000020;
  BT_EAN8 = $00000040;
  BT_Autodetect = $FFFFFFFF;

// Constants for enum BlackSeparatorDirectionEnum
type
  BlackSeparatorDirectionEnum = TOleEnum;
const
  BSD_Vertical = $00000000;
  BSD_Horizontal = $00000001;

// Constants for enum BlackSeparatorTypeEnum
type
  BlackSeparatorTypeEnum = TOleEnum;
const
  BST_Solid = $00000000;
  BST_Dotted = $00000001;

// Constants for enum ImageColorTypeEnum
type
  ImageColorTypeEnum = TOleEnum;
const
  ICT_BlackWhite = $00000000;
  ICT_Gray = $00000001;
  ICT_Color = $00000002;

// Constants for enum ImageFileFormatEnum
type
  ImageFileFormatEnum = TOleEnum;
const
  IFF_UnknownFormat = $00000000;
  IFF_BmpBwUncompressed = $00000001;
  IFF_BmpGrayUncompressed = $00000002;
  IFF_BmpColorUncompressed = $00000003;
  IFF_DcxBwPackbits = $00000004;
  IFF_DcxGrayPackbits = $00000005;
  IFF_JpegGrayJfif = $00000006;
  IFF_JpegColorJfif = $00000007;
  IFF_PcxBwPackbits = $00000008;
  IFF_PcxGrayPackbits = $00000009;
  IFF_PngBwPng = $0000000A;
  IFF_PngGrayPng = $0000000B;
  IFF_PngColorPng = $0000000C;
  IFF_TiffBwUncompressed = $0000000D;
  IFF_TiffBwCcittGroup3 = $0000000E;
  IFF_TiffBwCcittGroup3Fax = $0000000F;
  IFF_TiffBwCcittGroup4 = $00000010;
  IFF_TiffBwPackbits = $00000011;
  IFF_TiffGrayUncompressed = $00000012;
  IFF_TiffGrayPackbits = $00000013;
  IFF_TiffGrayJpegJfif = $00000014;
  IFF_TiffGrayABBYYLossless = $00000015;
  IFF_TiffColorUncompressed = $00000016;
  IFF_TiffColorPackbits = $00000017;
  IFF_TiffColorJpegJfif = $00000018;
  IFF_TiffColorABBYYLossless = $00000019;

// Constants for enum BatchViewModeEnum
type
  BatchViewModeEnum = TOleEnum;
const
  BVM_Thumbnail = $00000000;
  BVM_Details = $00000001;

// Constants for enum WindowPositionEnum
type
  WindowPositionEnum = TOleEnum;
const
  WP_Top = $00000000;
  WP_Left = $00000001;
  WP_Right = $00000002;
  WP_Bottom = $00000003;

// Constants for enum WindowStateEnum
type
  WindowStateEnum = TOleEnum;
const
  WS_Restored = $00000000;
  WS_Minimized = $00000001;
  WS_Maximized = $00000002;

// Constants for enum ToolbarNameEnum
type
  ToolbarNameEnum = TOleEnum;
const
  TN_Standard = $00000000;
  TN_Wizard = $00000001;
  TN_Formatting = $00000002;
  TN_Image = $00000003;
  TN_Custom = $00000004;

// Constants for enum WindowNameEnum
type
  WindowNameEnum = TOleEnum;
const
  WN_Main = $00000000;
  WN_Batch = $00000001;
  WN_Overview = $00000002;
  WN_Text = $00000003;
  WN_Zoom = $00000004;
  WN_AdvancedSearch = $00000005;

// Constants for enum PageColumnAnalysisModeEnum
type
  PageColumnAnalysisModeEnum = TOleEnum;
const
  PCAM_Auto = $00000000;
  PCAM_SingleColumn = $00000001;
  PCAM_SingleColumnSpaceFormatted = $00000002;

// Constants for enum UserPatternModeEnum
type
  UserPatternModeEnum = TOleEnum;
const
  UPM_DontUseUserPattern = $00000000;
  UPM_ReadWithTraining = $00000001;
  UPM_ReadWithUserPattern = $00000002;

// Constants for enum ErrorHighlightLevelEnum
type
  ErrorHighlightLevelEnum = TOleEnum;
const
  EHL_None = $00000000;
  EHL_Scanty = $00000001;
  EHL_Standard = $00000002;
  EHL_Thorough = $00000003;

// Constants for enum FileExportModeEnum
type
  FileExportModeEnum = TOleEnum;
const
  FEM_SingleFile = $00000000;
  FEM_FilePerPage = $00000001;
  FEM_CreateFileOnBlankPages = $00000002;
  FEM_WithImageFilesNames = $00000003;

// Constants for enum ExportPageFormatEnum
type
  ExportPageFormatEnum = TOleEnum;
const
  EPF_PlainText = $00000000;
  EPF_FormattedStream = $00000001;
  EPF_PageLayout = $00000002;

// Constants for enum PDFExportModeEnum
type
  PDFExportModeEnum = TOleEnum;
const
  PEM_TextOnly = $00000000;
  PEM_TextOnImage = $00000001;
  PEM_ImageOnText = $00000002;
  PEM_ImageOnly = $00000003;

// Constants for enum FontFeatureEnum
type
  FontFeatureEnum = TOleEnum;
const
  FF_Normal = $00000000;
  FF_Bold = $00000001;
  FF_Italic = $00000002;
  FF_BoldItalic = $00000003;

// Constants for enum FontModeEnum
type
  FontModeEnum = TOleEnum;
const
  FM_UseStandardFonts = $00000000;
  FM_TypeOneReference = $00000001;
  FM_TypeOneEmbedding = $00000002;

// Constants for enum CodePageTypeEnum
type
  CodePageTypeEnum = TOleEnum;
const
  CPT_ANSI = $00000000;
  CPT_OEM = $00000001;
  CPT_Macintosh = $00000002;
  CPT_ISO = $00000003;

// Constants for enum CodePageEnum
type
  CodePageEnum = TOleEnum;
const
  CP_Null = $00000000;
  CP_Latin = $00000001;
  CP_Cyrillic = $00000002;
  CP_EasternEuropean = $00000003;
  CP_Baltic = $00000004;
  CP_Turkish = $00000005;
  CP_US_MSDOS = $00000006;
  CP_LatinI_MSDOS = $00000007;
  CP_Russian_MSDOS = $00000008;
  CP_Baltic_MSDOS = $00000009;
  CP_Turkish_IBM = $0000000A;
  CP_Slavic_MSDOS = $0000000B;
  CP_Greek = $0000000C;
  CP_Greek_737 = $0000000D;
  CP_Greek_869 = $0000000E;
  CP_Latin_ISO = $00000010;
  CP_EasternEuropean_ISO = $00000011;
  CP_Turkish_ISO = $00000012;
  CP_Baltic_ISO = $00000013;
  CP_Cyrillic_ISO = $00000014;
  CP_Greek_ISO = $00000015;
  CP_KOI8 = $00000016;
  CP_Tatar = $00000017;
  CP_Tatar_MSDOS = $00000018;
  CP_Roman_Macintosh = $00000019;
  CP_Greek_Macintosh = $0000001A;
  CP_Cyrillic_Macintosh = $0000001B;
  CP_Ukrainian_Macintosh = $0000001C;
  CP_Latin2_Macintosh = $0000001D;
  CP_Icelandic_Macintosh = $0000001E;
  CP_Turkish_Macintosh = $0000001F;
  CP_Croatian_Macintosh = $00000020;
  CP_Armenian = $00000021;
  CP_Armenian_MSDOS = $00000022;
  CP_Armenian_Macintosh = $00000023;
  CP_Latin5_ISO = $00000029;

// Constants for enum HTMLFormatModeEnum
type
  HTMLFormatModeEnum = TOleEnum;
const
  HFM_Format32 = $00000000;
  HFM_TwoFormats32_40 = $00000001;
  HFM_Format40 = $00000002;

// Constants for enum BatchTemplateTypeEnum
type
  BatchTemplateTypeEnum = TOleEnum;
const
  BT_Default = $00000000;
  BT_Current = $00000001;
  BT_Path = $00000002;

// Constants for enum ImageOperationEnum
type
  ImageOperationEnum = TOleEnum;
const
  IO_RotateClockwise = $00000000;
  IO_RotateUpsideDown = $00000001;
  IO_RotateCounterclockwise = $00000002;
  IO_Despeckle = $00000003;
  IO_Invert = $00000004;
  IO_FlipHorizontalAxis = $00000005;
  IO_FlipVerticalAxis = $00000006;

// Constants for enum BatchExportFormatEnum
type
  BatchExportFormatEnum = TOleEnum;
const
  BEF_RTF = $00000000;
  BEF_MSWord = $00000001;
  BEF_MSExcel = $00000002;
  BEF_PDF = $00000003;
  BEF_DBF = $00000004;
  BEF_Text = $00000005;
  BEF_UnicodeText_UTF8 = $00000006;
  BEF_UnicodeText_UTF16 = $00000007;
  BEF_CSV = $00000008;
  BEF_UnicodeCSV_UTF8 = $00000009;
  BEF_UnicodeCSV_UTF16 = $0000000A;
  BEF_HTML = $0000000B;
  BEF_UnicodeHTML = $0000000C;

// Constants for enum MenuItemEnum
type
  MenuItemEnum = TOleEnum;
const
  MI_ToolbarSeparator = $00000000;
  MI_FontName = $00000001;
  MI_FontSize = $00000002;
  MI_Scale = $00000003;
  MI_RecognitionLanguage = $00000004;
  MI_OpenImage = $00000005;
  MI_ScanImage = $00000006;
  MI_ScanMultipleImages = $00000007;
  MI_StopScanning = $00000008;
  MI_NewBatch = $00000009;
  MI_OpenBatch = $0000000A;
  MI_CloseBatch = $0000000B;
  MI_SaveWizard = $0000000C;
  MI_SaveTextAs = $0000000D;
  MI_PrintImage = $0000000E;
  MI_PrintText = $0000000F;
  MI_SendSelTo_MicrosoftWord = $00000010;
  MI_SendSelTo_MicrosoftExcel = $00000011;
  MI_SendSelTo_CorelWordPerfect = $00000012;
  MI_SendSelTo_LotusWordPro = $00000013;
  MI_SendSelTo_StarWriter = $00000014;
  MI_SendSelTo_PRObjectMT = $00000015;
  MI_SendSelTo_ODMA = $00000016;
  MI_SendSelTo_MailRecipient = $00000017;
  MI_SendSelTo_WebBrowser = $00000018;
  MI_SendSelTo_Clipboard = $00000019;
  MI_SendAllTo_MicrosoftWord = $0000001A;
  MI_SendAllTo_MicrosoftExcel = $0000001B;
  MI_SendAllTo_CorelWordPerfect = $0000001C;
  MI_SendAllTo_LotusWordPro = $0000001D;
  MI_SendAllTo_StarWriter = $0000001E;
  MI_SendAllTo_PRObjectMT = $0000001F;
  MI_SendAllTo_ODMA = $00000020;
  MI_SendAllTo_MailRecipient = $00000021;
  MI_SendAllTo_WebBrowser = $00000022;
  MI_SendAllTo_Clipboard = $00000023;
  MI_SaveImageAs = $00000024;
  MI_RecentBatch = $00000025;
  MI_DefaultBatch = $00000026;
  MI_Exit = $00000027;
  MI_Undo = $00000028;
  MI_Redo = $00000029;
  MI_Cut = $0000002A;
  MI_Copy = $0000002B;
  MI_Paste = $0000002C;
  MI_Clear = $0000002D;
  MI_SelectAll = $0000002E;
  MI_Find = $0000002F;
  MI_FindNext = $00000030;
  MI_Replace = $00000031;
  MI_AdvancedSearch = $00000032;
  MI_SplitTableCells = $00000033;
  MI_MergeTableCells = $00000034;
  MI_MergeTableRows = $00000035;
  MI_EditCharacters = $00000036;
  MI_FontBold = $00000037;
  MI_FontItalic = $00000038;
  MI_FontUnderlined = $00000039;
  MI_FontStrikeout = $0000003A;
  MI_FontSuperscript = $0000003B;
  MI_FontSubscript = $0000003C;
  MI_AlignParagraphsLeft = $0000003D;
  MI_AlignParagraphsRight = $0000003E;
  MI_CenterParagraphs = $0000003F;
  MI_JustifyParagraphs = $00000040;
  MI_SwitchShowFormatting = $00000041;
  MI_SwitchDraftMode = $00000042;
  MI_Scale_ZoomIn = $00000043;
  MI_Scale_ZoomOut = $00000044;
  MI_ImageScale_200 = $00000045;
  MI_ImageScale_100 = $00000046;
  MI_ImageScale_50 = $00000047;
  MI_ImageScale_25 = $00000048;
  MI_ImageScale_FitToWidth = $00000049;
  MI_ImageScale_FitToHeight = $0000004A;
  MI_ImageScale_BestFit = $0000004B;
  MI_ImageScale_ZoomIn = $0000004C;
  MI_ImageScale_ZoomOut = $0000004D;
  MI_ImageScale_ZoomToSelBlocks = $0000004E;
  MI_ZoomScale_800 = $0000004F;
  MI_ZoomScale_600 = $00000050;
  MI_ZoomScale_400 = $00000051;
  MI_ZoomScale_300 = $00000052;
  MI_ZoomScale_200 = $00000053;
  MI_ZoomScale_100 = $00000054;
  MI_ZoomScale_50 = $00000055;
  MI_ZoomScale_FitToWidth = $00000056;
  MI_ZoomScale_PixelToPixel = $00000057;
  MI_ZoomScale_ZoomIn = $00000058;
  MI_ZoomScale_ZoomOut = $00000059;
  MI_TextScale_200 = $0000005A;
  MI_TextScale_175 = $0000005B;
  MI_TextScale_150 = $0000005C;
  MI_TextScale_125 = $0000005D;
  MI_TextScale_100 = $0000005E;
  MI_TextScale_75 = $0000005F;
  MI_TextScale_50 = $00000060;
  MI_TextScale_ZoomIn = $00000061;
  MI_TextScale_ZoomOut = $00000062;
  MI_TextScale_FitToWidth = $00000063;
  MI_TextScale_FitToHeight = $00000064;
  MI_TextScale_BestFit = $00000065;
  MI_BatchView_Thumbnails = $00000066;
  MI_BatchView_Details = $00000067;
  MI_BatchView_Customize = $00000068;
  MI_BatchWindow_Maximized = $00000069;
  MI_BatchWindow_Left = $0000006A;
  MI_BatchWindow_Top = $0000006B;
  MI_BatchWindow_Right = $0000006C;
  MI_BatchWindow_Bottom = $0000006D;
  MI_ImageText_ShowImageAndText = $0000006E;
  MI_ImageText_ShowImage = $0000006F;
  MI_ImageText_ShowText = $00000070;
  MI_ZoomWindow_Top = $00000071;
  MI_ZoomWindow_Bottom = $00000072;
  MI_ZoomWindow_Hide = $00000073;
  MI_Toolbars_WizardBar = $00000074;
  MI_Toolbars_Standard = $00000075;
  MI_Toolbars_Formatting = $00000076;
  MI_Toolbars_ImageTools = $00000077;
  MI_Toolbars_LargeToolbarButtons = $00000078;
  MI_Toolbars_ExtraLargeWizardBarButtons = $00000079;
  MI_Toolbars_ShowTextLabels = $0000007A;
  MI_StatusBar = $0000007B;
  MI_Properties = $0000007C;
  MI_BatchViewHeaderColumn = $0000007D;
  MI_OpenPage = $0000007E;
  MI_OpenNextPage = $0000007F;
  MI_OpenPrevPage = $00000080;
  MI_GotoPage = $00000081;
  MI_CloseCurrentPage = $00000082;
  MI_RenumberPages = $00000083;
  MI_DeleteText = $00000084;
  MI_DeleteBlocksAndText = $00000085;
  MI_DeletePage = $00000086;
  MI_DeleteBatch = $00000087;
  MI_UpdatePageList = $00000088;
  MI_BlockType_RecognitionArea = $00000089;
  MI_BlockType_Text = $0000008A;
  MI_BlockType_Table = $0000008B;
  MI_BlockType_Picture = $0000008C;
  MI_BlockType_Barcode = $0000008D;
  MI_RotateClockwize = $0000008E;
  MI_RotateCounterClockwize = $0000008F;
  MI_RotateUpsideDown = $00000090;
  MI_FlipHorizontal = $00000091;
  MI_FlipVertical = $00000092;
  MI_ConvertImageToBlackAndWhite = $00000093;
  MI_InvertImage = $00000094;
  MI_DespeckleImage = $00000095;
  MI_DespeckleBlock = $00000096;
  MI_SaveBlocks = $00000097;
  MI_LoadBlocks = $00000098;
  MI_SplitImage = $00000099;
  MI_ChooseTool_DrawRecognitionArea = $0000009A;
  MI_ChooseTool_DrawTextBlock = $0000009B;
  MI_ChooseTool_DrawTableBlock = $0000009C;
  MI_ChooseTool_DrawPictureBlock = $0000009D;
  MI_ChooseTool_SelectObject = $0000009E;
  MI_ChooseTool_AddBlockPart = $0000009F;
  MI_ChooseTool_CutBlockPart = $000000A0;
  MI_ChooseTool_RenumberBlocks = $000000A1;
  MI_ChooseTool_DeleteBlock = $000000A2;
  MI_ChooseTool_AddVertSeparator = $000000A3;
  MI_ChooseTool_AddHorzSeparator = $000000A4;
  MI_ChooseTool_DeleteSeparator = $000000A5;
  MI_ChooseTool_Eraser = $000000A6;
  MI_ScanRead = $000000A7;
  MI_ScanReadMultipleImages = $000000A8;
  MI_OpenRead = $000000A9;
  MI_ScanReadWizard = $000000AA;
  MI_AnalyzeLayout = $000000AB;
  MI_AnalyzeLayoutOnAllPages = $000000AC;
  MI_AnalyzeLayoutInBlock = $000000AD;
  MI_AnalyzeTableStructure = $000000AE;
  MI_Read = $000000AF;
  MI_ReadAllPages = $000000B0;
  MI_ReadBlock = $000000B1;
  MI_StartBackgroundRecognition = $000000B2;
  MI_StopBackgroundRecognition = $000000B3;
  MI_CheckSpelling = $000000B4;
  MI_NextError = $000000B5;
  MI_PrevError = $000000B6;
  MI_ViewDictionaries = $000000B7;
  MI_TranslateWordWithLingvo = $000000B8;
  MI_RemoveHeadersAndFooters = $000000B9;
  MI_LanguageEditor = $000000BA;
  MI_PatternEditor = $000000BB;
  MI_ScannerSettings = $000000BC;
  MI_FormatsSettings = $000000BD;
  MI_Options = $000000BE;
  MI_ReadOptions = $000000BF;
  MI_ProofOptions = $000000C0;
  MI_ExportOptions = $000000C1;
  MI_ScanOptions = $000000C2;
  MI_Customize = $000000C3;
  MI_NextWindow = $000000C4;
  MI_PrevWindow = $000000C5;
  MI_ArrangeWindows = $000000C6;
  MI_BatchWindow = $000000C7;
  MI_ImageWindow = $000000C8;
  MI_TextWindow = $000000C9;
  MI_ZoomWindow = $000000CA;
  MI_AdvancedSearchWindow = $000000CB;
  MI_HelpTopics = $000000CC;
  MI_Tutorial = $000000CD;
  MI_TechnicalSupport = $000000CE;
  MI_HowToBuyABBYYFineReader = $000000CF;
  MI_Register = $000000D0;
  MI_About = $000000D1;
  MI_WWWLink = $000000D2;
  MI_CustomCommand1 = $000000D3;
  MI_CustomCommand2 = $000000D4;
  MI_CustomCommand3 = $000000D5;
  MI_CustomCommand4 = $000000D6;
  MI_CustomCommand5 = $000000D7;
  MI_CustomCommand6 = $000000D8;
  MI_CustomCommand7 = $000000D9;
  MI_CustomCommand8 = $000000DA;
  MI_CustomCommand9 = $000000DB;
  MI_CustomCommand10 = $000000DC;
  MI_CustomCommand11 = $000000DD;
  MI_CustomCommand12 = $000000DE;
  MI_CustomCommand13 = $000000DF;
  MI_CustomCommand14 = $000000E0;
  MI_CustomCommand15 = $000000E1;
  MI_CustomCommand16 = $000000E2;
  MI_CustomCommand17 = $000000E3;
  MI_CustomCommand18 = $000000E4;
  MI_CustomCommand19 = $000000E5;
  MI_CustomCommand20 = $000000E6;
  MI_CustomCommand21 = $000000E7;
  MI_CustomCommand22 = $000000E8;
  MI_CustomCommand23 = $000000E9;
  MI_CustomCommand24 = $000000EA;
  MI_CustomCommand25 = $000000EB;
  MI_CustomCommand26 = $000000EC;
  MI_CustomCommand27 = $000000ED;
  MI_CustomCommand28 = $000000EE;
  MI_CustomCommand29 = $000000EF;
  MI_CustomCommand30 = $000000F0;
  MI_CustomCommand31 = $000000F1;
  MI_CustomCommand32 = $000000F2;

// Constants for enum OperationTypeEnum
type
  OperationTypeEnum = TOleEnum;
const
  OT_LoadingBlocks = $00000000;
  OT_SendingToExternApp = $00000001;
  OT_SavingToFile = $00000002;
  OT_SavingImage = $00000003;
  OT_Recognition = $00000004;
  OT_Analysing = $00000005;
  OT_ImageOperation = $00000006;
  OT_AddingImage = $00000007;
  OT_AdvancedSearching = $00000008;

// Constants for enum PasswordResultEnum
type
  PasswordResultEnum = TOleEnum;
const
  PR_OK = $00000000;
  PR_Try = $00000001;
  PR_Skip = $00000002;
  PR_Cancel = $00000003;
  PR_ShowDialog = $00000004;

// Constants for enum ScaleTypeEnum
type
  ScaleTypeEnum = TOleEnum;
const
  ST_Width = $FFFFFFFF;
  ST_Height = $FFFFFFFE;
  ST_Whole = $FFFFFFFD;
  ST_PixelToPixel = $FFFFFFFC;

// Constants for enum ResetOptionsFlagsEnum
type
  ResetOptionsFlagsEnum = TOleEnum;
const
  ROF_BatchOptions = $00000001;
  ROF_UserPatterns = $00000002;
  ROF_LanguageDatabase = $00000004;
  ROF_ScannerSettings = $00000008;
  ROF_All = $FFFFFFFF;

// Constants for enum CommonConstantsEnum
type
  CommonConstantsEnum = TOleEnum;
const
  PageNumberAtEnd = $FFFFFFFF;

// Constants for enum BatchPageChangesFlagsEnum
type
  BatchPageChangesFlagsEnum = TOleEnum;
const
  BPCF_NewPage = $00000001;
  BPCF_AttributesChanged = $00000002;
  BPCF_PagePreviewChanged = $00000004;

// Constants for enum CharacterAttributesEnum
type
  CharacterAttributesEnum = TOleEnum;
const
  CA_BOLD = $00000001;
  CA_ITALIC = $00000002;
  CA_UNDERLINED = $00000004;
  CA_STRIKEOUT = $00000008;
  CA_SUBSCRIPT = $00000010;
  CA_SUPERSCRIPT = $00000020;
  CA_SMALL_CAPS = $00000040;
  CA_HIDDEN = $00000080;
  CA_SUSPICIOUS = $00000100;
  CA_PROOFED = $00001000;

// Constants for enum CharAttribEnum
type
  CharAttribEnum = TOleEnum;
const
  CAC_Bold = $00000001;
  CAC_Italic = $00000002;
  CAC_Underlined = $00000004;
  CAC_Strikeout = $00000008;
  CAC_Subscript = $00000010;
  CAC_Superscript = $00000020;
  CAC_SmallCaps = $00000040;
  CAC_Hidden = $00000080;
  CAC_Suspicious = $00000100;
  CAC_UncertainHeight = $00000800;
  CAC_Proofed = $00001000;
  CAC_BaseLine = $00200000;
  CAC_CharacterHeight = $00400000;
  CAC_Rectangle = $01000000;
  CAC_FontSize = $08000000;
  CAC_FontName = $10000000;
  CAC_HorizontalScale = $20000000;
  CAC_Spacing = $40000000;
  CAC_Color = $80000000;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IBlock = interface;
  IBlockDisp = dispinterface;
  IRegion = interface;
  IRegionDisp = dispinterface;
  ITextBlockProperties = interface;
  ITextBlockPropertiesDisp = dispinterface;
  IText = interface;
  ITextDisp = dispinterface;
  IParagraphs = interface;
  IParagraphsDisp = dispinterface;
  IParagraph = interface;
  IParagraphDisp = dispinterface;
  ICharParams = interface;
  ICharParamsDisp = dispinterface;
  IBarcodeBlockProperties = interface;
  IBarcodeBlockPropertiesDisp = dispinterface;
  ITableBlockProperties = interface;
  ITableBlockPropertiesDisp = dispinterface;
  ITableCells = interface;
  ITableCellsDisp = dispinterface;
  ITableCell = interface;
  ITableCellDisp = dispinterface;
  IBlackSeparator = interface;
  IBlackSeparatorDisp = dispinterface;
  ITextSelection = interface;
  ITextSelectionDisp = dispinterface;
  IImageDocument = interface;
  IImageDocumentDisp = dispinterface;
  IImage = interface;
  IImageDisp = dispinterface;
  IImageModification = interface;
  IImageModificationDisp = dispinterface;
  IBlocks = interface;
  IBlocksDisp = dispinterface;
  IBlackSeparators = interface;
  IBlackSeparatorsDisp = dispinterface;
  IApplication = interface;
  IApplicationDisp = dispinterface;
  ISettings = interface;
  ISettingsDisp = dispinterface;
  IStringsCollection = interface;
  IStringsCollectionDisp = dispinterface;
  IBatchPagesCollection = interface;
  IBatchPagesCollectionDisp = dispinterface;
  IBatchPage = interface;
  IBatchPageDisp = dispinterface;
  IBatchEvent = interface;
  IBatchEventDisp = dispinterface;
  IBatchWindow = interface;
  IBatchWindowDisp = dispinterface;
  IImageWindow = interface;
  IImageWindowDisp = dispinterface;
  ITextWindow = interface;
  ITextWindowDisp = dispinterface;
  IBatch = interface;
  IBatchDisp = dispinterface;
  IBatchPages = interface;
  IBatchPagesDisp = dispinterface;
  IBatchOptions = interface;
  IBatchOptionsDisp = dispinterface;
  IRTFExportParams = interface;
  IRTFExportParamsDisp = dispinterface;
  IXLExportParams = interface;
  IXLExportParamsDisp = dispinterface;
  IPDFExportParams = interface;
  IPDFExportParamsDisp = dispinterface;
  IDBFExportParams = interface;
  IDBFExportParamsDisp = dispinterface;
  IHTMLExportParams = interface;
  IHTMLExportParamsDisp = dispinterface;
  ITextExportParams = interface;
  ITextExportParamsDisp = dispinterface;
  IToolbar = interface;
  IToolbarDisp = dispinterface;
  IApplicationEvents = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  Application = IApplication;
  Settings = ISettings;
  BatchWindow = IBatchWindow;
  ImageWindow = IImageWindow;
  TextWindow = ITextWindow;
  Batch = IBatch;
  toolbar = IToolbar;
  BatchPage = IBatchPage;
  BatchPages = IBatchPages;
  BatchPagesCollection = IBatchPagesCollection;
  BatchEvent = IBatchEvent;
  BatchOptions = IBatchOptions;
  RTFExportParams = IRTFExportParams;
  TextExportParams = ITextExportParams;
  XLExportParams = IXLExportParams;
  DBFExportParams = IDBFExportParams;
  HTMLExportParams = IHTMLExportParams;
  PDFExportParams = IPDFExportParams;
  StringsCollection = IStringsCollection;
  textSelection = ITextSelection;
  Region = IRegion;
  ImageDocument = IImageDocument;
  Image = IImage;
  imageModification = IImageModification;
  Text = IText;
  Paragraphs = IParagraphs;
  Paragraph = IParagraph;
  TableCells = ITableCells;
  TableCell = ITableCell;
  Blocks = IBlocks;
  block = IBlock;
  BlackSeparators = IBlackSeparators;
  BlackSeparator = IBlackSeparator;
  TextBlockProperties = ITextBlockProperties;
  BarcodeBlockProperties = IBarcodeBlockProperties;
  TableBlockProperties = ITableBlockProperties;
  CharParams = ICharParams;


// *********************************************************************//
// Interface: IBlock
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801016-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IBlock = interface(IDispatch)
    ['{39801016-E1EF-11D5-824C-008048AE8B26}']
    function Get_Application: IDispatch; safecall;
    function Get_IsRecognized: WordBool; safecall;
    function Get_Region: IRegion; safecall;
    function Get_IsSelected: WordBool; safecall;
    procedure Set_IsSelected(pVal: WordBool); safecall;
    function Get_type_: BlockTypeEnum; safecall;
    procedure Move(deltaX: Integer; deltaY: Integer); safecall;
    function Get_TextBlockProperties: ITextBlockProperties; safecall;
    function Get_BarcodeBlockProperties: IBarcodeBlockProperties; safecall;
    function Get_TableBlockProperties: ITableBlockProperties; safecall;
    function Get_UserProperty(const name: WideString): OleVariant; safecall;
    procedure Set_UserProperty(const name: WideString; pVal: OleVariant); safecall;
    function Get_Number: Integer; safecall;
    function Get_FillColor: Integer; safecall;
    procedure Set_FillColor(pVal: Integer); safecall;
    property Application: IDispatch read Get_Application;
    property IsRecognized: WordBool read Get_IsRecognized;
    property Region: IRegion read Get_Region;
    property IsSelected: WordBool read Get_IsSelected write Set_IsSelected;
    property type_: BlockTypeEnum read Get_type_;
    property TextBlockProperties: ITextBlockProperties read Get_TextBlockProperties;
    property BarcodeBlockProperties: IBarcodeBlockProperties read Get_BarcodeBlockProperties;
    property TableBlockProperties: ITableBlockProperties read Get_TableBlockProperties;
    property UserProperty[const name: WideString]: OleVariant read Get_UserProperty write Set_UserProperty;
    property Number: Integer read Get_Number;
    property FillColor: Integer read Get_FillColor write Set_FillColor;
  end;

// *********************************************************************//
// DispIntf:  IBlockDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801016-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IBlockDisp = dispinterface
    ['{39801016-E1EF-11D5-824C-008048AE8B26}']
    property Application: IDispatch readonly dispid 1;
    property IsRecognized: WordBool readonly dispid 2;
    property Region: IRegion readonly dispid 3;
    property IsSelected: WordBool dispid 4;
    property type_: BlockTypeEnum readonly dispid 6;
    procedure Move(deltaX: Integer; deltaY: Integer); dispid 7;
    property TextBlockProperties: ITextBlockProperties readonly dispid 8;
    property BarcodeBlockProperties: IBarcodeBlockProperties readonly dispid 9;
    property TableBlockProperties: ITableBlockProperties readonly dispid 12;
    property UserProperty[const name: WideString]: OleVariant dispid 13;
    property Number: Integer readonly dispid 14;
    property FillColor: Integer dispid 15;
  end;

// *********************************************************************//
// Interface: IRegion
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {3980101C-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IRegion = interface(IDispatch)
    ['{3980101C-E1EF-11D5-824C-008048AE8B26}']
    function Get_Application: IDispatch; safecall;
    procedure AddRect(Left: Integer; Top: Integer; Right: Integer; Bottom: Integer); safecall;
    procedure MakeEmpty; safecall;
    function Get_Count: Integer; safecall;
    function Get_Left(index: Integer): Integer; safecall;
    function Get_Top(index: Integer): Integer; safecall;
    function Get_Right(index: Integer): Integer; safecall;
    function Get_Bottom(index: Integer): Integer; safecall;
    procedure CopyFrom(const another: IRegion); safecall;
    procedure SaveToFile(const path: WideString); safecall;
    procedure LoadFromFile(const path: WideString); safecall;
    function SaveToMemory: Integer; safecall;
    procedure LoadFromMemory(hGlobal: Integer); safecall;
    property Application: IDispatch read Get_Application;
    property Count: Integer read Get_Count;
    property Left[index: Integer]: Integer read Get_Left;
    property Top[index: Integer]: Integer read Get_Top;
    property Right[index: Integer]: Integer read Get_Right;
    property Bottom[index: Integer]: Integer read Get_Bottom;
  end;

// *********************************************************************//
// DispIntf:  IRegionDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {3980101C-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IRegionDisp = dispinterface
    ['{3980101C-E1EF-11D5-824C-008048AE8B26}']
    property Application: IDispatch readonly dispid 1;
    procedure AddRect(Left: Integer; Top: Integer; Right: Integer; Bottom: Integer); dispid 2;
    procedure MakeEmpty; dispid 3;
    property Count: Integer readonly dispid 4;
    property Left[index: Integer]: Integer readonly dispid 5;
    property Top[index: Integer]: Integer readonly dispid 6;
    property Right[index: Integer]: Integer readonly dispid 7;
    property Bottom[index: Integer]: Integer readonly dispid 8;
    procedure CopyFrom(const another: IRegion); dispid 9;
    procedure SaveToFile(const path: WideString); dispid 10;
    procedure LoadFromFile(const path: WideString); dispid 11;
    function SaveToMemory: Integer; dispid 12;
    procedure LoadFromMemory(hGlobal: Integer); dispid 13;
  end;

// *********************************************************************//
// Interface: ITextBlockProperties
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801021-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  ITextBlockProperties = interface(IDispatch)
    ['{39801021-E1EF-11D5-824C-008048AE8B26}']
    function Get_Application: IDispatch; safecall;
    function Get_IsInverted: WordBool; safecall;
    procedure Set_IsInverted(pVal: WordBool); safecall;
    function Get_IsMirrored: WordBool; safecall;
    procedure Set_IsMirrored(pVal: WordBool); safecall;
    function Get_Language: WideString; safecall;
    procedure Set_Language(const pVal: WideString); safecall;
    function Get_TextType: TextTypeEnum; safecall;
    procedure Set_TextType(pVal: TextTypeEnum); safecall;
    function Get_TextOrientation: TextOrientationEnum; safecall;
    procedure Set_TextOrientation(pVal: TextOrientationEnum); safecall;
    function Get_Text: IText; safecall;
    property Application: IDispatch read Get_Application;
    property IsInverted: WordBool read Get_IsInverted write Set_IsInverted;
    property IsMirrored: WordBool read Get_IsMirrored write Set_IsMirrored;
    property Language: WideString read Get_Language write Set_Language;
    property TextType: TextTypeEnum read Get_TextType write Set_TextType;
    property TextOrientation: TextOrientationEnum read Get_TextOrientation write Set_TextOrientation;
    property Text: IText read Get_Text;
  end;

// *********************************************************************//
// DispIntf:  ITextBlockPropertiesDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801021-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  ITextBlockPropertiesDisp = dispinterface
    ['{39801021-E1EF-11D5-824C-008048AE8B26}']
    property Application: IDispatch readonly dispid 1;
    property IsInverted: WordBool dispid 2;
    property IsMirrored: WordBool dispid 3;
    property Language: WideString dispid 4;
    property TextType: TextTypeEnum dispid 5;
    property TextOrientation: TextOrientationEnum dispid 6;
    property Text: IText readonly dispid 7;
  end;

// *********************************************************************//
// Interface: IText
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {3980101D-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IText = interface(IDispatch)
    ['{3980101D-E1EF-11D5-824C-008048AE8B26}']
    function Get_Application: IDispatch; safecall;
    function Get_IsMirrored: WordBool; safecall;
    procedure Set_IsMirrored(pVal: WordBool); safecall;
    function Get_IsInverted: WordBool; safecall;
    procedure Set_IsInverted(pVal: WordBool); safecall;
    function Get_Paragraphs: IParagraphs; safecall;
    function Get_BackgroundColor: Integer; safecall;
    procedure Set_BackgroundColor(pVal: Integer); safecall;
    function Get_TextOrientation: TextOrientationEnum; safecall;
    procedure Set_TextOrientation(pVal: TextOrientationEnum); safecall;
    procedure Insert(Paragraph: Integer; symbol: Integer; const Text: IText); safecall;
    procedure Append(const Text: IText); safecall;
    procedure InsertParagraphBreak(Paragraph: Integer; symbol: Integer); safecall;
    procedure AppendEmptyParagraph; safecall;
    procedure Remove(fromParagraph: Integer; fromSymbol: Integer; toParagraph: Integer; 
                     toSymbol: Integer); safecall;
    procedure RemoveAll; safecall;
    procedure SeparateHorz(separator: Integer; var topPart: IText; var bottomPart: IText); safecall;
    procedure SeparateVert(separator: Integer; var leftPart: IText; var rightPart: IText); safecall;
    function GetRange(fromParagraph: Integer; fromSymbol: Integer; toParagraph: Integer; 
                      toSymbol: Integer): IText; safecall;
    procedure DiscardRectangles; safecall;
    procedure DiscardExtendedRecAttributes; safecall;
    property Application: IDispatch read Get_Application;
    property IsMirrored: WordBool read Get_IsMirrored write Set_IsMirrored;
    property IsInverted: WordBool read Get_IsInverted write Set_IsInverted;
    property Paragraphs: IParagraphs read Get_Paragraphs;
    property BackgroundColor: Integer read Get_BackgroundColor write Set_BackgroundColor;
    property TextOrientation: TextOrientationEnum read Get_TextOrientation write Set_TextOrientation;
  end;

// *********************************************************************//
// DispIntf:  ITextDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {3980101D-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  ITextDisp = dispinterface
    ['{3980101D-E1EF-11D5-824C-008048AE8B26}']
    property Application: IDispatch readonly dispid 1;
    property IsMirrored: WordBool dispid 2;
    property IsInverted: WordBool dispid 3;
    property Paragraphs: IParagraphs readonly dispid 5;
    property BackgroundColor: Integer dispid 6;
    property TextOrientation: TextOrientationEnum dispid 7;
    procedure Insert(Paragraph: Integer; symbol: Integer; const Text: IText); dispid 8;
    procedure Append(const Text: IText); dispid 9;
    procedure InsertParagraphBreak(Paragraph: Integer; symbol: Integer); dispid 10;
    procedure AppendEmptyParagraph; dispid 11;
    procedure Remove(fromParagraph: Integer; fromSymbol: Integer; toParagraph: Integer; 
                     toSymbol: Integer); dispid 12;
    procedure RemoveAll; dispid 13;
    procedure SeparateHorz(separator: Integer; var topPart: IText; var bottomPart: IText); dispid 14;
    procedure SeparateVert(separator: Integer; var leftPart: IText; var rightPart: IText); dispid 15;
    function GetRange(fromParagraph: Integer; fromSymbol: Integer; toParagraph: Integer; 
                      toSymbol: Integer): IText; dispid 16;
    procedure DiscardRectangles; dispid 17;
    procedure DiscardExtendedRecAttributes; dispid 18;
  end;

// *********************************************************************//
// Interface: IParagraphs
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {3980101E-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IParagraphs = interface(IDispatch)
    ['{3980101E-E1EF-11D5-824C-008048AE8B26}']
    function Get_Application: IDispatch; safecall;
    function Get__NewEnum: IUnknown; safecall;
    function Get_Count: Integer; safecall;
    function Item(index: Integer): IParagraph; safecall;
    function Find(const Paragraph: IParagraph): Integer; safecall;
    property Application: IDispatch read Get_Application;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  IParagraphsDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {3980101E-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IParagraphsDisp = dispinterface
    ['{3980101E-E1EF-11D5-824C-008048AE8B26}']
    property Application: IDispatch readonly dispid 1;
    property _NewEnum: IUnknown readonly dispid -4;
    property Count: Integer readonly dispid 2;
    function Item(index: Integer): IParagraph; dispid 0;
    function Find(const Paragraph: IParagraph): Integer; dispid 3;
  end;

// *********************************************************************//
// Interface: IParagraph
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801020-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IParagraph = interface(IDispatch)
    ['{39801020-E1EF-11D5-824C-008048AE8B26}']
    function Get_Application: IDispatch; safecall;
    function Get_ParentText: IText; safecall;
    function Get_Left: Integer; safecall;
    function Get_Top: Integer; safecall;
    function Get_Right: Integer; safecall;
    function Get_Bottom: Integer; safecall;
    function Get_Text: WideString; safecall;
    function Get_Length: Integer; safecall;
    procedure GetCharactersInfo(out lefts: PSafeArray; out tops: PSafeArray; 
                                out widths: PSafeArray; out heights: PSafeArray; 
                                out attributes: PSafeArray; out colors: PSafeArray; 
                                out fontSizes: PSafeArray; out fontTypes: PSafeArray); safecall;
    procedure GetCharParams(pos: Integer; var params: ICharParams); safecall;
    procedure SetCharParams(pos: Integer; Count: Integer; const params: ICharParams; mask: Integer); safecall;
    procedure Insert(pos: Integer; const ch: WideString); safecall;
    function Get_FirstLineIndent: Integer; safecall;
    function Get_LineSpacing: Integer; safecall;
    procedure Set_LineSpacing(pVal: Integer); safecall;
    property Application: IDispatch read Get_Application;
    property ParentText: IText read Get_ParentText;
    property Left: Integer read Get_Left;
    property Top: Integer read Get_Top;
    property Right: Integer read Get_Right;
    property Bottom: Integer read Get_Bottom;
    property Text: WideString read Get_Text;
    property Length: Integer read Get_Length;
    property FirstLineIndent: Integer read Get_FirstLineIndent;
    property LineSpacing: Integer read Get_LineSpacing write Set_LineSpacing;
  end;

// *********************************************************************//
// DispIntf:  IParagraphDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801020-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IParagraphDisp = dispinterface
    ['{39801020-E1EF-11D5-824C-008048AE8B26}']
    property Application: IDispatch readonly dispid 1;
    property ParentText: IText readonly dispid 2;
    property Left: Integer readonly dispid 5;
    property Top: Integer readonly dispid 6;
    property Right: Integer readonly dispid 7;
    property Bottom: Integer readonly dispid 8;
    property Text: WideString readonly dispid 10;
    property Length: Integer readonly dispid 11;
    procedure GetCharactersInfo(out lefts: {??PSafeArray}OleVariant; 
                                out tops: {??PSafeArray}OleVariant; 
                                out widths: {??PSafeArray}OleVariant; 
                                out heights: {??PSafeArray}OleVariant; 
                                out attributes: {??PSafeArray}OleVariant; 
                                out colors: {??PSafeArray}OleVariant; 
                                out fontSizes: {??PSafeArray}OleVariant; 
                                out fontTypes: {??PSafeArray}OleVariant); dispid 18;
    procedure GetCharParams(pos: Integer; var params: ICharParams); dispid 12;
    procedure SetCharParams(pos: Integer; Count: Integer; const params: ICharParams; mask: Integer); dispid 13;
    procedure Insert(pos: Integer; const ch: WideString); dispid 16;
    property FirstLineIndent: Integer readonly dispid 19;
    property LineSpacing: Integer dispid 20;
  end;

// *********************************************************************//
// Interface: ICharParams
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801028-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  ICharParams = interface(IDispatch)
    ['{39801028-E1EF-11D5-824C-008048AE8B26}']
    function Get_Application: IDispatch; safecall;
    function Get_IsBold: WordBool; safecall;
    procedure Set_IsBold(Result: WordBool); safecall;
    function Get_IsItalic: WordBool; safecall;
    procedure Set_IsItalic(Result: WordBool); safecall;
    function Get_IsUnderlined: WordBool; safecall;
    procedure Set_IsUnderlined(Result: WordBool); safecall;
    function Get_IsStrikeout: WordBool; safecall;
    procedure Set_IsStrikeout(Result: WordBool); safecall;
    function Get_IsSubscript: WordBool; safecall;
    procedure Set_IsSubscript(Result: WordBool); safecall;
    function Get_IsSuperscript: WordBool; safecall;
    procedure Set_IsSuperscript(Result: WordBool); safecall;
    function Get_IsSmallCaps: WordBool; safecall;
    procedure Set_IsSmallCaps(Result: WordBool); safecall;
    function Get_IsHidden: WordBool; safecall;
    procedure Set_IsHidden(Result: WordBool); safecall;
    function Get_IsSuspicious: WordBool; safecall;
    procedure Set_IsSuspicious(Result: WordBool); safecall;
    function Get_HasUncertainHeight: WordBool; safecall;
    procedure Set_HasUncertainHeight(Result: WordBool); safecall;
    function Get_IsProofed: WordBool; safecall;
    procedure Set_IsProofed(Result: WordBool); safecall;
    procedure CopyFrom(const From: ICharParams); safecall;
    function Get_FontSize: Integer; safecall;
    procedure Set_FontSize(Result: Integer); safecall;
    function Get_FontName: WideString; safecall;
    function Get_FontType: FontTypeEnum; safecall;
    procedure SetFont(const Face: WideString; Type_: FontTypeEnum); safecall;
    function Get_HorizontalScale: Integer; safecall;
    procedure Set_HorizontalScale(Result: Integer); safecall;
    function Get_Spacing: Integer; safecall;
    procedure Set_Spacing(Result: Integer); safecall;
    function Get_CharacterHeight: Integer; safecall;
    procedure Set_CharacterHeight(Result: Integer); safecall;
    function Get_BaseLine: Integer; safecall;
    procedure Set_BaseLine(Result: Integer); safecall;
    function Get_Color: Integer; safecall;
    procedure Set_Color(Result: Integer); safecall;
    function Get_Left: Integer; safecall;
    function Get_Top: Integer; safecall;
    function Get_Right: Integer; safecall;
    function Get_Bottom: Integer; safecall;
    procedure SetRect(Left: Integer; Top: Integer; Right: Integer; Bottom: Integer); safecall;
    property Application: IDispatch read Get_Application;
    property IsBold: WordBool read Get_IsBold write Set_IsBold;
    property IsItalic: WordBool read Get_IsItalic write Set_IsItalic;
    property IsUnderlined: WordBool read Get_IsUnderlined write Set_IsUnderlined;
    property IsStrikeout: WordBool read Get_IsStrikeout write Set_IsStrikeout;
    property IsSubscript: WordBool read Get_IsSubscript write Set_IsSubscript;
    property IsSuperscript: WordBool read Get_IsSuperscript write Set_IsSuperscript;
    property IsSmallCaps: WordBool read Get_IsSmallCaps write Set_IsSmallCaps;
    property IsHidden: WordBool read Get_IsHidden write Set_IsHidden;
    property IsSuspicious: WordBool read Get_IsSuspicious write Set_IsSuspicious;
    property HasUncertainHeight: WordBool read Get_HasUncertainHeight write Set_HasUncertainHeight;
    property IsProofed: WordBool read Get_IsProofed write Set_IsProofed;
    property FontSize: Integer read Get_FontSize write Set_FontSize;
    property FontName: WideString read Get_FontName;
    property FontType: FontTypeEnum read Get_FontType;
    property HorizontalScale: Integer read Get_HorizontalScale write Set_HorizontalScale;
    property Spacing: Integer read Get_Spacing write Set_Spacing;
    property CharacterHeight: Integer read Get_CharacterHeight write Set_CharacterHeight;
    property BaseLine: Integer read Get_BaseLine write Set_BaseLine;
    property Color: Integer read Get_Color write Set_Color;
    property Left: Integer read Get_Left;
    property Top: Integer read Get_Top;
    property Right: Integer read Get_Right;
    property Bottom: Integer read Get_Bottom;
  end;

// *********************************************************************//
// DispIntf:  ICharParamsDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801028-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  ICharParamsDisp = dispinterface
    ['{39801028-E1EF-11D5-824C-008048AE8B26}']
    property Application: IDispatch readonly dispid 1;
    property IsBold: WordBool dispid 2;
    property IsItalic: WordBool dispid 3;
    property IsUnderlined: WordBool dispid 4;
    property IsStrikeout: WordBool dispid 5;
    property IsSubscript: WordBool dispid 6;
    property IsSuperscript: WordBool dispid 7;
    property IsSmallCaps: WordBool dispid 8;
    property IsHidden: WordBool dispid 9;
    property IsSuspicious: WordBool dispid 10;
    property HasUncertainHeight: WordBool dispid 11;
    property IsProofed: WordBool dispid 12;
    procedure CopyFrom(const From: ICharParams); dispid 13;
    property FontSize: Integer dispid 14;
    property FontName: WideString readonly dispid 15;
    property FontType: FontTypeEnum readonly dispid 16;
    procedure SetFont(const Face: WideString; Type_: FontTypeEnum); dispid 17;
    property HorizontalScale: Integer dispid 18;
    property Spacing: Integer dispid 19;
    property CharacterHeight: Integer dispid 20;
    property BaseLine: Integer dispid 21;
    property Color: Integer dispid 22;
    property Left: Integer readonly dispid 23;
    property Top: Integer readonly dispid 24;
    property Right: Integer readonly dispid 25;
    property Bottom: Integer readonly dispid 26;
    procedure SetRect(Left: Integer; Top: Integer; Right: Integer; Bottom: Integer); dispid 27;
  end;

// *********************************************************************//
// Interface: IBarcodeBlockProperties
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801022-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IBarcodeBlockProperties = interface(IDispatch)
    ['{39801022-E1EF-11D5-824C-008048AE8B26}']
    function Get_Application: IDispatch; safecall;
    function Get_BarcodeType: BarcodeTypeEnum; safecall;
    procedure Set_BarcodeType(pVal: BarcodeTypeEnum); safecall;
    function Get_RecognizedBarcodeType: BarcodeTypeEnum; safecall;
    procedure Set_RecognizedBarcodeType(pVal: BarcodeTypeEnum); safecall;
    function Get_Text: IText; safecall;
    property Application: IDispatch read Get_Application;
    property BarcodeType: BarcodeTypeEnum read Get_BarcodeType write Set_BarcodeType;
    property RecognizedBarcodeType: BarcodeTypeEnum read Get_RecognizedBarcodeType write Set_RecognizedBarcodeType;
    property Text: IText read Get_Text;
  end;

// *********************************************************************//
// DispIntf:  IBarcodeBlockPropertiesDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801022-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IBarcodeBlockPropertiesDisp = dispinterface
    ['{39801022-E1EF-11D5-824C-008048AE8B26}']
    property Application: IDispatch readonly dispid 1;
    property BarcodeType: BarcodeTypeEnum dispid 2;
    property RecognizedBarcodeType: BarcodeTypeEnum dispid 3;
    property Text: IText readonly dispid 4;
  end;

// *********************************************************************//
// Interface: ITableBlockProperties
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801023-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  ITableBlockProperties = interface(IDispatch)
    ['{39801023-E1EF-11D5-824C-008048AE8B26}']
    function Get_Application: IDispatch; safecall;
    function Get_Cells: ITableCells; safecall;
    procedure FindBaseCellFromPoint(pointX: Integer; pointY: Integer; var baseX: Integer; 
                                    var baseY: Integer); safecall;
    property Application: IDispatch read Get_Application;
    property Cells: ITableCells read Get_Cells;
  end;

// *********************************************************************//
// DispIntf:  ITableBlockPropertiesDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801023-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  ITableBlockPropertiesDisp = dispinterface
    ['{39801023-E1EF-11D5-824C-008048AE8B26}']
    property Application: IDispatch readonly dispid 1;
    property Cells: ITableCells readonly dispid 3;
    procedure FindBaseCellFromPoint(pointX: Integer; pointY: Integer; var baseX: Integer; 
                                    var baseY: Integer); dispid 6;
  end;

// *********************************************************************//
// Interface: ITableCells
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801024-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  ITableCells = interface(IDispatch)
    ['{39801024-E1EF-11D5-824C-008048AE8B26}']
    function Get_Application: IDispatch; safecall;
    function Get__NewEnum: IUnknown; safecall;
    function Get_Count: Integer; safecall;
    function Item(index: Integer): ITableCell; safecall;
    procedure Merge(Left: Integer; Top: Integer; Right: Integer; Bottom: Integer); safecall;
    procedure Split(Left: Integer; Top: Integer; Right: Integer; Bottom: Integer); safecall;
    function FindCellIndex(x: Integer; y: Integer): Integer; safecall;
    property Application: IDispatch read Get_Application;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  ITableCellsDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801024-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  ITableCellsDisp = dispinterface
    ['{39801024-E1EF-11D5-824C-008048AE8B26}']
    property Application: IDispatch readonly dispid 1;
    property _NewEnum: IUnknown readonly dispid -4;
    property Count: Integer readonly dispid 2;
    function Item(index: Integer): ITableCell; dispid 0;
    procedure Merge(Left: Integer; Top: Integer; Right: Integer; Bottom: Integer); dispid 3;
    procedure Split(Left: Integer; Top: Integer; Right: Integer; Bottom: Integer); dispid 4;
    function FindCellIndex(x: Integer; y: Integer): Integer; dispid 5;
  end;

// *********************************************************************//
// Interface: ITableCell
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801025-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  ITableCell = interface(IDispatch)
    ['{39801025-E1EF-11D5-824C-008048AE8B26}']
    function Get_Application: IDispatch; safecall;
    function Get_ContainsPicture: WordBool; safecall;
    procedure Set_ContainsPicture(pVal: WordBool); safecall;
    function Get_IsInverted: WordBool; safecall;
    procedure Set_IsInverted(pVal: WordBool); safecall;
    function Get_IsMirrored: WordBool; safecall;
    procedure Set_IsMirrored(pVal: WordBool); safecall;
    function Get_Language: WideString; safecall;
    procedure Set_Language(const pVal: WideString); safecall;
    function Get_TextType: TextTypeEnum; safecall;
    procedure Set_TextType(pVal: TextTypeEnum); safecall;
    function Get_TextOrientation: TextOrientationEnum; safecall;
    procedure Set_TextOrientation(pVal: TextOrientationEnum); safecall;
    function Get_Text: IText; safecall;
    function Get_Left: Integer; safecall;
    function Get_Top: Integer; safecall;
    function Get_Right: Integer; safecall;
    function Get_Bottom: Integer; safecall;
    property Application: IDispatch read Get_Application;
    property ContainsPicture: WordBool read Get_ContainsPicture write Set_ContainsPicture;
    property IsInverted: WordBool read Get_IsInverted write Set_IsInverted;
    property IsMirrored: WordBool read Get_IsMirrored write Set_IsMirrored;
    property Language: WideString read Get_Language write Set_Language;
    property TextType: TextTypeEnum read Get_TextType write Set_TextType;
    property TextOrientation: TextOrientationEnum read Get_TextOrientation write Set_TextOrientation;
    property Text: IText read Get_Text;
    property Left: Integer read Get_Left;
    property Top: Integer read Get_Top;
    property Right: Integer read Get_Right;
    property Bottom: Integer read Get_Bottom;
  end;

// *********************************************************************//
// DispIntf:  ITableCellDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801025-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  ITableCellDisp = dispinterface
    ['{39801025-E1EF-11D5-824C-008048AE8B26}']
    property Application: IDispatch readonly dispid 1;
    property ContainsPicture: WordBool dispid 2;
    property IsInverted: WordBool dispid 3;
    property IsMirrored: WordBool dispid 4;
    property Language: WideString dispid 5;
    property TextType: TextTypeEnum dispid 6;
    property TextOrientation: TextOrientationEnum dispid 7;
    property Text: IText readonly dispid 8;
    property Left: Integer readonly dispid 9;
    property Top: Integer readonly dispid 10;
    property Right: Integer readonly dispid 11;
    property Bottom: Integer readonly dispid 12;
  end;

// *********************************************************************//
// Interface: IBlackSeparator
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801018-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IBlackSeparator = interface(IDispatch)
    ['{39801018-E1EF-11D5-824C-008048AE8B26}']
    function Get_Application: IDispatch; safecall;
    function Get_Direction: BlackSeparatorDirectionEnum; safecall;
    function Get_type_: BlackSeparatorTypeEnum; safecall;
    function Get_Left: Integer; safecall;
    function Get_Top: Integer; safecall;
    function Get_Right: Integer; safecall;
    function Get_Bottom: Integer; safecall;
    function Get_PreciseWidth: Integer; safecall;
    property Application: IDispatch read Get_Application;
    property Direction: BlackSeparatorDirectionEnum read Get_Direction;
    property type_: BlackSeparatorTypeEnum read Get_type_;
    property Left: Integer read Get_Left;
    property Top: Integer read Get_Top;
    property Right: Integer read Get_Right;
    property Bottom: Integer read Get_Bottom;
    property PreciseWidth: Integer read Get_PreciseWidth;
  end;

// *********************************************************************//
// DispIntf:  IBlackSeparatorDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801018-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IBlackSeparatorDisp = dispinterface
    ['{39801018-E1EF-11D5-824C-008048AE8B26}']
    property Application: IDispatch readonly dispid 1;
    property Direction: BlackSeparatorDirectionEnum readonly dispid 2;
    property type_: BlackSeparatorTypeEnum readonly dispid 3;
    property Left: Integer readonly dispid 4;
    property Top: Integer readonly dispid 5;
    property Right: Integer readonly dispid 6;
    property Bottom: Integer readonly dispid 7;
    property PreciseWidth: Integer readonly dispid 9;
  end;

// *********************************************************************//
// Interface: ITextSelection
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {3980101B-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  ITextSelection = interface(IDispatch)
    ['{3980101B-E1EF-11D5-824C-008048AE8B26}']
    function Get_Application: IDispatch; safecall;
    function Get_AnchorBlock: Integer; safecall;
    procedure Set_AnchorBlock(block: Integer); safecall;
    function Get_CursorBlock: Integer; safecall;
    procedure Set_CursorBlock(block: Integer); safecall;
    function Get_AnchorCell: Integer; safecall;
    procedure Set_AnchorCell(cell: Integer); safecall;
    function Get_CursorCell: Integer; safecall;
    procedure Set_CursorCell(cell: Integer); safecall;
    function Get_AnchorParagraph: Integer; safecall;
    procedure Set_AnchorParagraph(Paragraph: Integer); safecall;
    function Get_CursorParagraph: Integer; safecall;
    procedure Set_CursorParagraph(Paragraph: Integer); safecall;
    function Get_AnchorSymbol: Integer; safecall;
    procedure Set_AnchorSymbol(symbol: Integer); safecall;
    function Get_CursorSymbol: Integer; safecall;
    procedure Set_CursorSymbol(symbol: Integer); safecall;
    property Application: IDispatch read Get_Application;
    property AnchorBlock: Integer read Get_AnchorBlock write Set_AnchorBlock;
    property CursorBlock: Integer read Get_CursorBlock write Set_CursorBlock;
    property AnchorCell: Integer read Get_AnchorCell write Set_AnchorCell;
    property CursorCell: Integer read Get_CursorCell write Set_CursorCell;
    property AnchorParagraph: Integer read Get_AnchorParagraph write Set_AnchorParagraph;
    property CursorParagraph: Integer read Get_CursorParagraph write Set_CursorParagraph;
    property AnchorSymbol: Integer read Get_AnchorSymbol write Set_AnchorSymbol;
    property CursorSymbol: Integer read Get_CursorSymbol write Set_CursorSymbol;
  end;

// *********************************************************************//
// DispIntf:  ITextSelectionDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {3980101B-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  ITextSelectionDisp = dispinterface
    ['{3980101B-E1EF-11D5-824C-008048AE8B26}']
    property Application: IDispatch readonly dispid 1;
    property AnchorBlock: Integer dispid 3;
    property CursorBlock: Integer dispid 4;
    property AnchorCell: Integer dispid 5;
    property CursorCell: Integer dispid 6;
    property AnchorParagraph: Integer dispid 7;
    property CursorParagraph: Integer dispid 8;
    property AnchorSymbol: Integer dispid 9;
    property CursorSymbol: Integer dispid 10;
  end;

// *********************************************************************//
// Interface: IImageDocument
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {3980101A-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IImageDocument = interface(IDispatch)
    ['{3980101A-E1EF-11D5-824C-008048AE8B26}']
    function Get_Application: IDispatch; safecall;
    function Get_IsReadOnly: WordBool; safecall;
    function Get_ImageColorType: ImageColorTypeEnum; safecall;
    function Get_SkewAngle: Double; safecall;
    procedure ChangeResolution(newResolution: Integer); safecall;
    function Get_SourceImageFileFormat: ImageFileFormatEnum; safecall;
    function Get_SourceImageScannerInfo: WideString; safecall;
    function Get_SourceImageScanThreshold: Integer; safecall;
    procedure WriteRectImage(const fileName: WideString; const Region: IRegion); safecall;
    function Get_BlackWhiteImage: IImage; safecall;
    function Get_ColorImage: IImage; safecall;
    function Get_PreviewImage: IImage; safecall;
    procedure Modify(const Modification: IImageModification); safecall;
    property Application: IDispatch read Get_Application;
    property IsReadOnly: WordBool read Get_IsReadOnly;
    property ImageColorType: ImageColorTypeEnum read Get_ImageColorType;
    property SkewAngle: Double read Get_SkewAngle;
    property SourceImageFileFormat: ImageFileFormatEnum read Get_SourceImageFileFormat;
    property SourceImageScannerInfo: WideString read Get_SourceImageScannerInfo;
    property SourceImageScanThreshold: Integer read Get_SourceImageScanThreshold;
    property BlackWhiteImage: IImage read Get_BlackWhiteImage;
    property ColorImage: IImage read Get_ColorImage;
    property PreviewImage: IImage read Get_PreviewImage;
  end;

// *********************************************************************//
// DispIntf:  IImageDocumentDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {3980101A-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IImageDocumentDisp = dispinterface
    ['{3980101A-E1EF-11D5-824C-008048AE8B26}']
    property Application: IDispatch readonly dispid 1;
    property IsReadOnly: WordBool readonly dispid 3;
    property ImageColorType: ImageColorTypeEnum readonly dispid 5;
    property SkewAngle: Double readonly dispid 9;
    procedure ChangeResolution(newResolution: Integer); dispid 17;
    property SourceImageFileFormat: ImageFileFormatEnum readonly dispid 30;
    property SourceImageScannerInfo: WideString readonly dispid 31;
    property SourceImageScanThreshold: Integer readonly dispid 32;
    procedure WriteRectImage(const fileName: WideString; const Region: IRegion); dispid 34;
    property BlackWhiteImage: IImage readonly dispid 35;
    property ColorImage: IImage readonly dispid 36;
    property PreviewImage: IImage readonly dispid 37;
    procedure Modify(const Modification: IImageModification); dispid 38;
  end;

// *********************************************************************//
// Interface: IImage
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801026-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IImage = interface(IDispatch)
    ['{39801026-E1EF-11D5-824C-008048AE8B26}']
    function Get_Application: IDispatch; safecall;
    function Get_Width: Integer; safecall;
    function Get_Height: Integer; safecall;
    function Get_Resolution: Integer; safecall;
    function Get_ImageColorType: ImageColorTypeEnum; safecall;
    procedure WriteToFile(const fileName: WideString; Format: ImageFileFormatEnum; 
                          const Modification: IImageModification); safecall;
    function GetPicture(const Modification: IImageModification; mode: Integer): Integer; safecall;
    function EstimateBitmapSize(const Modification: IImageModification; mode: Integer): Integer; safecall;
    property Application: IDispatch read Get_Application;
    property Width: Integer read Get_Width;
    property Height: Integer read Get_Height;
    property Resolution: Integer read Get_Resolution;
    property ImageColorType: ImageColorTypeEnum read Get_ImageColorType;
  end;

// *********************************************************************//
// DispIntf:  IImageDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801026-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IImageDisp = dispinterface
    ['{39801026-E1EF-11D5-824C-008048AE8B26}']
    property Application: IDispatch readonly dispid 1;
    property Width: Integer readonly dispid 2;
    property Height: Integer readonly dispid 3;
    property Resolution: Integer readonly dispid 4;
    property ImageColorType: ImageColorTypeEnum readonly dispid 5;
    procedure WriteToFile(const fileName: WideString; Format: ImageFileFormatEnum; 
                          const Modification: IImageModification); dispid 6;
    function GetPicture(const Modification: IImageModification; mode: Integer): Integer; dispid 7;
    function EstimateBitmapSize(const Modification: IImageModification; mode: Integer): Integer; dispid 8;
  end;

// *********************************************************************//
// Interface: IImageModification
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801027-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IImageModification = interface(IDispatch)
    ['{39801027-E1EF-11D5-824C-008048AE8B26}']
    function Get_Application: IDispatch; safecall;
    function Get_StretchRatio: Double; safecall;
    procedure Set_StretchRatio(Result: Double); safecall;
    procedure ClearClipRects; safecall;
    procedure AddClipRect(Left: Integer; Top: Integer; Right: Integer; Bottom: Integer); safecall;
    procedure ClearInvertRects; safecall;
    procedure AddInvertRect(Left: Integer; Top: Integer; Right: Integer; Bottom: Integer); safecall;
    procedure ClearPaintRects; safecall;
    procedure AddPaintRect(Left: Integer; Top: Integer; Right: Integer; Bottom: Integer; 
                           Color: Integer); safecall;
    procedure ClearReplaceBlackPixelsRects; safecall;
    procedure AddReplaceBlackPixelsRect(Left: Integer; Top: Integer; Right: Integer; 
                                        Bottom: Integer; Color: Integer; StrokesExpansion: Integer); safecall;
    procedure ClearReplaceWhitePixelsRects; safecall;
    procedure AddReplaceWhitePixelsRect(Left: Integer; Top: Integer; Right: Integer; 
                                        Bottom: Integer; Color: Integer; StrokesExpansion: Integer); safecall;
    procedure ClearRemoveGarbageRects; safecall;
    procedure AddRemoveGarbageRect(Left: Integer; Top: Integer; Right: Integer; Bottom: Integer; 
                                   attributes: Integer; GarbageSize: Integer); safecall;
    procedure CopyFrom(const From: IImageModification); safecall;
    procedure SaveToFile(const path: WideString); safecall;
    procedure LoadFromFile(const path: WideString); safecall;
    function SaveToMemory: Integer; safecall;
    procedure LoadFromMemory(hGlobal: Integer); safecall;
    property Application: IDispatch read Get_Application;
    property StretchRatio: Double read Get_StretchRatio write Set_StretchRatio;
  end;

// *********************************************************************//
// DispIntf:  IImageModificationDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801027-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IImageModificationDisp = dispinterface
    ['{39801027-E1EF-11D5-824C-008048AE8B26}']
    property Application: IDispatch readonly dispid 1;
    property StretchRatio: Double dispid 2;
    procedure ClearClipRects; dispid 3;
    procedure AddClipRect(Left: Integer; Top: Integer; Right: Integer; Bottom: Integer); dispid 4;
    procedure ClearInvertRects; dispid 5;
    procedure AddInvertRect(Left: Integer; Top: Integer; Right: Integer; Bottom: Integer); dispid 6;
    procedure ClearPaintRects; dispid 7;
    procedure AddPaintRect(Left: Integer; Top: Integer; Right: Integer; Bottom: Integer; 
                           Color: Integer); dispid 8;
    procedure ClearReplaceBlackPixelsRects; dispid 14;
    procedure AddReplaceBlackPixelsRect(Left: Integer; Top: Integer; Right: Integer; 
                                        Bottom: Integer; Color: Integer; StrokesExpansion: Integer); dispid 15;
    procedure ClearReplaceWhitePixelsRects; dispid 16;
    procedure AddReplaceWhitePixelsRect(Left: Integer; Top: Integer; Right: Integer; 
                                        Bottom: Integer; Color: Integer; StrokesExpansion: Integer); dispid 17;
    procedure ClearRemoveGarbageRects; dispid 18;
    procedure AddRemoveGarbageRect(Left: Integer; Top: Integer; Right: Integer; Bottom: Integer; 
                                   attributes: Integer; GarbageSize: Integer); dispid 19;
    procedure CopyFrom(const From: IImageModification); dispid 9;
    procedure SaveToFile(const path: WideString); dispid 10;
    procedure LoadFromFile(const path: WideString); dispid 11;
    function SaveToMemory: Integer; dispid 12;
    procedure LoadFromMemory(hGlobal: Integer); dispid 13;
  end;

// *********************************************************************//
// Interface: IBlocks
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801017-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IBlocks = interface(IDispatch)
    ['{39801017-E1EF-11D5-824C-008048AE8B26}']
    function Get_Application: IDispatch; safecall;
    function Get__NewEnum: IUnknown; safecall;
    function Get_Count: Integer; safecall;
    function Item(index: Integer): IBlock; safecall;
    function AddNew(Type_: BlockTypeEnum; Left: Integer; Top: Integer; Right: Integer; 
                    Bottom: Integer): IBlock; safecall;
    procedure Remove(index: Integer); safecall;
    procedure RemoveAll; safecall;
    procedure Renumber(From: Integer; to_: Integer); safecall;
    property Application: IDispatch read Get_Application;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  IBlocksDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801017-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IBlocksDisp = dispinterface
    ['{39801017-E1EF-11D5-824C-008048AE8B26}']
    property Application: IDispatch readonly dispid 1;
    property _NewEnum: IUnknown readonly dispid -4;
    property Count: Integer readonly dispid 2;
    function Item(index: Integer): IBlock; dispid 0;
    function AddNew(Type_: BlockTypeEnum; Left: Integer; Top: Integer; Right: Integer; 
                    Bottom: Integer): IBlock; dispid 3;
    procedure Remove(index: Integer); dispid 5;
    procedure RemoveAll; dispid 6;
    procedure Renumber(From: Integer; to_: Integer); dispid 7;
  end;

// *********************************************************************//
// Interface: IBlackSeparators
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801019-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IBlackSeparators = interface(IDispatch)
    ['{39801019-E1EF-11D5-824C-008048AE8B26}']
    function Get_Application: IDispatch; safecall;
    function Get__NewEnum: IUnknown; safecall;
    function Get_Count: Integer; safecall;
    function Item(index: Integer): IBlackSeparator; safecall;
    property Application: IDispatch read Get_Application;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  IBlackSeparatorsDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801019-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IBlackSeparatorsDisp = dispinterface
    ['{39801019-E1EF-11D5-824C-008048AE8B26}']
    property Application: IDispatch readonly dispid 1;
    property _NewEnum: IUnknown readonly dispid -4;
    property Count: Integer readonly dispid 2;
    function Item(index: Integer): IBlackSeparator; dispid 0;
  end;

// *********************************************************************//
// Interface: IApplication
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801001-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IApplication = interface(IDispatch)
    ['{39801001-E1EF-11D5-824C-008048AE8B26}']
    function Get_path: WideString; safecall;
    function Get_FullName: WideString; safecall;
    function Get_ToolkitVersion: Integer; safecall;
    function Get_Settings: ISettings; safecall;
    function Get_ShowMessages: WordBool; safecall;
    procedure Set_ShowMessages(pVal: WordBool); safecall;
    function Get_ShowErrors: WordBool; safecall;
    procedure Set_ShowErrors(pVal: WordBool); safecall;
    function Get_LastMessages: IStringsCollection; safecall;
    function Get_LastErrors: IStringsCollection; safecall;
    function Get_Visible: WordBool; safecall;
    procedure Set_Visible(pVal: WordBool); safecall;
    function Get_Interactive: WordBool; safecall;
    procedure Set_Interactive(pVal: WordBool); safecall;
    function Get_CanClose: WordBool; safecall;
    procedure Set_CanClose(pVal: WordBool); safecall;
    function Get_Caption: WideString; safecall;
    procedure Set_Caption(const pVal: WideString); safecall;
    function Get_Top: Integer; safecall;
    procedure Set_Top(pVal: Integer); safecall;
    function Get_Left: Integer; safecall;
    procedure Set_Left(pVal: Integer); safecall;
    function Get_Width: Integer; safecall;
    procedure Set_Width(pVal: Integer); safecall;
    function Get_Height: Integer; safecall;
    procedure Set_Height(pVal: Integer); safecall;
    function Get_ShowMenuBar: WordBool; safecall;
    procedure Set_ShowMenuBar(pVal: WordBool); safecall;
    function Get_ShowStatusBar: WordBool; safecall;
    procedure Set_ShowStatusBar(pVal: WordBool); safecall;
    function Get_StatusText: WideString; safecall;
    procedure Set_StatusText(const pVal: WideString); safecall;
    function Get_TranslateAccelerators: WordBool; safecall;
    procedure Set_TranslateAccelerators(pVal: WordBool); safecall;
    function Get_BatchWindowPosition: WindowPositionEnum; safecall;
    procedure Set_BatchWindowPosition(pVal: WindowPositionEnum); safecall;
    function Get_ZoomWindowPosition: WindowPositionEnum; safecall;
    procedure Set_ZoomWindowPosition(pVal: WindowPositionEnum); safecall;
    function Get_BatchSplitterPosition: Integer; safecall;
    procedure Set_BatchSplitterPosition(pVal: Integer); safecall;
    function Get_ZoomSplitterPosition: Integer; safecall;
    procedure Set_ZoomSplitterPosition(pVal: Integer); safecall;
    function Get_ImageTextSplittingRatio: Integer; safecall;
    procedure Set_ImageTextSplittingRatio(pVal: Integer); safecall;
    function Get_State: WindowStateEnum; safecall;
    procedure Set_State(pVal: WindowStateEnum); safecall;
    function Get_HWND: Integer; safecall;
    function Get_ShowToolbar(toolbar: ToolbarNameEnum): WordBool; safecall;
    procedure Set_ShowToolbar(toolbar: ToolbarNameEnum; pVal: WordBool); safecall;
    function Get_ActiveChildWindow: WindowNameEnum; safecall;
    procedure Set_ActiveChildWindow(pVal: WindowNameEnum); safecall;
    function CreateBatchPagesCollection: IBatchPagesCollection; safecall;
    function CreateStringsCollection: IStringsCollection; safecall;
    function Get_BatchWindow: IBatchWindow; safecall;
    function Get_OverviewWindow: IImageWindow; safecall;
    function Get_ZoomWindow: IImageWindow; safecall;
    function Get_TextWindow: ITextWindow; safecall;
    function Get_Batch: IBatch; safecall;
    procedure Activate; safecall;
    function DoCommand(menuItem: MenuItemEnum): Integer; safecall;
    procedure DoCommandAsync(menuItem: MenuItemEnum); safecall;
    procedure EnableMenuItem(menuItem: MenuItemEnum; fEnable: WordBool); safecall;
    function IsBatchFolder(const folderPath: WideString): WordBool; safecall;
    procedure Quit; safecall;
    procedure AddSendToDestination(customSendToDestId: Integer; const moduleName: WideString; 
                                   bmStandardResourceId: Integer; bmLargeResourceId: Integer; 
                                   bmWizardResourceId: Integer; const buttonText: WideString; 
                                   const tooltipText: WideString; const wizardText: WideString; 
                                   const descriptionText: WideString); safecall;
    procedure AddToolbarButton(actionId: Integer; const moduleName: WideString; 
                               resourceId: Integer; const tooltip: WideString; fEnabled: WordBool; 
                               virtKey: Integer; fShift: WordBool; fCtrl: WordBool; fAlt: WordBool); safecall;
    procedure DeleteToolbarButton(actionId: Integer); safecall;
    procedure EnableToolbarButton(actionId: Integer; fEnable: WordBool); safecall;
    function Get_UserProperty(const name: WideString): OleVariant; safecall;
    procedure Set_UserProperty(const name: WideString; pVal: OleVariant); safecall;
    function Get_RecognitionsLimit: Integer; safecall;
    function Get_toolbar(toolbarName: ToolbarNameEnum): IToolbar; safecall;
    procedure AddCustomCommand(Item: MenuItemEnum; const tooltip: WideString; 
                               const description: WideString; const moduleName: WideString; 
                               smallBitmapId: Integer; largeBitmapId: Integer; virtKey: Integer; 
                               fShift: WordBool; fCtrl: WordBool; fAlt: WordBool); safecall;
    procedure DeleteCustomCommand(menuItem: MenuItemEnum); safecall;
    function Get_IsScanning: WordBool; safecall;
    function Get_LargeToolbarButtons: WordBool; safecall;
    procedure Set_LargeToolbarButtons(pVal: WordBool); safecall;
    function Get_ShowProgressBars: WordBool; safecall;
    procedure Set_ShowProgressBars(pVal: WordBool); safecall;
    function CreateCharParams: ICharParams; safecall;
    property path: WideString read Get_path;
    property FullName: WideString read Get_FullName;
    property ToolkitVersion: Integer read Get_ToolkitVersion;
    property Settings: ISettings read Get_Settings;
    property ShowMessages: WordBool read Get_ShowMessages write Set_ShowMessages;
    property ShowErrors: WordBool read Get_ShowErrors write Set_ShowErrors;
    property LastMessages: IStringsCollection read Get_LastMessages;
    property LastErrors: IStringsCollection read Get_LastErrors;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property Interactive: WordBool read Get_Interactive write Set_Interactive;
    property CanClose: WordBool read Get_CanClose write Set_CanClose;
    property Caption: WideString read Get_Caption write Set_Caption;
    property Top: Integer read Get_Top write Set_Top;
    property Left: Integer read Get_Left write Set_Left;
    property Width: Integer read Get_Width write Set_Width;
    property Height: Integer read Get_Height write Set_Height;
    property ShowMenuBar: WordBool read Get_ShowMenuBar write Set_ShowMenuBar;
    property ShowStatusBar: WordBool read Get_ShowStatusBar write Set_ShowStatusBar;
    property StatusText: WideString read Get_StatusText write Set_StatusText;
    property TranslateAccelerators: WordBool read Get_TranslateAccelerators write Set_TranslateAccelerators;
    property BatchWindowPosition: WindowPositionEnum read Get_BatchWindowPosition write Set_BatchWindowPosition;
    property ZoomWindowPosition: WindowPositionEnum read Get_ZoomWindowPosition write Set_ZoomWindowPosition;
    property BatchSplitterPosition: Integer read Get_BatchSplitterPosition write Set_BatchSplitterPosition;
    property ZoomSplitterPosition: Integer read Get_ZoomSplitterPosition write Set_ZoomSplitterPosition;
    property ImageTextSplittingRatio: Integer read Get_ImageTextSplittingRatio write Set_ImageTextSplittingRatio;
    property State: WindowStateEnum read Get_State write Set_State;
    property HWND: Integer read Get_HWND;
    property ShowToolbar[toolbar: ToolbarNameEnum]: WordBool read Get_ShowToolbar write Set_ShowToolbar;
    property ActiveChildWindow: WindowNameEnum read Get_ActiveChildWindow write Set_ActiveChildWindow;
    property BatchWindow: IBatchWindow read Get_BatchWindow;
    property OverviewWindow: IImageWindow read Get_OverviewWindow;
    property ZoomWindow: IImageWindow read Get_ZoomWindow;
    property TextWindow: ITextWindow read Get_TextWindow;
    property Batch: IBatch read Get_Batch;
    property UserProperty[const name: WideString]: OleVariant read Get_UserProperty write Set_UserProperty;
    property RecognitionsLimit: Integer read Get_RecognitionsLimit;
    property toolbar[toolbarName: ToolbarNameEnum]: IToolbar read Get_toolbar;
    property IsScanning: WordBool read Get_IsScanning;
    property LargeToolbarButtons: WordBool read Get_LargeToolbarButtons write Set_LargeToolbarButtons;
    property ShowProgressBars: WordBool read Get_ShowProgressBars write Set_ShowProgressBars;
  end;

// *********************************************************************//
// DispIntf:  IApplicationDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801001-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IApplicationDisp = dispinterface
    ['{39801001-E1EF-11D5-824C-008048AE8B26}']
    property path: WideString readonly dispid 1;
    property FullName: WideString readonly dispid 2;
    property ToolkitVersion: Integer readonly dispid 3;
    property Settings: ISettings readonly dispid 36;
    property ShowMessages: WordBool dispid 4;
    property ShowErrors: WordBool dispid 5;
    property LastMessages: IStringsCollection readonly dispid 6;
    property LastErrors: IStringsCollection readonly dispid 7;
    property Visible: WordBool dispid 8;
    property Interactive: WordBool dispid 9;
    property CanClose: WordBool dispid 10;
    property Caption: WideString dispid 11;
    property Top: Integer dispid 13;
    property Left: Integer dispid 14;
    property Width: Integer dispid 15;
    property Height: Integer dispid 16;
    property ShowMenuBar: WordBool dispid 19;
    property ShowStatusBar: WordBool dispid 20;
    property StatusText: WideString dispid 21;
    property TranslateAccelerators: WordBool dispid 22;
    property BatchWindowPosition: WindowPositionEnum dispid 27;
    property ZoomWindowPosition: WindowPositionEnum dispid 28;
    property BatchSplitterPosition: Integer dispid 24;
    property ZoomSplitterPosition: Integer dispid 25;
    property ImageTextSplittingRatio: Integer dispid 26;
    property State: WindowStateEnum dispid 17;
    property HWND: Integer readonly dispid 18;
    property ShowToolbar[toolbar: ToolbarNameEnum]: WordBool dispid 37;
    property ActiveChildWindow: WindowNameEnum dispid 40;
    function CreateBatchPagesCollection: IBatchPagesCollection; dispid 41;
    function CreateStringsCollection: IStringsCollection; dispid 42;
    property BatchWindow: IBatchWindow readonly dispid 43;
    property OverviewWindow: IImageWindow readonly dispid 44;
    property ZoomWindow: IImageWindow readonly dispid 45;
    property TextWindow: ITextWindow readonly dispid 46;
    property Batch: IBatch readonly dispid 47;
    procedure Activate; dispid 30;
    function DoCommand(menuItem: MenuItemEnum): Integer; dispid 31;
    procedure DoCommandAsync(menuItem: MenuItemEnum); dispid 32;
    procedure EnableMenuItem(menuItem: MenuItemEnum; fEnable: WordBool); dispid 33;
    function IsBatchFolder(const folderPath: WideString): WordBool; dispid 34;
    procedure Quit; dispid 35;
    procedure AddSendToDestination(customSendToDestId: Integer; const moduleName: WideString; 
                                   bmStandardResourceId: Integer; bmLargeResourceId: Integer; 
                                   bmWizardResourceId: Integer; const buttonText: WideString; 
                                   const tooltipText: WideString; const wizardText: WideString; 
                                   const descriptionText: WideString); dispid 38;
    procedure AddToolbarButton(actionId: Integer; const moduleName: WideString; 
                               resourceId: Integer; const tooltip: WideString; fEnabled: WordBool; 
                               virtKey: Integer; fShift: WordBool; fCtrl: WordBool; fAlt: WordBool); dispid 39;
    procedure DeleteToolbarButton(actionId: Integer); dispid 48;
    procedure EnableToolbarButton(actionId: Integer; fEnable: WordBool); dispid 49;
    property UserProperty[const name: WideString]: OleVariant dispid 50;
    property RecognitionsLimit: Integer readonly dispid 51;
    property toolbar[toolbarName: ToolbarNameEnum]: IToolbar readonly dispid 52;
    procedure AddCustomCommand(Item: MenuItemEnum; const tooltip: WideString; 
                               const description: WideString; const moduleName: WideString; 
                               smallBitmapId: Integer; largeBitmapId: Integer; virtKey: Integer; 
                               fShift: WordBool; fCtrl: WordBool; fAlt: WordBool); dispid 53;
    procedure DeleteCustomCommand(menuItem: MenuItemEnum); dispid 54;
    property IsScanning: WordBool readonly dispid 55;
    property LargeToolbarButtons: WordBool dispid 56;
    property ShowProgressBars: WordBool dispid 57;
    function CreateCharParams: ICharParams; dispid 58;
  end;

// *********************************************************************//
// Interface: ISettings
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801002-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  ISettings = interface(IDispatch)
    ['{39801002-E1EF-11D5-824C-008048AE8B26}']
    function Get_Application: IDispatch; safecall;
    function Get_ShowImageDuringRecognition: WordBool; safecall;
    procedure Set_ShowImageDuringRecognition(pVal: WordBool); safecall;
    function Get_ShowTipsDuringRecognition: WordBool; safecall;
    procedure Set_ShowTipsDuringRecognition(pVal: WordBool); safecall;
    function Get_OpenLastBatchAtStartup: WordBool; safecall;
    procedure Set_OpenLastBatchAtStartup(pVal: WordBool); safecall;
    function Get_ShowWelcomeDlgAtStartup: WordBool; safecall;
    procedure Set_ShowWelcomeDlgAtStartup(pVal: WordBool); safecall;
    function Get_EnableCommunityNewsChannel: WordBool; safecall;
    procedure Set_EnableCommunityNewsChannel(pVal: WordBool); safecall;
    function Get_ShowBWImageInImageWnd: WordBool; safecall;
    procedure Set_ShowBWImageInImageWnd(pVal: WordBool); safecall;
    function Get_ShowBWImageInZoomWnd: WordBool; safecall;
    procedure Set_ShowBWImageInZoomWnd(pVal: WordBool); safecall;
    function Get_ShowZoomWndScrollbars: WordBool; safecall;
    procedure Set_ShowZoomWndScrollbars(pVal: WordBool); safecall;
    function Get_ShowScaledBWAsGray: WordBool; safecall;
    procedure Set_ShowScaledBWAsGray(pVal: WordBool); safecall;
    function Get_OverviewWindowScale: Integer; safecall;
    procedure Set_OverviewWindowScale(pVal: Integer); safecall;
    function Get_ZoomWindowScale: Integer; safecall;
    procedure Set_ZoomWindowScale(pVal: Integer); safecall;
    function Get_HighlightUncertainCharacters: WordBool; safecall;
    procedure Set_HighlightUncertainCharacters(pVal: WordBool); safecall;
    function Get_ShowNonprintingCharacters: WordBool; safecall;
    procedure Set_ShowNonprintingCharacters(pVal: WordBool); safecall;
    function Get_ShowParagraphFormatting: WordBool; safecall;
    procedure Set_ShowParagraphFormatting(pVal: WordBool); safecall;
    function Get_TextWindowScale: Integer; safecall;
    procedure Set_TextWindowScale(pVal: Integer); safecall;
    function Get_BatchViewMode: BatchViewModeEnum; safecall;
    procedure Set_BatchViewMode(pVal: BatchViewModeEnum); safecall;
    function Get_ShowFineUIBeforeScan: WordBool; safecall;
    procedure Set_ShowFineUIBeforeScan(pVal: WordBool); safecall;
    function Get_AskForPageNumber: WordBool; safecall;
    procedure Set_AskForPageNumber(pVal: WordBool); safecall;
    function Get_ShowImageDuringScanning: WordBool; safecall;
    procedure Set_ShowImageDuringScanning(pVal: WordBool); safecall;
    function Get_OpenDocumentAfterExport: WordBool; safecall;
    procedure Set_OpenDocumentAfterExport(pVal: WordBool); safecall;
    property Application: IDispatch read Get_Application;
    property ShowImageDuringRecognition: WordBool read Get_ShowImageDuringRecognition write Set_ShowImageDuringRecognition;
    property ShowTipsDuringRecognition: WordBool read Get_ShowTipsDuringRecognition write Set_ShowTipsDuringRecognition;
    property OpenLastBatchAtStartup: WordBool read Get_OpenLastBatchAtStartup write Set_OpenLastBatchAtStartup;
    property ShowWelcomeDlgAtStartup: WordBool read Get_ShowWelcomeDlgAtStartup write Set_ShowWelcomeDlgAtStartup;
    property EnableCommunityNewsChannel: WordBool read Get_EnableCommunityNewsChannel write Set_EnableCommunityNewsChannel;
    property ShowBWImageInImageWnd: WordBool read Get_ShowBWImageInImageWnd write Set_ShowBWImageInImageWnd;
    property ShowBWImageInZoomWnd: WordBool read Get_ShowBWImageInZoomWnd write Set_ShowBWImageInZoomWnd;
    property ShowZoomWndScrollbars: WordBool read Get_ShowZoomWndScrollbars write Set_ShowZoomWndScrollbars;
    property ShowScaledBWAsGray: WordBool read Get_ShowScaledBWAsGray write Set_ShowScaledBWAsGray;
    property OverviewWindowScale: Integer read Get_OverviewWindowScale write Set_OverviewWindowScale;
    property ZoomWindowScale: Integer read Get_ZoomWindowScale write Set_ZoomWindowScale;
    property HighlightUncertainCharacters: WordBool read Get_HighlightUncertainCharacters write Set_HighlightUncertainCharacters;
    property ShowNonprintingCharacters: WordBool read Get_ShowNonprintingCharacters write Set_ShowNonprintingCharacters;
    property ShowParagraphFormatting: WordBool read Get_ShowParagraphFormatting write Set_ShowParagraphFormatting;
    property TextWindowScale: Integer read Get_TextWindowScale write Set_TextWindowScale;
    property BatchViewMode: BatchViewModeEnum read Get_BatchViewMode write Set_BatchViewMode;
    property ShowFineUIBeforeScan: WordBool read Get_ShowFineUIBeforeScan write Set_ShowFineUIBeforeScan;
    property AskForPageNumber: WordBool read Get_AskForPageNumber write Set_AskForPageNumber;
    property ShowImageDuringScanning: WordBool read Get_ShowImageDuringScanning write Set_ShowImageDuringScanning;
    property OpenDocumentAfterExport: WordBool read Get_OpenDocumentAfterExport write Set_OpenDocumentAfterExport;
  end;

// *********************************************************************//
// DispIntf:  ISettingsDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801002-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  ISettingsDisp = dispinterface
    ['{39801002-E1EF-11D5-824C-008048AE8B26}']
    property Application: IDispatch readonly dispid 1;
    property ShowImageDuringRecognition: WordBool dispid 2;
    property ShowTipsDuringRecognition: WordBool dispid 3;
    property OpenLastBatchAtStartup: WordBool dispid 4;
    property ShowWelcomeDlgAtStartup: WordBool dispid 5;
    property EnableCommunityNewsChannel: WordBool dispid 6;
    property ShowBWImageInImageWnd: WordBool dispid 7;
    property ShowBWImageInZoomWnd: WordBool dispid 8;
    property ShowZoomWndScrollbars: WordBool dispid 9;
    property ShowScaledBWAsGray: WordBool dispid 10;
    property OverviewWindowScale: Integer dispid 17;
    property ZoomWindowScale: Integer dispid 18;
    property HighlightUncertainCharacters: WordBool dispid 11;
    property ShowNonprintingCharacters: WordBool dispid 12;
    property ShowParagraphFormatting: WordBool dispid 13;
    property TextWindowScale: Integer dispid 19;
    property BatchViewMode: BatchViewModeEnum dispid 20;
    property ShowFineUIBeforeScan: WordBool dispid 14;
    property AskForPageNumber: WordBool dispid 15;
    property ShowImageDuringScanning: WordBool dispid 16;
    property OpenDocumentAfterExport: WordBool dispid 21;
  end;

// *********************************************************************//
// Interface: IStringsCollection
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {3980100C-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IStringsCollection = interface(IDispatch)
    ['{3980100C-E1EF-11D5-824C-008048AE8B26}']
    function Get_Application: IDispatch; safecall;
    function Get__NewEnum: IUnknown; safecall;
    function Get_Count: Integer; safecall;
    function Item(index: Integer): WideString; safecall;
    procedure Insert(const str: WideString; index: Integer); safecall;
    procedure Add(const str: WideString); safecall;
    procedure Remove(index: Integer); safecall;
    procedure RemoveAll; safecall;
    procedure CopyFrom(const collection: IStringsCollection); safecall;
    property Application: IDispatch read Get_Application;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  IStringsCollectionDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {3980100C-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IStringsCollectionDisp = dispinterface
    ['{3980100C-E1EF-11D5-824C-008048AE8B26}']
    property Application: IDispatch readonly dispid 1;
    property _NewEnum: IUnknown readonly dispid -4;
    property Count: Integer readonly dispid 2;
    function Item(index: Integer): WideString; dispid 0;
    procedure Insert(const str: WideString; index: Integer); dispid 3;
    procedure Add(const str: WideString); dispid 4;
    procedure Remove(index: Integer); dispid 5;
    procedure RemoveAll; dispid 6;
    procedure CopyFrom(const collection: IStringsCollection); dispid 7;
  end;

// *********************************************************************//
// Interface: IBatchPagesCollection
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801006-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IBatchPagesCollection = interface(IDispatch)
    ['{39801006-E1EF-11D5-824C-008048AE8B26}']
    function Get_Application: IDispatch; safecall;
    function Get__NewEnum: IUnknown; safecall;
    function Get_Count: Integer; safecall;
    function Item(index: Integer): IBatchPage; safecall;
    procedure Add(const page: IBatchPage); safecall;
    procedure Remove(index: Integer); safecall;
    procedure RemoveAll; safecall;
    procedure CopyFrom(const collection: IBatchPagesCollection); safecall;
    function FindPageByNumber(Number: Integer): IBatchPage; safecall;
    property Application: IDispatch read Get_Application;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  IBatchPagesCollectionDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801006-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IBatchPagesCollectionDisp = dispinterface
    ['{39801006-E1EF-11D5-824C-008048AE8B26}']
    property Application: IDispatch readonly dispid 1;
    property _NewEnum: IUnknown readonly dispid -4;
    property Count: Integer readonly dispid 2;
    function Item(index: Integer): IBatchPage; dispid 0;
    procedure Add(const page: IBatchPage); dispid 4;
    procedure Remove(index: Integer); dispid 5;
    procedure RemoveAll; dispid 6;
    procedure CopyFrom(const collection: IBatchPagesCollection); dispid 7;
    function FindPageByNumber(Number: Integer): IBatchPage; dispid 8;
  end;

// *********************************************************************//
// Interface: IBatchPage
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801004-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IBatchPage = interface(IDispatch)
    ['{39801004-E1EF-11D5-824C-008048AE8B26}']
    function Get_Application: IDispatch; safecall;
    function Get_Number: Integer; safecall;
    function Get_IsOpened: WordBool; safecall;
    function Get_Comment: WideString; safecall;
    procedure Set_Comment(const pVal: WideString); safecall;
    function Get_HasBlocks: WordBool; safecall;
    function Get_HasError: WordBool; safecall;
    function Get_HasWarning: WordBool; safecall;
    function Get_IsRecognized: WordBool; safecall;
    function Get_IsVerified: WordBool; safecall;
    function Get_IsExported: WordBool; safecall;
    function Get_IsBlank: WordBool; safecall;
    function Get_OpenInfo: IBatchEvent; safecall;
    function Get_RecognizeInfo: IBatchEvent; safecall;
    function Get_EditInfo: IBatchEvent; safecall;
    function Get_VerifyInfo: IBatchEvent; safecall;
    function Get_ExportInfo: IBatchEvent; safecall;
    function Get_ErrorText: WideString; safecall;
    function Get_WarningText: WideString; safecall;
    function Get_SourceImageFileName: WideString; safecall;
    function Get_SymbolsCount: Integer; safecall;
    function Get_UncertainSymbolsCount: Integer; safecall;
    function Get_IsDeleted: WordBool; safecall;
    function Get_ChangeFlags: Integer; safecall;
    function Get_UserProperty(const name: WideString): OleVariant; safecall;
    procedure Set_UserProperty(const name: WideString; pVal: OleVariant); safecall;
    procedure SaveBlocks(const path: WideString); safecall;
    procedure LoadBlocks(const path: WideString); safecall;
    function Get_Blocks: IBlocks; safecall;
    function Get_ImageDocument: IImageDocument; safecall;
    function Get_BlackSeparators: IBlackSeparators; safecall;
    function CreateTextSelection: ITextSelection; safecall;
    function CreateImageModification: IImageModification; safecall;
    property Application: IDispatch read Get_Application;
    property Number: Integer read Get_Number;
    property IsOpened: WordBool read Get_IsOpened;
    property Comment: WideString read Get_Comment write Set_Comment;
    property HasBlocks: WordBool read Get_HasBlocks;
    property HasError: WordBool read Get_HasError;
    property HasWarning: WordBool read Get_HasWarning;
    property IsRecognized: WordBool read Get_IsRecognized;
    property IsVerified: WordBool read Get_IsVerified;
    property IsExported: WordBool read Get_IsExported;
    property IsBlank: WordBool read Get_IsBlank;
    property OpenInfo: IBatchEvent read Get_OpenInfo;
    property RecognizeInfo: IBatchEvent read Get_RecognizeInfo;
    property EditInfo: IBatchEvent read Get_EditInfo;
    property VerifyInfo: IBatchEvent read Get_VerifyInfo;
    property ExportInfo: IBatchEvent read Get_ExportInfo;
    property ErrorText: WideString read Get_ErrorText;
    property WarningText: WideString read Get_WarningText;
    property SourceImageFileName: WideString read Get_SourceImageFileName;
    property SymbolsCount: Integer read Get_SymbolsCount;
    property UncertainSymbolsCount: Integer read Get_UncertainSymbolsCount;
    property IsDeleted: WordBool read Get_IsDeleted;
    property ChangeFlags: Integer read Get_ChangeFlags;
    property UserProperty[const name: WideString]: OleVariant read Get_UserProperty write Set_UserProperty;
    property Blocks: IBlocks read Get_Blocks;
    property ImageDocument: IImageDocument read Get_ImageDocument;
    property BlackSeparators: IBlackSeparators read Get_BlackSeparators;
  end;

// *********************************************************************//
// DispIntf:  IBatchPageDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801004-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IBatchPageDisp = dispinterface
    ['{39801004-E1EF-11D5-824C-008048AE8B26}']
    property Application: IDispatch readonly dispid 1;
    property Number: Integer readonly dispid 3;
    property IsOpened: WordBool readonly dispid 4;
    property Comment: WideString dispid 5;
    property HasBlocks: WordBool readonly dispid 6;
    property HasError: WordBool readonly dispid 7;
    property HasWarning: WordBool readonly dispid 25;
    property IsRecognized: WordBool readonly dispid 8;
    property IsVerified: WordBool readonly dispid 9;
    property IsExported: WordBool readonly dispid 10;
    property IsBlank: WordBool readonly dispid 35;
    property OpenInfo: IBatchEvent readonly dispid 11;
    property RecognizeInfo: IBatchEvent readonly dispid 12;
    property EditInfo: IBatchEvent readonly dispid 13;
    property VerifyInfo: IBatchEvent readonly dispid 14;
    property ExportInfo: IBatchEvent readonly dispid 15;
    property ErrorText: WideString readonly dispid 16;
    property WarningText: WideString readonly dispid 17;
    property SourceImageFileName: WideString readonly dispid 18;
    property SymbolsCount: Integer readonly dispid 19;
    property UncertainSymbolsCount: Integer readonly dispid 20;
    property IsDeleted: WordBool readonly dispid 21;
    property ChangeFlags: Integer readonly dispid 24;
    property UserProperty[const name: WideString]: OleVariant dispid 33;
    procedure SaveBlocks(const path: WideString); dispid 22;
    procedure LoadBlocks(const path: WideString); dispid 23;
    property Blocks: IBlocks readonly dispid 29;
    property ImageDocument: IImageDocument readonly dispid 30;
    property BlackSeparators: IBlackSeparators readonly dispid 31;
    function CreateTextSelection: ITextSelection; dispid 34;
    function CreateImageModification: IImageModification; dispid 36;
  end;

// *********************************************************************//
// Interface: IBatchEvent
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801008-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IBatchEvent = interface(IDispatch)
    ['{39801008-E1EF-11D5-824C-008048AE8B26}']
    function Get_Application: IDispatch; safecall;
    function Get_UserName: WideString; safecall;
    function Get_ComputerName: WideString; safecall;
    function Get_Time: TDateTime; safecall;
    function Get_IsEmpty: WordBool; safecall;
    property Application: IDispatch read Get_Application;
    property UserName: WideString read Get_UserName;
    property ComputerName: WideString read Get_ComputerName;
    property Time: TDateTime read Get_Time;
    property IsEmpty: WordBool read Get_IsEmpty;
  end;

// *********************************************************************//
// DispIntf:  IBatchEventDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801008-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IBatchEventDisp = dispinterface
    ['{39801008-E1EF-11D5-824C-008048AE8B26}']
    property Application: IDispatch readonly dispid 1;
    property UserName: WideString readonly dispid 2;
    property ComputerName: WideString readonly dispid 3;
    property Time: TDateTime readonly dispid 4;
    property IsEmpty: WordBool readonly dispid 5;
  end;

// *********************************************************************//
// Interface: IBatchWindow
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801009-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IBatchWindow = interface(IDispatch)
    ['{39801009-E1EF-11D5-824C-008048AE8B26}']
    function Get_Application: IDispatch; safecall;
    function Get_HWND: Integer; safecall;
    function Get_IsActive: WordBool; safecall;
    function Get_Selection: IBatchPagesCollection; safecall;
    procedure Set_Selection(const pVal: IBatchPagesCollection); safecall;
    function Get_Top: Integer; safecall;
    function Get_Left: Integer; safecall;
    function Get_Width: Integer; safecall;
    function Get_Height: Integer; safecall;
    procedure BringIntoView(const page: IBatchPage); safecall;
    procedure Activate; safecall;
    function Get_WindowState: WindowStateEnum; safecall;
    procedure Set_WindowState(pVal: WindowStateEnum); safecall;
    property Application: IDispatch read Get_Application;
    property HWND: Integer read Get_HWND;
    property IsActive: WordBool read Get_IsActive;
    property Selection: IBatchPagesCollection read Get_Selection write Set_Selection;
    property Top: Integer read Get_Top;
    property Left: Integer read Get_Left;
    property Width: Integer read Get_Width;
    property Height: Integer read Get_Height;
    property WindowState: WindowStateEnum read Get_WindowState write Set_WindowState;
  end;

// *********************************************************************//
// DispIntf:  IBatchWindowDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801009-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IBatchWindowDisp = dispinterface
    ['{39801009-E1EF-11D5-824C-008048AE8B26}']
    property Application: IDispatch readonly dispid 1;
    property HWND: Integer readonly dispid 2;
    property IsActive: WordBool readonly dispid 3;
    property Selection: IBatchPagesCollection dispid 9;
    property Top: Integer readonly dispid 4;
    property Left: Integer readonly dispid 5;
    property Width: Integer readonly dispid 6;
    property Height: Integer readonly dispid 7;
    procedure BringIntoView(const page: IBatchPage); dispid 10;
    procedure Activate; dispid 11;
    property WindowState: WindowStateEnum dispid 12;
  end;

// *********************************************************************//
// Interface: IImageWindow
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {3980100A-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IImageWindow = interface(IDispatch)
    ['{3980100A-E1EF-11D5-824C-008048AE8B26}']
    function Get_Application: IDispatch; safecall;
    function Get_HWND: Integer; safecall;
    function Get_IsActive: WordBool; safecall;
    function Get_Top: Integer; safecall;
    function Get_Left: Integer; safecall;
    function Get_Width: Integer; safecall;
    function Get_Height: Integer; safecall;
    function Get_VisibleWidth: Integer; safecall;
    function Get_VisibleHeight: Integer; safecall;
    function Get_ViewOriginX: Integer; safecall;
    procedure Set_ViewOriginX(pVal: Integer); safecall;
    function Get_ViewOriginY: Integer; safecall;
    procedure Set_ViewOriginY(pVal: Integer); safecall;
    procedure Activate; safecall;
    procedure BringIntoView(Left: Integer; Top: Integer; Right: Integer; Bottom: Integer); safecall;
    function Get_WindowState: WindowStateEnum; safecall;
    procedure Set_WindowState(pVal: WindowStateEnum); safecall;
    property Application: IDispatch read Get_Application;
    property HWND: Integer read Get_HWND;
    property IsActive: WordBool read Get_IsActive;
    property Top: Integer read Get_Top;
    property Left: Integer read Get_Left;
    property Width: Integer read Get_Width;
    property Height: Integer read Get_Height;
    property VisibleWidth: Integer read Get_VisibleWidth;
    property VisibleHeight: Integer read Get_VisibleHeight;
    property ViewOriginX: Integer read Get_ViewOriginX write Set_ViewOriginX;
    property ViewOriginY: Integer read Get_ViewOriginY write Set_ViewOriginY;
    property WindowState: WindowStateEnum read Get_WindowState write Set_WindowState;
  end;

// *********************************************************************//
// DispIntf:  IImageWindowDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {3980100A-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IImageWindowDisp = dispinterface
    ['{3980100A-E1EF-11D5-824C-008048AE8B26}']
    property Application: IDispatch readonly dispid 1;
    property HWND: Integer readonly dispid 2;
    property IsActive: WordBool readonly dispid 3;
    property Top: Integer readonly dispid 5;
    property Left: Integer readonly dispid 6;
    property Width: Integer readonly dispid 7;
    property Height: Integer readonly dispid 8;
    property VisibleWidth: Integer readonly dispid 9;
    property VisibleHeight: Integer readonly dispid 10;
    property ViewOriginX: Integer dispid 11;
    property ViewOriginY: Integer dispid 12;
    procedure Activate; dispid 13;
    procedure BringIntoView(Left: Integer; Top: Integer; Right: Integer; Bottom: Integer); dispid 14;
    property WindowState: WindowStateEnum dispid 15;
  end;

// *********************************************************************//
// Interface: ITextWindow
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {3980100B-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  ITextWindow = interface(IDispatch)
    ['{3980100B-E1EF-11D5-824C-008048AE8B26}']
    function Get_Application: IDispatch; safecall;
    function Get_HWND: Integer; safecall;
    function Get_IsActive: WordBool; safecall;
    function Get_Top: Integer; safecall;
    function Get_Left: Integer; safecall;
    function Get_Width: Integer; safecall;
    function Get_Height: Integer; safecall;
    procedure Activate; safecall;
    function Get_Selection: ITextSelection; safecall;
    procedure Set_Selection(const pVal: ITextSelection); safecall;
    function Get_WindowState: WindowStateEnum; safecall;
    procedure Set_WindowState(pVal: WindowStateEnum); safecall;
    property Application: IDispatch read Get_Application;
    property HWND: Integer read Get_HWND;
    property IsActive: WordBool read Get_IsActive;
    property Top: Integer read Get_Top;
    property Left: Integer read Get_Left;
    property Width: Integer read Get_Width;
    property Height: Integer read Get_Height;
    property Selection: ITextSelection read Get_Selection write Set_Selection;
    property WindowState: WindowStateEnum read Get_WindowState write Set_WindowState;
  end;

// *********************************************************************//
// DispIntf:  ITextWindowDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {3980100B-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  ITextWindowDisp = dispinterface
    ['{3980100B-E1EF-11D5-824C-008048AE8B26}']
    property Application: IDispatch readonly dispid 1;
    property HWND: Integer readonly dispid 2;
    property IsActive: WordBool readonly dispid 4;
    property Top: Integer readonly dispid 5;
    property Left: Integer readonly dispid 6;
    property Width: Integer readonly dispid 7;
    property Height: Integer readonly dispid 8;
    procedure Activate; dispid 9;
    property Selection: ITextSelection dispid 10;
    property WindowState: WindowStateEnum dispid 11;
  end;

// *********************************************************************//
// Interface: IBatch
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801003-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IBatch = interface(IDispatch)
    ['{39801003-E1EF-11D5-824C-008048AE8B26}']
    function Get_Application: IDispatch; safecall;
    function Get_IsOpened: WordBool; safecall;
    function Get_CurrentPage: Integer; safecall;
    function Get_Pages: IBatchPages; safecall;
    function Get_Options: IBatchOptions; safecall;
    function Get_path: WideString; safecall;
    procedure Open(const path: WideString); safecall;
    procedure Create(const path: WideString; templateType: BatchTemplateTypeEnum; 
                     const templatePath: WideString); safecall;
    procedure Close; safecall;
    procedure Delete; safecall;
    procedure UpdatePageList; safecall;
    procedure AddImages(const Pages: IStringsCollection); safecall;
    procedure AnalyzePages(const Pages: IBatchPagesCollection); safecall;
    procedure AnalyzeAllNotAnalyzedPages; safecall;
    procedure RecognizePages(const Pages: IBatchPagesCollection); safecall;
    procedure RecognizeAllUnrecognizedPages; safecall;
    procedure SaveOptions(const path: WideString); safecall;
    procedure LoadOptions(const path: WideString); safecall;
    procedure ResetOptions(flags: Integer); safecall;
    procedure ModifyImages(operation: ImageOperationEnum; const Pages: IBatchPagesCollection); safecall;
    procedure Scan(pageNumber: Integer); safecall;
    procedure ScanMultiplePages(firstPageNumber: Integer; pageNumbersIncrement: Integer); safecall;
    procedure ScanAndRead(pageNum: Integer); safecall;
    procedure ScanAndReadMultiplePages(firstPageNum: Integer; pageNumbersIncrement: Integer); safecall;
    procedure ExportPagesToFile(const Pages: IBatchPagesCollection; Format: BatchExportFormatEnum; 
                                const fileName: WideString); safecall;
    procedure DeleteText(const Pages: IBatchPagesCollection); safecall;
    procedure ClearErrorsAndWarnings(const Pages: IBatchPagesCollection); safecall;
    procedure SetVerifiedAttribute(const Pages: IBatchPagesCollection); safecall;
    procedure SetExportedAttribute(const Pages: IBatchPagesCollection); safecall;
    procedure LoadBlocks(const Pages: IBatchPagesCollection; const layoutPath: WideString); safecall;
    procedure DeletePages(const Pages: IBatchPagesCollection); safecall;
    procedure RenumberPages(const Pages: IBatchPagesCollection; newBase: Integer; fCompact: WordBool); safecall;
    procedure OpenPage(Number: Integer); safecall;
    procedure CloseCurrentPage; safecall;
    procedure AnalyzeCurrentPage; safecall;
    procedure RecognizeCurrentPage; safecall;
    procedure SaveImagesToFiles(const Pages: IBatchPagesCollection; 
                                fileFormat: ImageFileFormatEnum; const fileNamePrefix: WideString; 
                                saveToOneFile: WordBool); safecall;
    property Application: IDispatch read Get_Application;
    property IsOpened: WordBool read Get_IsOpened;
    property CurrentPage: Integer read Get_CurrentPage;
    property Pages: IBatchPages read Get_Pages;
    property Options: IBatchOptions read Get_Options;
    property path: WideString read Get_path;
  end;

// *********************************************************************//
// DispIntf:  IBatchDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801003-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IBatchDisp = dispinterface
    ['{39801003-E1EF-11D5-824C-008048AE8B26}']
    property Application: IDispatch readonly dispid 1;
    property IsOpened: WordBool readonly dispid 2;
    property CurrentPage: Integer readonly dispid 3;
    property Pages: IBatchPages readonly dispid 4;
    property Options: IBatchOptions readonly dispid 5;
    property path: WideString readonly dispid 37;
    procedure Open(const path: WideString); dispid 6;
    procedure Create(const path: WideString; templateType: BatchTemplateTypeEnum; 
                     const templatePath: WideString); dispid 7;
    procedure Close; dispid 8;
    procedure Delete; dispid 9;
    procedure UpdatePageList; dispid 10;
    procedure AddImages(const Pages: IStringsCollection); dispid 11;
    procedure AnalyzePages(const Pages: IBatchPagesCollection); dispid 12;
    procedure AnalyzeAllNotAnalyzedPages; dispid 13;
    procedure RecognizePages(const Pages: IBatchPagesCollection); dispid 14;
    procedure RecognizeAllUnrecognizedPages; dispid 15;
    procedure SaveOptions(const path: WideString); dispid 16;
    procedure LoadOptions(const path: WideString); dispid 17;
    procedure ResetOptions(flags: Integer); dispid 18;
    procedure ModifyImages(operation: ImageOperationEnum; const Pages: IBatchPagesCollection); dispid 19;
    procedure Scan(pageNumber: Integer); dispid 20;
    procedure ScanMultiplePages(firstPageNumber: Integer; pageNumbersIncrement: Integer); dispid 21;
    procedure ScanAndRead(pageNum: Integer); dispid 22;
    procedure ScanAndReadMultiplePages(firstPageNum: Integer; pageNumbersIncrement: Integer); dispid 23;
    procedure ExportPagesToFile(const Pages: IBatchPagesCollection; Format: BatchExportFormatEnum; 
                                const fileName: WideString); dispid 24;
    procedure DeleteText(const Pages: IBatchPagesCollection); dispid 25;
    procedure ClearErrorsAndWarnings(const Pages: IBatchPagesCollection); dispid 26;
    procedure SetVerifiedAttribute(const Pages: IBatchPagesCollection); dispid 27;
    procedure SetExportedAttribute(const Pages: IBatchPagesCollection); dispid 28;
    procedure LoadBlocks(const Pages: IBatchPagesCollection; const layoutPath: WideString); dispid 31;
    procedure DeletePages(const Pages: IBatchPagesCollection); dispid 32;
    procedure RenumberPages(const Pages: IBatchPagesCollection; newBase: Integer; fCompact: WordBool); dispid 29;
    procedure OpenPage(Number: Integer); dispid 33;
    procedure CloseCurrentPage; dispid 34;
    procedure AnalyzeCurrentPage; dispid 35;
    procedure RecognizeCurrentPage; dispid 36;
    procedure SaveImagesToFiles(const Pages: IBatchPagesCollection; 
                                fileFormat: ImageFileFormatEnum; const fileNamePrefix: WideString; 
                                saveToOneFile: WordBool); dispid 38;
  end;

// *********************************************************************//
// Interface: IBatchPages
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801005-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IBatchPages = interface(IDispatch)
    ['{39801005-E1EF-11D5-824C-008048AE8B26}']
    function Get_Application: IDispatch; safecall;
    function Get__NewEnum: IUnknown; safecall;
    function Get_Count: Integer; safecall;
    function Item(index: Integer): IBatchPage; safecall;
    function FindPageByNumber(Number: Integer): IBatchPage; safecall;
    property Application: IDispatch read Get_Application;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  IBatchPagesDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801005-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IBatchPagesDisp = dispinterface
    ['{39801005-E1EF-11D5-824C-008048AE8B26}']
    property Application: IDispatch readonly dispid 1;
    property _NewEnum: IUnknown readonly dispid -4;
    property Count: Integer readonly dispid 2;
    function Item(index: Integer): IBatchPage; dispid 0;
    function FindPageByNumber(Number: Integer): IBatchPage; dispid 8;
  end;

// *********************************************************************//
// Interface: IBatchOptions
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801007-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IBatchOptions = interface(IDispatch)
    ['{39801007-E1EF-11D5-824C-008048AE8B26}']
    function Get_Application: IDispatch; safecall;
    function Get_DetectOrientation: WordBool; safecall;
    procedure Set_DetectOrientation(pVal: WordBool); safecall;
    function Get_InvertNewImage: WordBool; safecall;
    procedure Set_InvertNewImage(pVal: WordBool); safecall;
    function Get_DespeckleNewImage: WordBool; safecall;
    procedure Set_DespeckleNewImage(pVal: WordBool); safecall;
    function Get_SplitDualPage: WordBool; safecall;
    procedure Set_SplitDualPage(pVal: WordBool); safecall;
    function Get_ConvertImagesToBW: WordBool; safecall;
    procedure Set_ConvertImagesToBW(pVal: WordBool); safecall;
    function Get_Language: IStringsCollection; safecall;
    procedure Set_Language(const languageList: IStringsCollection); safecall;
    function Get_TextType: TextTypeEnum; safecall;
    procedure Set_TextType(pVal: TextTypeEnum); safecall;
    function Get_ColumnAnalysisMode: PageColumnAnalysisModeEnum; safecall;
    procedure Set_ColumnAnalysisMode(pVal: PageColumnAnalysisModeEnum); safecall;
    function Get_UserPatternMode: UserPatternModeEnum; safecall;
    procedure Set_UserPatternMode(pVal: UserPatternModeEnum); safecall;
    function Get_UserPatternFileName: WideString; safecall;
    procedure Set_UserPatternFileName(const pVal: WideString); safecall;
    function Get_DetectBarcodes: WordBool; safecall;
    procedure Set_DetectBarcodes(pVal: WordBool); safecall;
    function Get_SinglelineTableCells: WordBool; safecall;
    procedure Set_SinglelineTableCells(pVal: WordBool); safecall;
    function Get_NoMergedTableCells: WordBool; safecall;
    procedure Set_NoMergedTableCells(pVal: WordBool); safecall;
    function Get_UseBuiltInPatterns: WordBool; safecall;
    procedure Set_UseBuiltInPatterns(pVal: WordBool); safecall;
    function Get_RetainPicturesWhileExport: WordBool; safecall;
    procedure Set_RetainPicturesWhileExport(pVal: WordBool); safecall;
    function Get_ErrorHighlightLevel: ErrorHighlightLevelEnum; safecall;
    procedure Set_ErrorHighlightLevel(pVal: ErrorHighlightLevelEnum); safecall;
    function Get_RecognizedTextFontName(FontType: FontTypeEnum): WideString; safecall;
    procedure Set_RecognizedTextFontName(FontType: FontTypeEnum; const pVal: WideString); safecall;
    function Get_EditorDraftModeFontSize: Integer; safecall;
    procedure Set_EditorDraftModeFontSize(pVal: Integer); safecall;
    function Get_FileExportMode: FileExportModeEnum; safecall;
    procedure Set_FileExportMode(pVal: FileExportModeEnum); safecall;
    function Get_ExportPageFormat: ExportPageFormatEnum; safecall;
    procedure Set_ExportPageFormat(pVal: ExportPageFormatEnum); safecall;
    function Get_RTFExportParams: IRTFExportParams; safecall;
    function Get_XLExportParams: IXLExportParams; safecall;
    function Get_PDFExportParams: IPDFExportParams; safecall;
    function Get_DBFExportParams: IDBFExportParams; safecall;
    function Get_HTMLExportParams: IHTMLExportParams; safecall;
    function Get_TextExportParams: ITextExportParams; safecall;
    function Get_StopAtUncertainWords: WordBool; safecall;
    procedure Set_StopAtUncertainWords(pVal: WordBool); safecall;
    function Get_StopAtNonDictionaryWords: WordBool; safecall;
    procedure Set_StopAtNonDictionaryWords(pVal: WordBool); safecall;
    function Get_StopAtCompoundWords: WordBool; safecall;
    procedure Set_StopAtCompoundWords(pVal: WordBool); safecall;
    function Get_IgnoreGarbageWords: WordBool; safecall;
    procedure Set_IgnoreGarbageWords(pVal: WordBool); safecall;
    function Get_SkipPromptingWordForms: WordBool; safecall;
    procedure Set_SkipPromptingWordForms(pVal: WordBool); safecall;
    function Get_CorrectSpaces: WordBool; safecall;
    procedure Set_CorrectSpaces(pVal: WordBool); safecall;
    function Get_UserProperty(const name: WideString): OleVariant; safecall;
    procedure Set_UserProperty(const name: WideString; pVal: OleVariant); safecall;
    function Get_UseFineScanInterface: WordBool; safecall;
    procedure Set_UseFineScanInterface(pVal: WordBool); safecall;
    property Application: IDispatch read Get_Application;
    property DetectOrientation: WordBool read Get_DetectOrientation write Set_DetectOrientation;
    property InvertNewImage: WordBool read Get_InvertNewImage write Set_InvertNewImage;
    property DespeckleNewImage: WordBool read Get_DespeckleNewImage write Set_DespeckleNewImage;
    property SplitDualPage: WordBool read Get_SplitDualPage write Set_SplitDualPage;
    property ConvertImagesToBW: WordBool read Get_ConvertImagesToBW write Set_ConvertImagesToBW;
    property Language: IStringsCollection read Get_Language write Set_Language;
    property TextType: TextTypeEnum read Get_TextType write Set_TextType;
    property ColumnAnalysisMode: PageColumnAnalysisModeEnum read Get_ColumnAnalysisMode write Set_ColumnAnalysisMode;
    property UserPatternMode: UserPatternModeEnum read Get_UserPatternMode write Set_UserPatternMode;
    property UserPatternFileName: WideString read Get_UserPatternFileName write Set_UserPatternFileName;
    property DetectBarcodes: WordBool read Get_DetectBarcodes write Set_DetectBarcodes;
    property SinglelineTableCells: WordBool read Get_SinglelineTableCells write Set_SinglelineTableCells;
    property NoMergedTableCells: WordBool read Get_NoMergedTableCells write Set_NoMergedTableCells;
    property UseBuiltInPatterns: WordBool read Get_UseBuiltInPatterns write Set_UseBuiltInPatterns;
    property RetainPicturesWhileExport: WordBool read Get_RetainPicturesWhileExport write Set_RetainPicturesWhileExport;
    property ErrorHighlightLevel: ErrorHighlightLevelEnum read Get_ErrorHighlightLevel write Set_ErrorHighlightLevel;
    property RecognizedTextFontName[FontType: FontTypeEnum]: WideString read Get_RecognizedTextFontName write Set_RecognizedTextFontName;
    property EditorDraftModeFontSize: Integer read Get_EditorDraftModeFontSize write Set_EditorDraftModeFontSize;
    property FileExportMode: FileExportModeEnum read Get_FileExportMode write Set_FileExportMode;
    property ExportPageFormat: ExportPageFormatEnum read Get_ExportPageFormat write Set_ExportPageFormat;
    property RTFExportParams: IRTFExportParams read Get_RTFExportParams;
    property XLExportParams: IXLExportParams read Get_XLExportParams;
    property PDFExportParams: IPDFExportParams read Get_PDFExportParams;
    property DBFExportParams: IDBFExportParams read Get_DBFExportParams;
    property HTMLExportParams: IHTMLExportParams read Get_HTMLExportParams;
    property TextExportParams: ITextExportParams read Get_TextExportParams;
    property StopAtUncertainWords: WordBool read Get_StopAtUncertainWords write Set_StopAtUncertainWords;
    property StopAtNonDictionaryWords: WordBool read Get_StopAtNonDictionaryWords write Set_StopAtNonDictionaryWords;
    property StopAtCompoundWords: WordBool read Get_StopAtCompoundWords write Set_StopAtCompoundWords;
    property IgnoreGarbageWords: WordBool read Get_IgnoreGarbageWords write Set_IgnoreGarbageWords;
    property SkipPromptingWordForms: WordBool read Get_SkipPromptingWordForms write Set_SkipPromptingWordForms;
    property CorrectSpaces: WordBool read Get_CorrectSpaces write Set_CorrectSpaces;
    property UserProperty[const name: WideString]: OleVariant read Get_UserProperty write Set_UserProperty;
    property UseFineScanInterface: WordBool read Get_UseFineScanInterface write Set_UseFineScanInterface;
  end;

// *********************************************************************//
// DispIntf:  IBatchOptionsDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801007-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IBatchOptionsDisp = dispinterface
    ['{39801007-E1EF-11D5-824C-008048AE8B26}']
    property Application: IDispatch readonly dispid 1;
    property DetectOrientation: WordBool dispid 2;
    property InvertNewImage: WordBool dispid 9;
    property DespeckleNewImage: WordBool dispid 10;
    property SplitDualPage: WordBool dispid 12;
    property ConvertImagesToBW: WordBool dispid 8;
    property Language: IStringsCollection dispid 18;
    property TextType: TextTypeEnum dispid 19;
    property ColumnAnalysisMode: PageColumnAnalysisModeEnum dispid 23;
    property UserPatternMode: UserPatternModeEnum dispid 20;
    property UserPatternFileName: WideString dispid 21;
    property DetectBarcodes: WordBool dispid 4;
    property SinglelineTableCells: WordBool dispid 13;
    property NoMergedTableCells: WordBool dispid 14;
    property UseBuiltInPatterns: WordBool dispid 7;
    property RetainPicturesWhileExport: WordBool dispid 11;
    property ErrorHighlightLevel: ErrorHighlightLevelEnum dispid 22;
    property RecognizedTextFontName[FontType: FontTypeEnum]: WideString dispid 24;
    property EditorDraftModeFontSize: Integer dispid 28;
    property FileExportMode: FileExportModeEnum dispid 29;
    property ExportPageFormat: ExportPageFormatEnum dispid 30;
    property RTFExportParams: IRTFExportParams readonly dispid 31;
    property XLExportParams: IXLExportParams readonly dispid 32;
    property PDFExportParams: IPDFExportParams readonly dispid 33;
    property DBFExportParams: IDBFExportParams readonly dispid 34;
    property HTMLExportParams: IHTMLExportParams readonly dispid 35;
    property TextExportParams: ITextExportParams readonly dispid 36;
    property StopAtUncertainWords: WordBool dispid 40;
    property StopAtNonDictionaryWords: WordBool dispid 41;
    property StopAtCompoundWords: WordBool dispid 42;
    property IgnoreGarbageWords: WordBool dispid 43;
    property SkipPromptingWordForms: WordBool dispid 44;
    property CorrectSpaces: WordBool dispid 45;
    property UserProperty[const name: WideString]: OleVariant dispid 39;
    property UseFineScanInterface: WordBool dispid 46;
  end;

// *********************************************************************//
// Interface: IRTFExportParams
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801010-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IRTFExportParams = interface(IDispatch)
    ['{39801010-E1EF-11D5-824C-008048AE8B26}']
    function Get_Application: IDispatch; safecall;
    function Get_KeepLines: WordBool; safecall;
    procedure Set_KeepLines(pVal: WordBool); safecall;
    function Get_KeepPages: WordBool; safecall;
    procedure Set_KeepPages(pVal: WordBool); safecall;
    function Get_RemoveSoftHyphens: WordBool; safecall;
    procedure Set_RemoveSoftHyphens(pVal: WordBool); safecall;
    function Get_HighlightErrorsWithTextColor: WordBool; safecall;
    procedure Set_HighlightErrorsWithTextColor(pVal: WordBool); safecall;
    function Get_HighlightErrorsWithBackgroundColor: WordBool; safecall;
    procedure Set_HighlightErrorsWithBackgroundColor(pVal: WordBool); safecall;
    function Get_KeepTextAndBackgroundColor: WordBool; safecall;
    procedure Set_KeepTextAndBackgroundColor(pVal: WordBool); safecall;
    function Get_ErrorTextColor: Integer; safecall;
    procedure Set_ErrorTextColor(pVal: Integer); safecall;
    function Get_ErrorBackgroundColor: Integer; safecall;
    procedure Set_ErrorBackgroundColor(pVal: Integer); safecall;
    function Get_PaperWidth: Integer; safecall;
    procedure Set_PaperWidth(pVal: Integer); safecall;
    function Get_PaperHeight: Integer; safecall;
    procedure Set_PaperHeight(pVal: Integer); safecall;
    function Get_PictureResolution: Integer; safecall;
    procedure Set_PictureResolution(pVal: Integer); safecall;
    property Application: IDispatch read Get_Application;
    property KeepLines: WordBool read Get_KeepLines write Set_KeepLines;
    property KeepPages: WordBool read Get_KeepPages write Set_KeepPages;
    property RemoveSoftHyphens: WordBool read Get_RemoveSoftHyphens write Set_RemoveSoftHyphens;
    property HighlightErrorsWithTextColor: WordBool read Get_HighlightErrorsWithTextColor write Set_HighlightErrorsWithTextColor;
    property HighlightErrorsWithBackgroundColor: WordBool read Get_HighlightErrorsWithBackgroundColor write Set_HighlightErrorsWithBackgroundColor;
    property KeepTextAndBackgroundColor: WordBool read Get_KeepTextAndBackgroundColor write Set_KeepTextAndBackgroundColor;
    property ErrorTextColor: Integer read Get_ErrorTextColor write Set_ErrorTextColor;
    property ErrorBackgroundColor: Integer read Get_ErrorBackgroundColor write Set_ErrorBackgroundColor;
    property PaperWidth: Integer read Get_PaperWidth write Set_PaperWidth;
    property PaperHeight: Integer read Get_PaperHeight write Set_PaperHeight;
    property PictureResolution: Integer read Get_PictureResolution write Set_PictureResolution;
  end;

// *********************************************************************//
// DispIntf:  IRTFExportParamsDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801010-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IRTFExportParamsDisp = dispinterface
    ['{39801010-E1EF-11D5-824C-008048AE8B26}']
    property Application: IDispatch readonly dispid 1;
    property KeepLines: WordBool dispid 2;
    property KeepPages: WordBool dispid 3;
    property RemoveSoftHyphens: WordBool dispid 5;
    property HighlightErrorsWithTextColor: WordBool dispid 6;
    property HighlightErrorsWithBackgroundColor: WordBool dispid 7;
    property KeepTextAndBackgroundColor: WordBool dispid 8;
    property ErrorTextColor: Integer dispid 10;
    property ErrorBackgroundColor: Integer dispid 11;
    property PaperWidth: Integer dispid 12;
    property PaperHeight: Integer dispid 13;
    property PictureResolution: Integer dispid 14;
  end;

// *********************************************************************//
// Interface: IXLExportParams
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801012-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IXLExportParams = interface(IDispatch)
    ['{39801012-E1EF-11D5-824C-008048AE8B26}']
    function Get_Application: IDispatch; safecall;
    function Get_ConvertStringsToNumbers: WordBool; safecall;
    procedure Set_ConvertStringsToNumbers(pVal: WordBool); safecall;
    function Get_TablesOnly: WordBool; safecall;
    procedure Set_TablesOnly(pVal: WordBool); safecall;
    property Application: IDispatch read Get_Application;
    property ConvertStringsToNumbers: WordBool read Get_ConvertStringsToNumbers write Set_ConvertStringsToNumbers;
    property TablesOnly: WordBool read Get_TablesOnly write Set_TablesOnly;
  end;

// *********************************************************************//
// DispIntf:  IXLExportParamsDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801012-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IXLExportParamsDisp = dispinterface
    ['{39801012-E1EF-11D5-824C-008048AE8B26}']
    property Application: IDispatch readonly dispid 1;
    property ConvertStringsToNumbers: WordBool dispid 2;
    property TablesOnly: WordBool dispid 3;
  end;

// *********************************************************************//
// Interface: IPDFExportParams
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801015-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IPDFExportParams = interface(IDispatch)
    ['{39801015-E1EF-11D5-824C-008048AE8B26}']
    function Get_Application: IDispatch; safecall;
    function Get_ReplaceUncertainWordsWithImage: WordBool; safecall;
    procedure Set_ReplaceUncertainWordsWithImage(pVal: WordBool); safecall;
    function Get_KeepTextAndBackgroundColor: WordBool; safecall;
    procedure Set_KeepTextAndBackgroundColor(pVal: WordBool); safecall;
    function Get_ExportMode: PDFExportModeEnum; safecall;
    procedure Set_ExportMode(pVal: PDFExportModeEnum); safecall;
    procedure SetTypeOneFont(FontType: FontTypeEnum; fontFeature: FontFeatureEnum; 
                             const fontFileName: WideString); safecall;
    function GetTypeOneFont(FontType: FontTypeEnum; fontFeature: FontFeatureEnum): WideString; safecall;
    function Get_FontMode: FontModeEnum; safecall;
    procedure Set_FontMode(pVal: FontModeEnum); safecall;
    function Get_PictureResolution: Integer; safecall;
    procedure Set_PictureResolution(pVal: Integer); safecall;
    function Get_PictureJPEGQuality: Integer; safecall;
    procedure Set_PictureJPEGQuality(Result: Integer); safecall;
    property Application: IDispatch read Get_Application;
    property ReplaceUncertainWordsWithImage: WordBool read Get_ReplaceUncertainWordsWithImage write Set_ReplaceUncertainWordsWithImage;
    property KeepTextAndBackgroundColor: WordBool read Get_KeepTextAndBackgroundColor write Set_KeepTextAndBackgroundColor;
    property ExportMode: PDFExportModeEnum read Get_ExportMode write Set_ExportMode;
    property FontMode: FontModeEnum read Get_FontMode write Set_FontMode;
    property PictureResolution: Integer read Get_PictureResolution write Set_PictureResolution;
    property PictureJPEGQuality: Integer read Get_PictureJPEGQuality write Set_PictureJPEGQuality;
  end;

// *********************************************************************//
// DispIntf:  IPDFExportParamsDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801015-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IPDFExportParamsDisp = dispinterface
    ['{39801015-E1EF-11D5-824C-008048AE8B26}']
    property Application: IDispatch readonly dispid 1;
    property ReplaceUncertainWordsWithImage: WordBool dispid 2;
    property KeepTextAndBackgroundColor: WordBool dispid 3;
    property ExportMode: PDFExportModeEnum dispid 4;
    procedure SetTypeOneFont(FontType: FontTypeEnum; fontFeature: FontFeatureEnum; 
                             const fontFileName: WideString); dispid 8;
    function GetTypeOneFont(FontType: FontTypeEnum; fontFeature: FontFeatureEnum): WideString; dispid 9;
    property FontMode: FontModeEnum dispid 10;
    property PictureResolution: Integer dispid 11;
    property PictureJPEGQuality: Integer dispid 12;
  end;

// *********************************************************************//
// Interface: IDBFExportParams
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801013-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IDBFExportParams = interface(IDispatch)
    ['{39801013-E1EF-11D5-824C-008048AE8B26}']
    function Get_Application: IDispatch; safecall;
    function Get_AppendToEnd: WordBool; safecall;
    procedure Set_AppendToEnd(pVal: WordBool); safecall;
    function Get_CodePageType: CodePageTypeEnum; safecall;
    procedure Set_CodePageType(pVal: CodePageTypeEnum); safecall;
    function Get_CodePage: CodePageEnum; safecall;
    procedure Set_CodePage(pVal: CodePageEnum); safecall;
    property Application: IDispatch read Get_Application;
    property AppendToEnd: WordBool read Get_AppendToEnd write Set_AppendToEnd;
    property CodePageType: CodePageTypeEnum read Get_CodePageType write Set_CodePageType;
    property CodePage: CodePageEnum read Get_CodePage write Set_CodePage;
  end;

// *********************************************************************//
// DispIntf:  IDBFExportParamsDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801013-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IDBFExportParamsDisp = dispinterface
    ['{39801013-E1EF-11D5-824C-008048AE8B26}']
    property Application: IDispatch readonly dispid 1;
    property AppendToEnd: WordBool dispid 2;
    property CodePageType: CodePageTypeEnum dispid 3;
    property CodePage: CodePageEnum dispid 4;
  end;

// *********************************************************************//
// Interface: IHTMLExportParams
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801014-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IHTMLExportParams = interface(IDispatch)
    ['{39801014-E1EF-11D5-824C-008048AE8B26}']
    function Get_Application: IDispatch; safecall;
    function Get_KeepLines: WordBool; safecall;
    procedure Set_KeepLines(pVal: WordBool); safecall;
    function Get_SeparatePages: WordBool; safecall;
    procedure Set_SeparatePages(pVal: WordBool); safecall;
    function Get_KeepTextAndBackgroundColor: WordBool; safecall;
    procedure Set_KeepTextAndBackgroundColor(pVal: WordBool); safecall;
    function Get_HTMLFormatMode: HTMLFormatModeEnum; safecall;
    procedure Set_HTMLFormatMode(pVal: HTMLFormatModeEnum); safecall;
    function Get_CodePageType: CodePageTypeEnum; safecall;
    procedure Set_CodePageType(pVal: CodePageTypeEnum); safecall;
    function Get_CodePage: CodePageEnum; safecall;
    procedure Set_CodePage(pVal: CodePageEnum); safecall;
    function Get_PictureResolution: Integer; safecall;
    procedure Set_PictureResolution(pVal: Integer); safecall;
    function Get_PictureJPEGQuality: Integer; safecall;
    procedure Set_PictureJPEGQuality(Result: Integer); safecall;
    property Application: IDispatch read Get_Application;
    property KeepLines: WordBool read Get_KeepLines write Set_KeepLines;
    property SeparatePages: WordBool read Get_SeparatePages write Set_SeparatePages;
    property KeepTextAndBackgroundColor: WordBool read Get_KeepTextAndBackgroundColor write Set_KeepTextAndBackgroundColor;
    property HTMLFormatMode: HTMLFormatModeEnum read Get_HTMLFormatMode write Set_HTMLFormatMode;
    property CodePageType: CodePageTypeEnum read Get_CodePageType write Set_CodePageType;
    property CodePage: CodePageEnum read Get_CodePage write Set_CodePage;
    property PictureResolution: Integer read Get_PictureResolution write Set_PictureResolution;
    property PictureJPEGQuality: Integer read Get_PictureJPEGQuality write Set_PictureJPEGQuality;
  end;

// *********************************************************************//
// DispIntf:  IHTMLExportParamsDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801014-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IHTMLExportParamsDisp = dispinterface
    ['{39801014-E1EF-11D5-824C-008048AE8B26}']
    property Application: IDispatch readonly dispid 1;
    property KeepLines: WordBool dispid 2;
    property SeparatePages: WordBool dispid 3;
    property KeepTextAndBackgroundColor: WordBool dispid 6;
    property HTMLFormatMode: HTMLFormatModeEnum dispid 8;
    property CodePageType: CodePageTypeEnum dispid 9;
    property CodePage: CodePageEnum dispid 10;
    property PictureResolution: Integer dispid 11;
    property PictureJPEGQuality: Integer dispid 12;
  end;

// *********************************************************************//
// Interface: ITextExportParams
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801011-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  ITextExportParams = interface(IDispatch)
    ['{39801011-E1EF-11D5-824C-008048AE8B26}']
    function Get_Application: IDispatch; safecall;
    function Get_InsertEmptyLineBetweenParagraphs: WordBool; safecall;
    procedure Set_InsertEmptyLineBetweenParagraphs(pVal: WordBool); safecall;
    function Get_ExportParagraphsAsOneLine: WordBool; safecall;
    procedure Set_ExportParagraphsAsOneLine(pVal: WordBool); safecall;
    function Get_UsePageBreaks: WordBool; safecall;
    procedure Set_UsePageBreaks(pVal: WordBool); safecall;
    function Get_AppendToEnd: WordBool; safecall;
    procedure Set_AppendToEnd(pVal: WordBool); safecall;
    function Get_CodePageType: CodePageTypeEnum; safecall;
    procedure Set_CodePageType(pVal: CodePageTypeEnum); safecall;
    function Get_CodePage: CodePageEnum; safecall;
    procedure Set_CodePage(pVal: CodePageEnum); safecall;
    property Application: IDispatch read Get_Application;
    property InsertEmptyLineBetweenParagraphs: WordBool read Get_InsertEmptyLineBetweenParagraphs write Set_InsertEmptyLineBetweenParagraphs;
    property ExportParagraphsAsOneLine: WordBool read Get_ExportParagraphsAsOneLine write Set_ExportParagraphsAsOneLine;
    property UsePageBreaks: WordBool read Get_UsePageBreaks write Set_UsePageBreaks;
    property AppendToEnd: WordBool read Get_AppendToEnd write Set_AppendToEnd;
    property CodePageType: CodePageTypeEnum read Get_CodePageType write Set_CodePageType;
    property CodePage: CodePageEnum read Get_CodePage write Set_CodePage;
  end;

// *********************************************************************//
// DispIntf:  ITextExportParamsDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39801011-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  ITextExportParamsDisp = dispinterface
    ['{39801011-E1EF-11D5-824C-008048AE8B26}']
    property Application: IDispatch readonly dispid 1;
    property InsertEmptyLineBetweenParagraphs: WordBool dispid 2;
    property ExportParagraphsAsOneLine: WordBool dispid 3;
    property UsePageBreaks: WordBool dispid 4;
    property AppendToEnd: WordBool dispid 5;
    property CodePageType: CodePageTypeEnum dispid 10;
    property CodePage: CodePageEnum dispid 11;
  end;

// *********************************************************************//
// Interface: IToolbar
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {3980100D-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IToolbar = interface(IDispatch)
    ['{3980100D-E1EF-11D5-824C-008048AE8B26}']
    function Get_Application: IDispatch; safecall;
    function Get_Visible: WordBool; safecall;
    procedure Set_Visible(pVal: WordBool); safecall;
    procedure InsertButton(action: MenuItemEnum; newPosition: Integer); safecall;
    procedure InsertSeparator(position: Integer); safecall;
    procedure RemoveButton(action: MenuItemEnum); safecall;
    procedure RemoveButtonByPos(position: Integer); safecall;
    function Get_Count: Integer; safecall;
    function MenuItemAtPosition(position: Integer): MenuItemEnum; safecall;
    property Application: IDispatch read Get_Application;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  IToolbarDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {3980100D-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IToolbarDisp = dispinterface
    ['{3980100D-E1EF-11D5-824C-008048AE8B26}']
    property Application: IDispatch readonly dispid 1;
    property Visible: WordBool dispid 2;
    procedure InsertButton(action: MenuItemEnum; newPosition: Integer); dispid 3;
    procedure InsertSeparator(position: Integer); dispid 4;
    procedure RemoveButton(action: MenuItemEnum); dispid 5;
    procedure RemoveButtonByPos(position: Integer); dispid 6;
    property Count: Integer readonly dispid 7;
    function MenuItemAtPosition(position: Integer): MenuItemEnum; dispid 8;
  end;

// *********************************************************************//
// DispIntf:  IApplicationEvents
// Flags:     (4096) Dispatchable
// GUID:      {3980100E-E1EF-11D5-824C-008048AE8B26}
// *********************************************************************//
  IApplicationEvents = dispinterface
    ['{3980100E-E1EF-11D5-824C-008048AE8B26}']
    procedure NotifyBatchNew; dispid 1;
    procedure NotifyBatchOpened; dispid 2;
    procedure NotifyBatchClosed; dispid 3;
    procedure NotifyWindowActivate(wndName: WindowNameEnum); dispid 4;
    procedure OnApplicationCommand(menuItem: MenuItemEnum; out cancelCommand: WordBool); dispid 5;
    procedure NotifyEndProcessPage(operationType: OperationTypeEnum; const page: IBatchPage); dispid 9;
    procedure NotifyEndProcessBatch(operationType: OperationTypeEnum); dispid 10;
    procedure OnBatchProcessProgress(operationType: OperationTypeEnum; 
                                     const CurrentPage: IBatchPage; processedPagesCount: Integer; 
                                     remainingPagesCount: Integer; out cancelOperation: WordBool); dispid 11;
    procedure ReportProcessPercentage(operationType: OperationTypeEnum; 
                                      const CurrentPage: IBatchPage; percentage: Integer; 
                                      out cancelOperation: WordBool); dispid 15;
    procedure NotifyBatchProcessingError(operationType: OperationTypeEnum; 
                                         const CurrentPage: IBatchPage; 
                                         const errorMessage: WideString; 
                                         out cancelOperation: WordBool); dispid 8;
    procedure NotifyBatchPagesChanged(const changedPages: IBatchPagesCollection); dispid 6;
    procedure OnCustomAction(customActionId: MenuItemEnum); dispid 12;
    procedure OnCustomSendTo(customSendToDestId: Integer; const Pages: IBatchPagesCollection); dispid 13;
    procedure NotifyStopScanning; dispid 14;
    procedure RequestPasswordCallback(const imageFileName: WideString; ownerPassword: WordBool; 
                                      var password: WideString; var Result: PasswordResultEnum); dispid 16;
  end;

// *********************************************************************//
// The Class CoApplication provides a Create and CreateRemote method to          
// create instances of the default interface IApplication exposed by              
// the CoClass Application. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoApplication = class
    class function Create: IApplication;
    class function CreateRemote(const MachineName: string): IApplication;
  end;

// *********************************************************************//
// The Class CoSettings provides a Create and CreateRemote method to          
// create instances of the default interface ISettings exposed by              
// the CoClass Settings. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoSettings = class
    class function Create: ISettings;
    class function CreateRemote(const MachineName: string): ISettings;
  end;

// *********************************************************************//
// The Class CoBatchWindow provides a Create and CreateRemote method to          
// create instances of the default interface IBatchWindow exposed by              
// the CoClass BatchWindow. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoBatchWindow = class
    class function Create: IBatchWindow;
    class function CreateRemote(const MachineName: string): IBatchWindow;
  end;

// *********************************************************************//
// The Class CoImageWindow provides a Create and CreateRemote method to          
// create instances of the default interface IImageWindow exposed by              
// the CoClass ImageWindow. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoImageWindow = class
    class function Create: IImageWindow;
    class function CreateRemote(const MachineName: string): IImageWindow;
  end;

// *********************************************************************//
// The Class CoTextWindow provides a Create and CreateRemote method to          
// create instances of the default interface ITextWindow exposed by              
// the CoClass TextWindow. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoTextWindow = class
    class function Create: ITextWindow;
    class function CreateRemote(const MachineName: string): ITextWindow;
  end;

// *********************************************************************//
// The Class CoBatch provides a Create and CreateRemote method to          
// create instances of the default interface IBatch exposed by              
// the CoClass Batch. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoBatch = class
    class function Create: IBatch;
    class function CreateRemote(const MachineName: string): IBatch;
  end;

// *********************************************************************//
// The Class Cotoolbar provides a Create and CreateRemote method to          
// create instances of the default interface IToolbar exposed by              
// the CoClass toolbar. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  Cotoolbar = class
    class function Create: IToolbar;
    class function CreateRemote(const MachineName: string): IToolbar;
  end;

// *********************************************************************//
// The Class CoBatchPage provides a Create and CreateRemote method to          
// create instances of the default interface IBatchPage exposed by              
// the CoClass BatchPage. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoBatchPage = class
    class function Create: IBatchPage;
    class function CreateRemote(const MachineName: string): IBatchPage;
  end;

// *********************************************************************//
// The Class CoBatchPages provides a Create and CreateRemote method to          
// create instances of the default interface IBatchPages exposed by              
// the CoClass BatchPages. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoBatchPages = class
    class function Create: IBatchPages;
    class function CreateRemote(const MachineName: string): IBatchPages;
  end;

// *********************************************************************//
// The Class CoBatchPagesCollection provides a Create and CreateRemote method to          
// create instances of the default interface IBatchPagesCollection exposed by              
// the CoClass BatchPagesCollection. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoBatchPagesCollection = class
    class function Create: IBatchPagesCollection;
    class function CreateRemote(const MachineName: string): IBatchPagesCollection;
  end;

// *********************************************************************//
// The Class CoBatchEvent provides a Create and CreateRemote method to          
// create instances of the default interface IBatchEvent exposed by              
// the CoClass BatchEvent. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoBatchEvent = class
    class function Create: IBatchEvent;
    class function CreateRemote(const MachineName: string): IBatchEvent;
  end;

// *********************************************************************//
// The Class CoBatchOptions provides a Create and CreateRemote method to          
// create instances of the default interface IBatchOptions exposed by              
// the CoClass BatchOptions. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoBatchOptions = class
    class function Create: IBatchOptions;
    class function CreateRemote(const MachineName: string): IBatchOptions;
  end;

// *********************************************************************//
// The Class CoRTFExportParams provides a Create and CreateRemote method to          
// create instances of the default interface IRTFExportParams exposed by              
// the CoClass RTFExportParams. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoRTFExportParams = class
    class function Create: IRTFExportParams;
    class function CreateRemote(const MachineName: string): IRTFExportParams;
  end;

// *********************************************************************//
// The Class CoTextExportParams provides a Create and CreateRemote method to          
// create instances of the default interface ITextExportParams exposed by              
// the CoClass TextExportParams. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoTextExportParams = class
    class function Create: ITextExportParams;
    class function CreateRemote(const MachineName: string): ITextExportParams;
  end;

// *********************************************************************//
// The Class CoXLExportParams provides a Create and CreateRemote method to          
// create instances of the default interface IXLExportParams exposed by              
// the CoClass XLExportParams. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoXLExportParams = class
    class function Create: IXLExportParams;
    class function CreateRemote(const MachineName: string): IXLExportParams;
  end;

// *********************************************************************//
// The Class CoDBFExportParams provides a Create and CreateRemote method to          
// create instances of the default interface IDBFExportParams exposed by              
// the CoClass DBFExportParams. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoDBFExportParams = class
    class function Create: IDBFExportParams;
    class function CreateRemote(const MachineName: string): IDBFExportParams;
  end;

// *********************************************************************//
// The Class CoHTMLExportParams provides a Create and CreateRemote method to          
// create instances of the default interface IHTMLExportParams exposed by              
// the CoClass HTMLExportParams. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoHTMLExportParams = class
    class function Create: IHTMLExportParams;
    class function CreateRemote(const MachineName: string): IHTMLExportParams;
  end;

// *********************************************************************//
// The Class CoPDFExportParams provides a Create and CreateRemote method to          
// create instances of the default interface IPDFExportParams exposed by              
// the CoClass PDFExportParams. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoPDFExportParams = class
    class function Create: IPDFExportParams;
    class function CreateRemote(const MachineName: string): IPDFExportParams;
  end;

// *********************************************************************//
// The Class CoStringsCollection provides a Create and CreateRemote method to          
// create instances of the default interface IStringsCollection exposed by              
// the CoClass StringsCollection. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoStringsCollection = class
    class function Create: IStringsCollection;
    class function CreateRemote(const MachineName: string): IStringsCollection;
  end;

// *********************************************************************//
// The Class CotextSelection provides a Create and CreateRemote method to          
// create instances of the default interface ITextSelection exposed by              
// the CoClass textSelection. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CotextSelection = class
    class function Create: ITextSelection;
    class function CreateRemote(const MachineName: string): ITextSelection;
  end;

// *********************************************************************//
// The Class CoRegion provides a Create and CreateRemote method to          
// create instances of the default interface IRegion exposed by              
// the CoClass Region. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoRegion = class
    class function Create: IRegion;
    class function CreateRemote(const MachineName: string): IRegion;
  end;

// *********************************************************************//
// The Class CoImageDocument provides a Create and CreateRemote method to          
// create instances of the default interface IImageDocument exposed by              
// the CoClass ImageDocument. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoImageDocument = class
    class function Create: IImageDocument;
    class function CreateRemote(const MachineName: string): IImageDocument;
  end;

// *********************************************************************//
// The Class CoImage provides a Create and CreateRemote method to          
// create instances of the default interface IImage exposed by              
// the CoClass Image. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoImage = class
    class function Create: IImage;
    class function CreateRemote(const MachineName: string): IImage;
  end;

// *********************************************************************//
// The Class CoimageModification provides a Create and CreateRemote method to          
// create instances of the default interface IImageModification exposed by              
// the CoClass imageModification. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoimageModification = class
    class function Create: IImageModification;
    class function CreateRemote(const MachineName: string): IImageModification;
  end;

// *********************************************************************//
// The Class CoText provides a Create and CreateRemote method to          
// create instances of the default interface IText exposed by              
// the CoClass Text. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoText = class
    class function Create: IText;
    class function CreateRemote(const MachineName: string): IText;
  end;

// *********************************************************************//
// The Class CoParagraphs provides a Create and CreateRemote method to          
// create instances of the default interface IParagraphs exposed by              
// the CoClass Paragraphs. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoParagraphs = class
    class function Create: IParagraphs;
    class function CreateRemote(const MachineName: string): IParagraphs;
  end;

// *********************************************************************//
// The Class CoParagraph provides a Create and CreateRemote method to          
// create instances of the default interface IParagraph exposed by              
// the CoClass Paragraph. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoParagraph = class
    class function Create: IParagraph;
    class function CreateRemote(const MachineName: string): IParagraph;
  end;

// *********************************************************************//
// The Class CoTableCells provides a Create and CreateRemote method to          
// create instances of the default interface ITableCells exposed by              
// the CoClass TableCells. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoTableCells = class
    class function Create: ITableCells;
    class function CreateRemote(const MachineName: string): ITableCells;
  end;

// *********************************************************************//
// The Class CoTableCell provides a Create and CreateRemote method to          
// create instances of the default interface ITableCell exposed by              
// the CoClass TableCell. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoTableCell = class
    class function Create: ITableCell;
    class function CreateRemote(const MachineName: string): ITableCell;
  end;

// *********************************************************************//
// The Class CoBlocks provides a Create and CreateRemote method to          
// create instances of the default interface IBlocks exposed by              
// the CoClass Blocks. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoBlocks = class
    class function Create: IBlocks;
    class function CreateRemote(const MachineName: string): IBlocks;
  end;

// *********************************************************************//
// The Class Coblock provides a Create and CreateRemote method to          
// create instances of the default interface IBlock exposed by              
// the CoClass block. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  Coblock = class
    class function Create: IBlock;
    class function CreateRemote(const MachineName: string): IBlock;
  end;

// *********************************************************************//
// The Class CoBlackSeparators provides a Create and CreateRemote method to          
// create instances of the default interface IBlackSeparators exposed by              
// the CoClass BlackSeparators. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoBlackSeparators = class
    class function Create: IBlackSeparators;
    class function CreateRemote(const MachineName: string): IBlackSeparators;
  end;

// *********************************************************************//
// The Class CoBlackSeparator provides a Create and CreateRemote method to          
// create instances of the default interface IBlackSeparator exposed by              
// the CoClass BlackSeparator. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoBlackSeparator = class
    class function Create: IBlackSeparator;
    class function CreateRemote(const MachineName: string): IBlackSeparator;
  end;

// *********************************************************************//
// The Class CoTextBlockProperties provides a Create and CreateRemote method to          
// create instances of the default interface ITextBlockProperties exposed by              
// the CoClass TextBlockProperties. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoTextBlockProperties = class
    class function Create: ITextBlockProperties;
    class function CreateRemote(const MachineName: string): ITextBlockProperties;
  end;

// *********************************************************************//
// The Class CoBarcodeBlockProperties provides a Create and CreateRemote method to          
// create instances of the default interface IBarcodeBlockProperties exposed by              
// the CoClass BarcodeBlockProperties. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoBarcodeBlockProperties = class
    class function Create: IBarcodeBlockProperties;
    class function CreateRemote(const MachineName: string): IBarcodeBlockProperties;
  end;

// *********************************************************************//
// The Class CoTableBlockProperties provides a Create and CreateRemote method to          
// create instances of the default interface ITableBlockProperties exposed by              
// the CoClass TableBlockProperties. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoTableBlockProperties = class
    class function Create: ITableBlockProperties;
    class function CreateRemote(const MachineName: string): ITableBlockProperties;
  end;

// *********************************************************************//
// The Class CoCharParams provides a Create and CreateRemote method to          
// create instances of the default interface ICharParams exposed by              
// the CoClass CharParams. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoCharParams = class
    class function Create: ICharParams;
    class function CreateRemote(const MachineName: string): ICharParams;
  end;

implementation

uses ComObj;

class function CoApplication.Create: IApplication;
begin
  Result := CreateComObject(CLASS_Application) as IApplication;
end;

class function CoApplication.CreateRemote(const MachineName: string): IApplication;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Application) as IApplication;
end;

class function CoSettings.Create: ISettings;
begin
  Result := CreateComObject(CLASS_Settings) as ISettings;
end;

class function CoSettings.CreateRemote(const MachineName: string): ISettings;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Settings) as ISettings;
end;

class function CoBatchWindow.Create: IBatchWindow;
begin
  Result := CreateComObject(CLASS_BatchWindow) as IBatchWindow;
end;

class function CoBatchWindow.CreateRemote(const MachineName: string): IBatchWindow;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_BatchWindow) as IBatchWindow;
end;

class function CoImageWindow.Create: IImageWindow;
begin
  Result := CreateComObject(CLASS_ImageWindow) as IImageWindow;
end;

class function CoImageWindow.CreateRemote(const MachineName: string): IImageWindow;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ImageWindow) as IImageWindow;
end;

class function CoTextWindow.Create: ITextWindow;
begin
  Result := CreateComObject(CLASS_TextWindow) as ITextWindow;
end;

class function CoTextWindow.CreateRemote(const MachineName: string): ITextWindow;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_TextWindow) as ITextWindow;
end;

class function CoBatch.Create: IBatch;
begin
  Result := CreateComObject(CLASS_Batch) as IBatch;
end;

class function CoBatch.CreateRemote(const MachineName: string): IBatch;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Batch) as IBatch;
end;

class function Cotoolbar.Create: IToolbar;
begin
  Result := CreateComObject(CLASS_toolbar) as IToolbar;
end;

class function Cotoolbar.CreateRemote(const MachineName: string): IToolbar;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_toolbar) as IToolbar;
end;

class function CoBatchPage.Create: IBatchPage;
begin
  Result := CreateComObject(CLASS_BatchPage) as IBatchPage;
end;

class function CoBatchPage.CreateRemote(const MachineName: string): IBatchPage;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_BatchPage) as IBatchPage;
end;

class function CoBatchPages.Create: IBatchPages;
begin
  Result := CreateComObject(CLASS_BatchPages) as IBatchPages;
end;

class function CoBatchPages.CreateRemote(const MachineName: string): IBatchPages;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_BatchPages) as IBatchPages;
end;

class function CoBatchPagesCollection.Create: IBatchPagesCollection;
begin
  Result := CreateComObject(CLASS_BatchPagesCollection) as IBatchPagesCollection;
end;

class function CoBatchPagesCollection.CreateRemote(const MachineName: string): IBatchPagesCollection;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_BatchPagesCollection) as IBatchPagesCollection;
end;

class function CoBatchEvent.Create: IBatchEvent;
begin
  Result := CreateComObject(CLASS_BatchEvent) as IBatchEvent;
end;

class function CoBatchEvent.CreateRemote(const MachineName: string): IBatchEvent;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_BatchEvent) as IBatchEvent;
end;

class function CoBatchOptions.Create: IBatchOptions;
begin
  Result := CreateComObject(CLASS_BatchOptions) as IBatchOptions;
end;

class function CoBatchOptions.CreateRemote(const MachineName: string): IBatchOptions;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_BatchOptions) as IBatchOptions;
end;

class function CoRTFExportParams.Create: IRTFExportParams;
begin
  Result := CreateComObject(CLASS_RTFExportParams) as IRTFExportParams;
end;

class function CoRTFExportParams.CreateRemote(const MachineName: string): IRTFExportParams;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_RTFExportParams) as IRTFExportParams;
end;

class function CoTextExportParams.Create: ITextExportParams;
begin
  Result := CreateComObject(CLASS_TextExportParams) as ITextExportParams;
end;

class function CoTextExportParams.CreateRemote(const MachineName: string): ITextExportParams;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_TextExportParams) as ITextExportParams;
end;

class function CoXLExportParams.Create: IXLExportParams;
begin
  Result := CreateComObject(CLASS_XLExportParams) as IXLExportParams;
end;

class function CoXLExportParams.CreateRemote(const MachineName: string): IXLExportParams;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_XLExportParams) as IXLExportParams;
end;

class function CoDBFExportParams.Create: IDBFExportParams;
begin
  Result := CreateComObject(CLASS_DBFExportParams) as IDBFExportParams;
end;

class function CoDBFExportParams.CreateRemote(const MachineName: string): IDBFExportParams;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_DBFExportParams) as IDBFExportParams;
end;

class function CoHTMLExportParams.Create: IHTMLExportParams;
begin
  Result := CreateComObject(CLASS_HTMLExportParams) as IHTMLExportParams;
end;

class function CoHTMLExportParams.CreateRemote(const MachineName: string): IHTMLExportParams;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_HTMLExportParams) as IHTMLExportParams;
end;

class function CoPDFExportParams.Create: IPDFExportParams;
begin
  Result := CreateComObject(CLASS_PDFExportParams) as IPDFExportParams;
end;

class function CoPDFExportParams.CreateRemote(const MachineName: string): IPDFExportParams;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_PDFExportParams) as IPDFExportParams;
end;

class function CoStringsCollection.Create: IStringsCollection;
begin
  Result := CreateComObject(CLASS_StringsCollection) as IStringsCollection;
end;

class function CoStringsCollection.CreateRemote(const MachineName: string): IStringsCollection;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_StringsCollection) as IStringsCollection;
end;

class function CotextSelection.Create: ITextSelection;
begin
  Result := CreateComObject(CLASS_textSelection) as ITextSelection;
end;

class function CotextSelection.CreateRemote(const MachineName: string): ITextSelection;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_textSelection) as ITextSelection;
end;

class function CoRegion.Create: IRegion;
begin
  Result := CreateComObject(CLASS_Region) as IRegion;
end;

class function CoRegion.CreateRemote(const MachineName: string): IRegion;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Region) as IRegion;
end;

class function CoImageDocument.Create: IImageDocument;
begin
  Result := CreateComObject(CLASS_ImageDocument) as IImageDocument;
end;

class function CoImageDocument.CreateRemote(const MachineName: string): IImageDocument;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ImageDocument) as IImageDocument;
end;

class function CoImage.Create: IImage;
begin
  Result := CreateComObject(CLASS_Image) as IImage;
end;

class function CoImage.CreateRemote(const MachineName: string): IImage;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Image) as IImage;
end;

class function CoimageModification.Create: IImageModification;
begin
  Result := CreateComObject(CLASS_imageModification) as IImageModification;
end;

class function CoimageModification.CreateRemote(const MachineName: string): IImageModification;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_imageModification) as IImageModification;
end;

class function CoText.Create: IText;
begin
  Result := CreateComObject(CLASS_Text) as IText;
end;

class function CoText.CreateRemote(const MachineName: string): IText;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Text) as IText;
end;

class function CoParagraphs.Create: IParagraphs;
begin
  Result := CreateComObject(CLASS_Paragraphs) as IParagraphs;
end;

class function CoParagraphs.CreateRemote(const MachineName: string): IParagraphs;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Paragraphs) as IParagraphs;
end;

class function CoParagraph.Create: IParagraph;
begin
  Result := CreateComObject(CLASS_Paragraph) as IParagraph;
end;

class function CoParagraph.CreateRemote(const MachineName: string): IParagraph;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Paragraph) as IParagraph;
end;

class function CoTableCells.Create: ITableCells;
begin
  Result := CreateComObject(CLASS_TableCells) as ITableCells;
end;

class function CoTableCells.CreateRemote(const MachineName: string): ITableCells;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_TableCells) as ITableCells;
end;

class function CoTableCell.Create: ITableCell;
begin
  Result := CreateComObject(CLASS_TableCell) as ITableCell;
end;

class function CoTableCell.CreateRemote(const MachineName: string): ITableCell;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_TableCell) as ITableCell;
end;

class function CoBlocks.Create: IBlocks;
begin
  Result := CreateComObject(CLASS_Blocks) as IBlocks;
end;

class function CoBlocks.CreateRemote(const MachineName: string): IBlocks;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Blocks) as IBlocks;
end;

class function Coblock.Create: IBlock;
begin
  Result := CreateComObject(CLASS_block) as IBlock;
end;

class function Coblock.CreateRemote(const MachineName: string): IBlock;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_block) as IBlock;
end;

class function CoBlackSeparators.Create: IBlackSeparators;
begin
  Result := CreateComObject(CLASS_BlackSeparators) as IBlackSeparators;
end;

class function CoBlackSeparators.CreateRemote(const MachineName: string): IBlackSeparators;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_BlackSeparators) as IBlackSeparators;
end;

class function CoBlackSeparator.Create: IBlackSeparator;
begin
  Result := CreateComObject(CLASS_BlackSeparator) as IBlackSeparator;
end;

class function CoBlackSeparator.CreateRemote(const MachineName: string): IBlackSeparator;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_BlackSeparator) as IBlackSeparator;
end;

class function CoTextBlockProperties.Create: ITextBlockProperties;
begin
  Result := CreateComObject(CLASS_TextBlockProperties) as ITextBlockProperties;
end;

class function CoTextBlockProperties.CreateRemote(const MachineName: string): ITextBlockProperties;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_TextBlockProperties) as ITextBlockProperties;
end;

class function CoBarcodeBlockProperties.Create: IBarcodeBlockProperties;
begin
  Result := CreateComObject(CLASS_BarcodeBlockProperties) as IBarcodeBlockProperties;
end;

class function CoBarcodeBlockProperties.CreateRemote(const MachineName: string): IBarcodeBlockProperties;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_BarcodeBlockProperties) as IBarcodeBlockProperties;
end;

class function CoTableBlockProperties.Create: ITableBlockProperties;
begin
  Result := CreateComObject(CLASS_TableBlockProperties) as ITableBlockProperties;
end;

class function CoTableBlockProperties.CreateRemote(const MachineName: string): ITableBlockProperties;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_TableBlockProperties) as ITableBlockProperties;
end;

class function CoCharParams.Create: ICharParams;
begin
  Result := CreateComObject(CLASS_CharParams) as ICharParams;
end;

class function CoCharParams.CreateRemote(const MachineName: string): ICharParams;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_CharParams) as ICharParams;
end;

end.
