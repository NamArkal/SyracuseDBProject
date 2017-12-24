use HealthCare;
go

--- Generates patient bills ## VIEW 1 ##
CREATE VIEW PatientTotalBill AS
select BillingItems.BillId, Patients.PatFirstName + ' ' + Patients.PatLastName as PatientName, Bills.BillDate,
sum(BillingItems.Quantity*Treatment.TreatmentCost)+RoomCost as TotalCost,
Patients.AdmitStartDate, Patients.AdmitEndDate
from BillingItems, Treatment, Rooms, Patients, PatientBills, Bills
where BillingItems.ItemId= Treatment.TreatmentId and Patients.RoomId= Rooms.RoomId
and PatientBills.PatId= Patients.PatId and Bills.BillId= PatientBills.BillId and Bills.BillId= BillingItems.BillId
group by BillingItems.BillId, Rooms.RoomCost, Patients.PatFirstName, Patients.PatLastName, Bills.BillDate,
Patients.AdmitStartDate, Patients.AdmitEndDate;

select * from PatientTotalBill;

--- Moving old employees to a new table ## SP 2 ##
select * from OldEmployees;
select * from Employees;

update Employees set WorkEndDate=getdate() where EmpId=5;
update Employees set WorkEndDate=getdate() where EmpId=4;

if OBJECT_ID('##spMoveOldEmployees') is not null drop proc ##spMoveOldEmployees;
go

CREATE PROC ##spMoveOldEmployees AS
Insert into OldEmployees
	select * from Employees where WorkEndDate is not null;

begin try
	exec ##spMoveOldEmployees;
	print 'Successfully moved old employees from Employee table to OldEmployees table.';
end try
begin catch
	print ('Error occurred with message: '+ convert(varchar, error_message()));
end catch;

--- Moving old appointments to a new table ## SP 1 ##
select * from OldAppointments;
SELECT * FROM Appointments;
go

create proc spOldAppointments as
Insert into OldAppointments
	select * from Appointments where Status='Complete';
delete from Appointments where Status='Complete';

begin try
	exec spOldAppointments;
	print 'Successfully moved old appointments from Appointments table to OldAppointments table.';
end try
begin catch
	print ('Error occurred with message: '+ convert(varchar, error_message()));
end catch;
go

--- finding the total bill amount for the given period ## UDF 1 ##
CREATE FUNCTION fnBillForPeriod (@BeginDate smalldatetime, @EndDate smalldatetime)
returns table
return(select BillId, PatientName, BillDate, TotalCost, AdmitStartDate, AdmitEndDate
from PatientTotalBill where BillDate between @BeginDate and @EndDate);
go

select * from PatientTotalBill;
select * from dbo.fnBillForPeriod(getdate()-30, GETDATE()-29);
go

--- finding the diseases treated by a doctor ## View 2 ##
create view PatientDoctor as
select PatFirstName+' '+PatLastName as PatientName, IssueName, EmpFirstName+' '+EmpLastName as DoctorName,
DeptName as DepartmentName
from Patients, Issues, Employees, Departments
where Patients.IssueId= Issues.IssueId and Patients.DoctorId= Employees.EmpId and Employees.EmpDeptId= Departments.DeptId;
go

select * from PatientDoctor;
go 

--- finding the diseases treated by a doctor ## UDF 2 ##
create function fnDoctorsTreatingDisease (@DocName varchar(40))
returns table
return(select PatientName, DoctorName, IssueName
from PatientDoctor where DoctorName= @DocName);
go

select * from dbo.fnDoctorsTreatingDisease('mahika nanda');
select * from PatientDoctor;
go

--- Treatment for each Patient ## View 3 ##
create view PatientTreatment as
with IssueTreatment as (
select Issues.IssueId, IssueName, TreatmentName, TreatmentType from ProceduresDone, Issues, Treatment, TreatmentType
where Issues.IssueId= ProceduresDone.IssueId and Treatment.TreatmentId=ProceduresDone.ProcId
and Treatment.TreatmentTypeId= TreatmentType.TreatmentTypeId
union
select Issues.IssueId, IssueName, TreatmentName, TreatmentType from MedicinesIssued, Issues, Treatment, TreatmentType
where Issues.IssueId= MedicinesIssued.IssueId and Treatment.TreatmentId=MedicinesIssued.MedId
and Treatment.TreatmentTypeId= TreatmentType.TreatmentTypeId)
select PatFirstName+' '+PatLastName as PatientName, IssueName, TreatmentName, TreatmentType
from IssueTreatment, Patients where Patients.IssueId=IssueTreatment.IssueId;
go

select * from PatientTreatment;
GO

--- Patients in the same room ## View 4 ##
create view PatientsSharingRooms as
select p1.PatFirstName+' '+p1.PatLastName as PatientName, RoomFloor, RoomNumber
from Patients p1, Patients p2, Rooms
where p1.RoomId= p2.RoomId and p1.PatId <> p2.PatId and p1.RoomId=Rooms.RoomId;
go

select * from PatientsSharingRooms;
go

--- Update BillDate when bill to paid
create trigger Bills_Update on Bills after update as
update Bills set BillDate=GETDATE() where BillId in (select BillId from inserted);
go

select * from Bills;
Update Bills set Status='Paid' where BillId=1;