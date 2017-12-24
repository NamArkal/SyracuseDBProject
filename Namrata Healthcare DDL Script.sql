USE master;

/****** Object:  Database Namrata's HealthCare Database ******/
IF DB_ID('HealthCare') IS NOT NULL
	DROP DATABASE HealthCare;

CREATE DATABASE HealthCare; 
USE HealthCare;

/****** Object:  Table Employee Type ******/
CREATE TABLE EmployeeType(
	EmpTypeId int IDENTITY(1,1) NOT NULL,
	EmpType varchar(30) NOT NULL,
	CONSTRAINT PK_EmployeeType PRIMARY KEY CLUSTERED(
	EmpTypeId ASC
 )
);

CREATE NONCLUSTERED INDEX IX_EmpType ON EmployeeType(
	EmpType ASC);

/****** Object:  Table Departments ******/
CREATE TABLE Departments(
	DeptId int IDENTITY(1,1) NOT NULL,
	DeptName varchar(30) NOT NULL,
	CONSTRAINT PK_Departments PRIMARY KEY CLUSTERED(
	DeptId ASC
 )
);

CREATE NONCLUSTERED INDEX IX_DeptName ON Departments(
	DeptName ASC);

/****** Object:  Table Employees ******/
CREATE TABLE Employees(
	EmpId int IDENTITY(1,1) NOT NULL,
	EmpFirstName varchar(30) NOT NULL,
	EmpLastName varchar(30) NOT NULL,
	EmpSSN char(15) NOT NULL CONSTRAINT CHK_Employees_EmpSSN CHECK (len(EmpSSN) = 11),
	EmpAddress1 varchar(50) NOT NULL,
	EmpAddress2 varchar(50) NULL,
	EmpCity varchar(50) NOT NULL,
	EmpState char(2) NOT NULL,
	EmpZipCode varchar(20) NOT NULL CONSTRAINT CHK_Employees_EmpZipCode CHECK (len(EmpZipCode) = 5),
	EmpPhone varchar(20) NOT NULL CONSTRAINT CHK_Employees_EmpPhone CHECK (len(EmpPhone) >= 10),
	EmpDeptId int NOT NULL,
	EmpSalary decimal(10,2) NULL,
	EmpTypeID int NULL,
	WorkStartDate smalldatetime NOT NULL,
	WorkEndDate smalldatetime NULL,
 CONSTRAINT PK_Employees PRIMARY KEY CLUSTERED(
	EmpId ASC
 )
);

ALTER TABLE Employees 
ADD  CONSTRAINT DF_Employees_Salary  DEFAULT (0) FOR EmpSalary;

ALTER TABLE Employees 
ADD  CONSTRAINT DF_Employees_Type  DEFAULT (0) FOR EmpTypeID;

ALTER TABLE Employees 
WITH NOCHECK 
ADD CONSTRAINT FK_Employees_EmployeeType
FOREIGN KEY(EmpTypeId)
REFERENCES EmployeeType (EmpTypeId);

ALTER TABLE Employees CHECK CONSTRAINT FK_Employees_EmployeeType;

ALTER TABLE Employees 
WITH NOCHECK 
ADD CONSTRAINT FK_Employees_Departments
FOREIGN KEY(EmpDeptId)
REFERENCES Departments (DeptId);

ALTER TABLE Employees CHECK CONSTRAINT FK_Employees_Departments;

CREATE NONCLUSTERED INDEX IX_EmpSSN ON Employees(
	EmpSSN ASC);

/****** Object:  Table Rooms ******/
CREATE TABLE Rooms(
	RoomId int IDENTITY(1,1) NOT NULL,
	RoomFloor int NOT NULL,
	RoomNumber int NOT NULL,
	Capacity int NOT NULL,
	Occupancy int NULL,
	RoomCost decimal(7,2) NOT NULL,
	CHECK (Occupancy <= Capacity),
	CONSTRAINT PK_Rooms PRIMARY KEY CLUSTERED(
	RoomId ASC
 )
);

ALTER TABLE Rooms 
ADD  CONSTRAINT DF_Rooms_Occupancy  DEFAULT (0) FOR Occupancy;

CREATE NONCLUSTERED INDEX IX_RoomNumber ON Rooms(
	RoomNumber ASC);

/****** Object:  Table Issues ******/
CREATE TABLE Issues(
	IssueId int IDENTITY(1,1) NOT NULL,
	IssueName varchar(30) NOT NULL,
	Description varchar(50) NULL,
	CONSTRAINT PK_Issues PRIMARY KEY CLUSTERED(
	IssueId ASC
 )
);

CREATE NONCLUSTERED INDEX IX_IssueName ON Issues(
	IssueName ASC);
	
/****** Object:  Table TreatmentType ******/
CREATE TABLE TreatmentType(
	TreatmentTypeId int IDENTITY(1,1) NOT NULL,
	TreatmentType varchar(10) NOT NULL,
	CONSTRAINT PK_TreatmentType PRIMARY KEY CLUSTERED(
	TreatmentTypeId asc
	)
);

/****** Object:  Table Treatment ******/
CREATE TABLE Treatment(
	TreatmentId int IDENTITY(1,1) NOT NULL,
	TreatmentName varchar(30) NOT NULL,
	TreatmentTypeId int NOT NULL,
	TreatmentCost decimal(10,2) NOT NULL,
	CONSTRAINT PK_Treatment PRIMARY KEY CLUSTERED(
	TreatmentId ASC
 )
);

CREATE NONCLUSTERED INDEX IX_TreatmentName ON Treatment(
	TreatmentName ASC);

ALTER TABLE Treatment 
WITH NOCHECK 
ADD CONSTRAINT FK_Treatment_TreatmentType
FOREIGN KEY(TreatmentTypeId)
REFERENCES TreatmentType (TreatmentTypeId);

ALTER TABLE Treatment CHECK CONSTRAINT FK_Treatment_TreatmentType;

/****** Object:  Table MedicinesIssued ******/
CREATE TABLE MedicinesIssued(
	IssueId int NOT NULL,
	MedId int NOT NULL,
	CONSTRAINT PK_MedicinesIssued PRIMARY KEY CLUSTERED(
	MedId ASC, IssueId ASC
 )
);

ALTER TABLE MedicinesIssued 
WITH NOCHECK 
ADD CONSTRAINT FK_MedicinesIssued_Issues
FOREIGN KEY(IssueId)
REFERENCES Issues (IssueId);

ALTER TABLE MedicinesIssued CHECK CONSTRAINT FK_MedicinesIssued_Issues;

ALTER TABLE MedicinesIssued 
WITH NOCHECK 
ADD CONSTRAINT FK_MedicinesIssued_Treatment
FOREIGN KEY(MedId)
REFERENCES Treatment (treatmentId);

ALTER TABLE MedicinesIssued CHECK CONSTRAINT FK_MedicinesIssued_Treatment;

/****** Object:  Table ProceduresDone ******/
CREATE TABLE ProceduresDone(
	IssueId int NOT NULL,
	ProcId int NOT NULL,
	CONSTRAINT PK_ProceduresDone PRIMARY KEY CLUSTERED(
	ProcId ASC, IssueId ASC
 )
);

ALTER TABLE ProceduresDone 
WITH NOCHECK 
ADD CONSTRAINT FK_ProceduresDone_Issues
FOREIGN KEY(IssueId)
REFERENCES Issues (IssueId);

ALTER TABLE ProceduresDone CHECK CONSTRAINT FK_ProceduresDone_Issues;

ALTER TABLE ProceduresDone 
WITH NOCHECK 
ADD CONSTRAINT FK_ProceduresDone_Treatment
FOREIGN KEY(ProcId)
REFERENCES Treatment (treatmentId);

ALTER TABLE ProceduresDone CHECK CONSTRAINT FK_ProceduresDone_Treatment;

/****** Object:  Table Patients ******/
CREATE TABLE Patients(
	PatId int IDENTITY(1,1) NOT NULL,
	PatFirstName varchar(30) NOT NULL,
	PatLastName varchar(30) NOT NULL,
	PatSSN char(11) NOT NULL CONSTRAINT CHK_Patients_PatSSN CHECK (len(PatSSN) = 11),
	PatSex varchar(10) NOT NULL,
	PatDOB smalldatetime NOT NULL,
	PatAddress1 varchar(50) NOT NULL,
	PatAddress2 varchar(50) NULL,
	PatCity varchar(50) NOT NULL,
	PatState char(2) NOT NULL,
	PatZipCode varchar(20) NOT NULL CONSTRAINT CHK_Patients_PatZipCode CHECK (len(PatZipCode) = 5),
	PatPhone varchar(20) NOT NULL CONSTRAINT CHK_Patients_PatPhone CHECK (len(PatPhone) >= 10),
	DoctorId int NOT NULL,
	IssueId int NOT NULL,
	RoomId int NOT NULL,
	AdmitStartDate smalldatetime NOT NULL,
	AdmitEndDate smalldatetime NULL,
	CONSTRAINT PK_Patients PRIMARY KEY CLUSTERED(
	PatId ASC
 )
);

ALTER TABLE Patients 
WITH NOCHECK 
ADD CONSTRAINT FK_Patients_Employees
FOREIGN KEY(DoctorId)
REFERENCES Employees (EmpId);

ALTER TABLE Patients CHECK CONSTRAINT FK_Patients_Employees;

ALTER TABLE Patients 
WITH NOCHECK 
ADD CONSTRAINT FK_Patients_Rooms
FOREIGN KEY(RoomId)
REFERENCES Rooms (RoomId);

ALTER TABLE Patients CHECK CONSTRAINT FK_Patients_Rooms;

ALTER TABLE Patients 
WITH NOCHECK 
ADD CONSTRAINT FK_Patients_Issues
FOREIGN KEY(IssueId)
REFERENCES Issues (IssueId);

ALTER TABLE Patients CHECK CONSTRAINT FK_Patients_Issues;

CREATE NONCLUSTERED INDEX IX_PatSSN ON Patients(
	PatSSN ASC);
	
CREATE NONCLUSTERED INDEX IX_DoctorId ON Patients(
	DoctorId ASC);
	
CREATE NONCLUSTERED INDEX IX_IssueId ON Patients(
	IssueId ASC);
	
CREATE NONCLUSTERED INDEX IX_RoomId ON Patients(
	RoomId ASC);

/****** Object:  Table CoverageType ******/
CREATE TABLE CoverageType(
	CovTypeId int IDENTITY(1,1) NOT NULL,
	CovDesciption varchar(30) NOT NULL,
	CONSTRAINT PK_CoverageType PRIMARY KEY CLUSTERED(
	CovTypeId ASC
 )
);

CREATE NONCLUSTERED INDEX IX_CovDesciption ON CoverageType(
	CovDesciption ASC);

/****** Object:  Table Insurers ******/
CREATE TABLE Insurers(
	InsId int IDENTITY(1,1) NOT NULL,
	InsName varchar(30) NOT NULL,
	InsPhone varchar(20) NOT NULL CONSTRAINT CHK_Insurers_InsPhone CHECK (len(InsPhone) >= 10)
	CONSTRAINT PK_Insurers PRIMARY KEY CLUSTERED(
	InsId ASC
 )
);

CREATE NONCLUSTERED INDEX IX_InsName ON Insurers(
	InsName ASC);

/****** Object:  Table PatientInsurance ******/
CREATE TABLE PatientInsurance(
	PatInsId int IDENTITY(1,1) NOT NULL,
	PatId int NOT NULL,
	InsId int NOT NULL,
	CovTypeId int NOT NULL,
	InsuranceNumber int NOT NULL,
	InsExpiryDate smalldatetime NOT NULL,
	CONSTRAINT PK_PatientInsurance PRIMARY KEY CLUSTERED(
	PatInsId ASC
 )
);

ALTER TABLE PatientInsurance 
WITH NOCHECK 
ADD CONSTRAINT FK_PatientInsurance_Patients
FOREIGN KEY(PatId)
REFERENCES Patients (PatId);

ALTER TABLE PatientInsurance CHECK CONSTRAINT FK_PatientInsurance_Patients;

ALTER TABLE PatientInsurance 
WITH NOCHECK 
ADD CONSTRAINT FK_PatientInsurance_Insurers
FOREIGN KEY(InsId)
REFERENCES Insurers (InsId);

ALTER TABLE PatientInsurance CHECK CONSTRAINT FK_PatientInsurance_Insurers;

ALTER TABLE PatientInsurance 
WITH NOCHECK 
ADD CONSTRAINT FK_PatientInsurance_CoverageType
FOREIGN KEY(CovTypeId)
REFERENCES CoverageType (CovTypeId);

ALTER TABLE PatientInsurance CHECK CONSTRAINT FK_PatientInsurance_CoverageType;

CREATE NONCLUSTERED INDEX IX_PatId ON PatientInsurance(
	PatId ASC);
	
CREATE NONCLUSTERED INDEX IX_InsId ON PatientInsurance(
	InsId ASC);
	
CREATE NONCLUSTERED INDEX IX_CovTypeId ON PatientInsurance(
	CovTypeId ASC);
	
CREATE NONCLUSTERED INDEX IX_InsuranceNumber ON PatientInsurance(
	InsuranceNumber ASC);

/****** Object:  Table PaymentType ******/
CREATE TABLE PaymentType(
	PayTypeId int IDENTITY(1,1) NOT NULL,
	Type varchar(10) NOT NULL,
	CONSTRAINT PK_PaymentType PRIMARY KEY CLUSTERED(
	PayTypeId ASC
 )
);

CREATE NONCLUSTERED INDEX IX_Type ON PaymentType(
	Type ASC);

/****** Object:  Table BillS ******/
CREATE TABLE Bills(
	BillId int IDENTITY(1,1) NOT NULL,
	BillNumber int NOT NULL,
	PayTypeId int NOT NULL,
	BillDate smalldatetime NULL,
	Status varchar(10) NULL,
	CONSTRAINT PK_Bills PRIMARY KEY CLUSTERED(
	BillId ASC
 )
);

ALTER TABLE Bills 
ADD CONSTRAINT DF_Bills_BillDate DEFAULT (getdate()) FOR BillDate;

ALTER TABLE Bills
ADD CONSTRAINT DF_BillS_Status DEFAULT ('Unpaid') FOR Status;

ALTER TABLE Bills 
WITH NOCHECK 
ADD CONSTRAINT FK_Bills_PaymentType
FOREIGN KEY(PayTypeId)
REFERENCES PaymentType (PayTypeId);

ALTER TABLE Bills CHECK CONSTRAINT FK_Bills_PaymentType;

CREATE NONCLUSTERED INDEX IX_BillNumber ON Bills(
	BillNumber ASC);

/****** Object:  Table BillingItems *****/
CREATE TABLE BillingItems(
	BillId int NOT NULL,
	Sequence int NOT NULL,
	ItemId int NOT NULL,
	Quantity int NOT NULL,
	CONSTRAINT PK_BillingItems PRIMARY KEY CLUSTERED(
	BillId ASC, Sequence ASC
 )
);

ALTER TABLE BillingItems 
WITH NOCHECK 
ADD CONSTRAINT FK_BillingItems_Bills
FOREIGN KEY(BillId)
REFERENCES Bills (BillId);

ALTER TABLE BillingItems CHECK CONSTRAINT FK_BillingItems_Bills;

ALTER TABLE BillingItems 
WITH NOCHECK 
ADD CONSTRAINT FK_BillingItems_Treatment
FOREIGN KEY(ItemId)
REFERENCES Treatment (TreatmentId);

ALTER TABLE BillingItems CHECK CONSTRAINT FK_BillingItems_Treatment;

/****** Object:  Table PatientBills ******/
CREATE TABLE PatientBills(
	PatId int NOT NULL,
	BillId int NOT NULL,
	CONSTRAINT PK_PatientBills PRIMARY KEY CLUSTERED(
	PatId ASC, BillId ASC
 )
);

ALTER TABLE PatientBills 
WITH NOCHECK 
ADD CONSTRAINT FK_PatientBills_Patients
FOREIGN KEY(PatId)
REFERENCES Patients (PatId);

ALTER TABLE PatientBills CHECK CONSTRAINT FK_PatientBills_Patients;

ALTER TABLE PatientBills 
WITH NOCHECK 
ADD CONSTRAINT FK_PatientBills_Bills
FOREIGN KEY(BillId)
REFERENCES Bills (BillId);

ALTER TABLE PatientBills CHECK CONSTRAINT FK_PatientBills_Bills;

/****** Object:  Table AppointmentHolder ******/
CREATE TABLE AppointmentHolders(
	AptId int IDENTITY(1,1) NOT NULL,
	AptFirstName varchar(30) NOT NULL,
	AptLastName varchar(30) NOT NULL,
	AptAddress1 varchar(50) NOT NULL,
	AptAddress2 varchar(50) NULL,
	AptCity varchar(50) NOT NULL,
	AptState char(2) NOT NULL,
	AptZipCode varchar(20) NOT NULL CONSTRAINT CHK_AppointmentHolders_AptZipCode CHECK (len(AptZipCode) = 5),
	AptPhone varchar(20) NOT NULL CONSTRAINT CHK_AppointmentHolders_AptPhone CHECK (len(AptPhone) >= 10),
	CONSTRAINT PK_AppointmentHolders PRIMARY KEY CLUSTERED(
	AptId ASC
 )
);

/****** Object:  Table Appointments ******/
CREATE TABLE Appointments(
	AptId int NOT NULL,
	DocId int NOT NULL,
	StartTime smalldatetime NOT NULL,
	EndTime smalldatetime NOT NULL,
	Status varchar(20) NOT NULL,
	CONSTRAINT PK_Appointments PRIMARY KEY CLUSTERED(
	AptId ASC, DocId ASC
 )
);

ALTER TABLE Appointments 
WITH NOCHECK 
ADD CONSTRAINT FK_Appointments_AppointmentHolders
FOREIGN KEY(AptId)
REFERENCES AppointmentHolders (AptId);

ALTER TABLE Appointments CHECK CONSTRAINT FK_Appointments_AppointmentHolders;

ALTER TABLE Appointments 
WITH NOCHECK 
ADD CONSTRAINT FK_Appointments_Employees
FOREIGN KEY(DocId)
REFERENCES Employees (EmpId);

ALTER TABLE Appointments CHECK CONSTRAINT FK_Appointments_Employees;

/****** Object:  Table OldEmployees ******/
CREATE TABLE OldEmployees(
	EmpId int NOT NULL,
	EmpFirstName varchar(30) NOT NULL,
	EmpLastName varchar(30) NOT NULL,
	EmpSSN char(15) NOT NULL,
	EmpAddress1 varchar(50) NOT NULL,
	EmpAddress2 varchar(50) NULL,
	EmpCity varchar(50) NOT NULL,
	EmpState char(2) NOT NULL,
	EmpZipCode varchar(20) NOT NULL,
	EmpPhone varchar(20) NOT NULL,
	EmpDeptId int NOT NULL,
	EmpSalary decimal(10,2) NULL,
	EmpTypeID int NULL,
	WorkStartDate smalldatetime NOT NULL,
	WorkEndDate smalldatetime NULL
);

/****** Object:  Table OldAppointments ******/
CREATE TABLE OldAppointments(
	AptId int NOT NULL,
	DocId int NOT NULL,
	StartTime smalldatetime NOT NULL,
	EndTime smalldatetime NOT NULL,
	Status varchar(20) NOT NULL
);