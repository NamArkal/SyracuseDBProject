use HealthCare;

SET IDENTITY_INSERT EmployeeType ON;
INSERT EmployeeType (EmpTypeId, EmpType) VALUES 
(1, 'Doctor'),
(2, 'Nurse'),
(3, 'Administrator'),
(4, 'Lab Assistant'),
(5, 'Staff');
SET IDENTITY_INSERT EmployeeType OFF;

SET IDENTITY_INSERT Departments ON;
INSERT Departments (DeptId, DeptName) VALUES 
(1, 'Radiology'),
(2, 'Gastroenterology'),
(3, 'Management'),
(4, 'General Health'),
(5, 'Surgery'),
(6, 'Pediatrics');
SET IDENTITY_INSERT Departments OFF;

SET IDENTITY_INSERT Employees ON;
INSERT Employees (EmpId, EmpFirstName, EmpLastName, EmpSSN, EmpAddress1, EmpAddress2, EmpCity, EmpState, EmpZipCode, EmpPhone, EmpDeptId, EmpSalary,
	EmpTypeID, WorkStartDate, WorkEndDate) VALUES 
(1, 'Sowmya', 'Padmanabhi', '555-78-3344', '444 Westcott Street', null, 'Syracuse', 'NY', '13210','789-413-5555', 2, 222000.50, 1, getdate()-20, null),
(2, 'Aditya', 'Shankar','777-66-7676', '333 Redfield Place', null, 'Syracuse', 'NY', '13210', '888-555-9999', 3, 100000.30, 3, getdate()-10, null),
(3, 'Namrata','Arkalgud', '212-34-6767','555 Columbus Avenue', null, 'Syracuse', 'NY', '13210','315-489-7070', 4,80000.75, 2, getdate()-30, null),
(4, 'Suchita','Prabhakara', '585-79-1818','137 Ostrom Avenue', null, 'Oswego', 'NY', '13212', '212-656-9999', 6, 90000.00, 5, getdate()-25, null),
(5, 'Mahika', 'Nanda', '553-71-2344', '333 Roosevelt Street', null, 'Syracuse', 'NY', '13210','756-313-5995', 5, 552000.50, 1, getdate()-15, null),
(6, 'Aditya', 'Bairy', '563-91-2300', '333 Roosevelt Street', null, 'Syracuse', 'NY', '13210','716-323-6695', 6, 552000.50, 1, getdate()-5, null);
SET IDENTITY_INSERT Employees OFF;

SET IDENTITY_INSERT Rooms ON;
INSERT Rooms (RoomId, RoomFloor, RoomNumber, Capacity, Occupancy, RoomCost) VALUES
(1, 1, 1, 3, 3, 222.2),
(2, 1, 2, 5, 0, 333.3),
(3, 2, 1, 4, 1, 444.44);
SET IDENTITY_INSERT Rooms OFF;

SET IDENTITY_INSERT Issues ON;
INSERT Issues (IssueId, IssueName, Description) VALUES
(1, 'Gall Bladder Stones', 'Severe stomach pain, nausea, may cause cancer'),
(2, 'Liver Cirrhosis', 'Damage leading to scarring and liver failure'),
(3, 'Measles', 'Infection to kids, preventable by vaccine'),
(4, 'Osteoarthritis', 'Flexible tissue at the end of bones degenerates');
SET IDENTITY_INSERT Issues OFF;

SET IDENTITY_INSERT TreatmentType ON;
INSERT TreatmentType (TreatmentTypeId, TreatmentType) VALUES
(1, 'Procedure'),
(2, 'Medicine');
SET IDENTITY_INSERT TreatmentType OFF;

SET IDENTITY_INSERT Treatment ON;
INSERT Treatment (TreatmentId, TreatmentName, TreatmentTypeId, TreatmentCost) VALUES
(1, 'Cholecystectomy', 1, 4400),
(2, 'Liver Transplant', 1, 5999.99),
(3, 'Anthroscopy', 1, 2000),
(4, 'Joint Replacement', 1, 6000),
(5, 'Ibuprofen', 2, 20),
(6, 'Capsaicin', 2, 40),
(7, 'Tramadol', 2, 35.66),
(8, 'Acetaminophen', 2, 22.98),
(9, 'Furosemide', 2, 4.44),
(10,'Lactulose', 2, 20.12),
(11, 'Cefotaxime', 2, 34.00),
(12, 'Lamivudine', 2, 24.67),
(13, 'Ursodiol', 2, 12.59);
SET IDENTITY_INSERT Treatment OFF;

INSERT MedicinesIssued (IssueId, MedId) VALUES
(1, 13),
(2, 9),
(2, 10),
(2, 11),
(2, 12),
(3, 8),
(4, 5),
(4, 6),
(4, 7);

INSERT ProceduresDone (IssueId, ProcId) VALUES
(1, 1),
(2, 2),
(4, 3),
(4, 4);

SET IDENTITY_INSERT Patients ON;
INSERT Patients (PatId, PatFirstName, PatLastName, PatSSN, PatSex, PatDOB, PatAddress1, PatAddress2, PatCity, PatState, PatZipCode, PatPhone, DoctorId,
	IssueId, RoomId, AdmitStartDate, AdmitEndDate) VALUES 
(1, 'Sahana', 'Narayan', '554-08-2244', 'Female', '1993-12-03 21:27:56.177','449 Westcott Street', null, 'Syracuse', 'NY', '13210','734-414-5533', 5, 4, 1, getdate()-2, null),
(2, 'Sahana', 'Sreenivas','771-65-8876', 'Female', '2017-11-18 21:27:56.177', '337 Redfield Place', null, 'Syracuse', 'NY', '13210', '800-775-1199', 1, 2, 1, getdate()-3, null),
(3, 'Aishwar','Ram', '214-31-6799', 'Male', '2014-02-03 21:27:56.177', '556 Columbus Avenue', null, 'Syracuse', 'NY', '13210','665-785-7330', 6, 3, 3, getdate()-1, null),
(4, 'Karun','Krishna', '595-69-3118', 'Male', '2000-08-28 21:27:56.177', '237 Ostrom Avenue', null, 'Oswego', 'NY', '13212', '200-666-9779', 1, 1, 1, getdate(), null);
SET IDENTITY_INSERT Patients OFF;

SET IDENTITY_INSERT CoverageType ON;
INSERT CoverageType (CovTypeId, CovDesciption) VALUES
(1, 'Full'),
(2, '75%'),
(3, '50%');
SET IDENTITY_INSERT CoverageType OFF;

SET IDENTITY_INSERT Insurers ON;
INSERT Insurers (InsId, InsName, InsPhone) VALUES
(1, 'Live Long Insurance Co.', '282-111-9898'),
(2, 'Healthy Life Insurers', '516-777-8888'),
(3, 'Care Free Living', '424-456-5757');
SET IDENTITY_INSERT Insurers OFF;

SET IDENTITY_INSERT PatientInsurance ON;
INSERT PatientInsurance (PatInsId, PatId, InsId, CovTypeId, InsuranceNumber, InsExpiryDate) VALUES
(1, 1, 1, 1, 545454, getdate()+365),
(2, 2, 1, 2, 777888, getdate()+366),
(3, 3, 2, 2, 123123, getdate()+730),
(4, 4, 3, 3, 098098, getdate()+731);
SET IDENTITY_INSERT PatientInsurance OFF;

SET IDENTITY_INSERT PaymentType ON;
INSERT PaymentType (PayTypeId, Type) VALUES
(1, 'Self'),
(2, 'Insurance'),
(4, 'Mixed');
SET IDENTITY_INSERT PaymentType OFF;

SET IDENTITY_INSERT Bills ON;
INSERT Bills (BillId, BillNumber, PayTypeId, BillDate, Status) VALUES
(1, 4343, 1, getdate(), 'Unpaid'),
(2, 2222, 2, getdate(), 'Unpaid'),
(3, 5775, 4, getdate(), 'InProgress'),
(4, 2665, 4, getdate(), 'Inprogress');
SET IDENTITY_INSERT Bills OFF;

INSERT BillingItems (BillId, Sequence, ItemId, Quantity) VALUES
(1, 1, 3, 1),
(1, 2, 4, 1),
(1, 3, 5, 1),
(1, 4, 6, 2),
(1, 5, 7, 1),
(2, 1, 9, 2),
(2, 2, 2, 1),
(2, 3, 10, 1),
(3, 1, 8, 3),
(4, 1, 13, 2),
(4, 2, 1, 1);

INSERT PatientBills (PatId, BillId) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4);

SET IDENTITY_INSERT AppointmentHolders ON;
INSERT AppointmentHolders (AptId, AptFirstName, AptLastName, AptAddress1, AptAddress2, AptCity, AptState, AptZipCode, AptPhone) VALUES 
(1, 'Saurabh', 'Bashirabad', '234 Westcott Street', null, 'Syracuse', 'NY', '13210','799-432-5855'),
(2, 'Pavan', 'Negi', '345 Redfield Place', null, 'Syracuse', 'NY', '13210', '800-321-9191'),
(3, 'Sam','Babu', '567 Columbus Avenue', null, 'Syracuse', 'NY', '13210','355-210-7070');
SET IDENTITY_INSERT AppointmentHolders OFF;

INSERT Appointments (AptId, DocId, StartTime, EndTime, Status) VALUES
(1, 1, getdate(), getdate(), 'Cancelled'),
(2, 5, getdate(), getdate(), 'Complete'),
(3, 5, getdate(), getdate(), 'Taken');