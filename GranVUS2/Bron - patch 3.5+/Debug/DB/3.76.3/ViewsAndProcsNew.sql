Insert into KCProf (CProf_Id, CProf_Name, Print_Name, Expression, State, Line_No)
select 500, '��������', '��������', Null, 1, Null
where not Exists (select * from KCProf where CProf_Id = 500)
