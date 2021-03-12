alter table PERSON Alter Comments Memo

alter table PERSON Add Warfare Text(255)

Insert Into KL_FLDGROUPS (Group_Id, Group_Name) Values (10, "Академический отпуск")

alter table PersonChanges Add OutNumber Text(255), OutDate Datetime

alter table KPOST Alter POST_NAME Text(255)

alter table KPOST Add KPost_Num Integer

Update KPOST set KPOST_Num = Post_Id

alter table KL_DATA Add HandSort Text(50)

Update KL_DATA set HandSort = "KPOST_Num" Where KL_NAME = "KPOST"

alter table KDEPART Add KDEPART_Num Integer

Update KDEPART set KDEPART_Num = Dep_Id

Update KL_DATA set HandSort = "KDEPART_Num" Where KL_NAME = "KDEPART"

alter table KOVK Alter OVK_Phone Text(250)

alter table KL_Data Alter Disp_Name Text(150)

update KL_Data set Disp_Name = "Отделы военных комиссариатов (администрации районов)" where KL_Id = 1

update KL_Fld set Disp_Name = "Переменная часть наименования органа, ведущего первичный воинский учет 'Отдел военного комиссариата ...' или 'Администрация ...'" where KL_Id = 1 and Fld_Name = "OVK_NAME"

update KL_Fld set Disp_Size = 200, Disp_Name = "Дополнительная информация" where KL_Id = 1 and Fld_Name = "OVK_PHONE"

update KL_Fld set Disp_Size = 200, Disp_Name = "Первичный воинский учет ведет ОВК (не отмечено - учет ведет Администрация)" where KL_Id = 1 and Fld_Name = "ISOVK"
