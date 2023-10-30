USE master;
GO
IF DB_ID (N'Vinculation') IS NOT NULL
 DROP DATABASE Vinculation;
GO
CREATE DATABASE	Vinculation
ON
(NAME = Vinculation_dat,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Vinculation.mdf', 
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5 )
LOG ON
(NAME =Vinculation_log,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Vinculation.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB )
GO
USE Vinculation;

GO	

CREATE TABLE [User]
(   
	 idUser int IDENTITY (1,1),
	 [name] varchar(50) NOT NULL,
	 [password] varchar(50) NOT NULL,
	 email  varchar(50) NOT NULL,
	 [status] bit NOT NULL DEFAULT 1,
	 CONSTRAINT PK_User PRIMARY KEY (idUser)
);

CREATE TABLE Career (
idCareer int IDENTITY(1,1),
[name] varchar(50) NOT NULL,
duration varchar(20) NOT NULL,
[description] varchar(20) NOT NULL,
[status] bit NOT NULL DEFAULT 1, 
idUserCreate int NULL,
dateCreate date NULL,
idUserModified int NULL,
dateModified date NULL
CONSTRAINT PK_Career Primary KEY(idCareer)
);

CREATE TABLE ActivityType (
idActivityType int IDENTITY(1,1),
[description] varchar(100) NOT NULL,
activityname varchar(100) NOT NULL,
[status] bit NOT NULL DEFAULT 1, 
idUserCreate int NULL,
dateCreate date NULL,
idUserModified int NULL,
dateModified date NULL
CONSTRAINT PK_ActivityType Primary KEY(idActivityType)
);

CREATE TABLE EvaluationDetail (
idEvaluationDetail int IDENTITY(1,1),
assessment varchar(50) NOT NULL,
criterion varchar(100) NOT NULL,
[status] bit NOT NULL DEFAULT 1, 
idUserCreate int NULL,
dateCreate date NULL,
idUserModified int NULL,
dateModified date NULL
CONSTRAINT PK_EvaluationDetail Primary KEY(idEvaluationDetail)
);
CREATE TABLE ActivityDetail (
idActivityDetail int IDENTITY(1,1),
activitydetailsdescription varchar(100) NOT NULL,
idEvaluationDetail int NULL,
idComplementaryActivity int NULL,
[status] bit NOT NULL DEFAULT 1, 
idUserCreate int NULL,
dateCreate date NULL,
idUserModified int NULL,
dateModified date NULL
CONSTRAINT PK_ActivityDetail Primary KEY(idActivityDetail)
);

CREATE TABLE Objective (    
 idObjective int IDENTITY (1,1), 
 objetivename varchar(50) NOT NULL, 
 status bit NOT NULL DEFAULT 1, 
 idUserCreate int NULL,
 dateCreate date NULL,
 idUserModified int NULL,
 dateModified date NULL
 CONSTRAINT PK_Objective PRIMARY KEY (idObjective)
); 

CREATE TABLE TypePosition (    
 idTypePosition int IDENTITY (1,1), 
 [level] varchar(50) NOT NULL, 
  typepositionname varchar(50) NOT NULL,  
 [status] bit NOT NULL DEFAULT 1, 
idUserCreate int NULL,
dateCreate date NULL,
idUserModified int NULL,
dateModified date NULL
 CONSTRAINT PK_TypePosition PRIMARY KEY (idTypePosition) 
); 

CREATE TABLE Proof(
idProof int IDENTITY (1,1), 
[date] date NOT NULL,
reason varchar(50) NOT NULL, 
[status] bit NOT NULL DEFAULT 1, 
idUserCreate int NULL,
dateCreate date NULL,
idUserModified int NULL,
dateModified date NULL
  CONSTRAINT PK_Proof PRIMARY KEY (idProof)
); 

CREATE TABLE Purpose
(   
	 idPurpose int IDENTITY (1,1),
	investigation varchar(50) NOT NULL,
	purposename varchar(50) NOT NULL,
	 [status] bit NOT NULL DEFAULT 1,
	 idUserCreate int NULL,
    dateCreate date NULL,
    idUserModified int NULL,
     dateModified date NULL
	 CONSTRAINT PK_Purpose PRIMARY KEY (idPurpose)
);
CREATE TABLE Sector 
(  
idSector int IDENTITY (1,1), 
sectorname varchar(30) NOT NULL, 
[status] bit NOT NULL DEFAULT 1, 
idUserCreate int NULL,
dateCreate date NULL,
idUserModified int NULL,
dateModified date NULL
CONSTRAINT PK_Sector PRIMARY KEY (idSector) 
); 
CREATE TABLE [Subject]
(   
	 idSubject int IDENTITY (1,1),
	 [name] varchar(50) NOT NULL,
	 credit varchar(30) NOT NULL,
	 unit varchar(50) NOT NULL,
	 characteristic varchar(50) NOT NULL,
	 keyMatter varchar(50) NOT NULL,
	 [status] bit NOT NULL DEFAULT 1,
	 idUserCreate int NULL,
     dateCreate date NULL,
     idUserModified int NULL,
     dateModified date NULL
	 CONSTRAINT PK_Subject PRIMARY KEY (idSubject)
);
CREATE TABLE Territory
(   
	 idTerritory int IDENTITY (1,1),
	 territoryname varchar(50) NOT NULL,
	 [status] bit NOT NULL DEFAULT 1,
	 idUserCreate int NULL,
     dateCreate date NULL,
     idUserModified int NULL,
     dateModified date NULL
	 CONSTRAINT PK_Territory PRIMARY KEY (idTerritory)
);

CREATE TABLE [Zone] (
idZone int IDENTITY (1,1) ,
zonename varchar(30)NOT NULL, 
[status] bit NOT NULL DEFAULT 1, 
idUsercreate int NULL, 
datecreate date NULL, 
idusermodified int NULL, 
datemodified date NULL 
CONSTRAINT PK_Zone Primary KEY(idZone) 
);
--------------------------------------
CREATE TABLE Company (
idCompany int IDENTITY(1,1),
[name] varchar(50) NOT NULL,
email varchar(50) NOT NULL,
phone char(10) NOT NULL,
[address] varchar(50) NOT NULL,
identificationNumber varchar(50) NOT NULL,
idSector int NOT NULL,---Sector
[status] bit NOT NULL DEFAULT 1,
idUserCreate int NULL,
dateCreate date NULL,
idUserModified int NULL,
dateModified date NULL
CONSTRAINT PK_Company Primary KEY(idCompany)
);

CREATE TABLE Employee (
idEmployee int IDENTITY(1,1),
[name] varchar(50) NOT NULL,
lastname varchar (50) NOT NULL,
[mother'sLastName] varchar(50)NOT NULL,
gender varchar(50) NOT NULL,
phone char(10) NOT NULL,
email varchar(50) NOT NULL,
[address] varchar(100)NOT NULL, 
socialSecurity char(11)NOT NULL,
dateOfHire date NOT NULL,
idSubject int NOT NULL,
[status] bit NOT NULL DEFAULT 1,
idUserCreate int NULL,
dateCreate date NULL,
idUserModified int NULL,
dateModified date NULL
CONSTRAINT PK_Employee Primary KEY(idEmployee)
);



 CREATE TABLE Student
(   
	 idStudent int IDENTITY (1,1),
	 [name] varchar(50) NOT NULL,
	 lastName varchar(50) NOT NULL,
	 mothersthestName varchar(50) NOT NULL,
	 enrollment varchar(50) NOT NULL,
	 birthdate date NOT NULL,
	 curp char (18 )NOT NULL,
	 phone char (10 )NOT NULL,
	 rfc char (13 )NOT NULL,
	 socialSegurity char (11) NOT NULL,
	 [status] bit NOT NULL DEFAULT 1,
	 IdUserCreate int null,
	 creationdate date NULL,
	 IdUserModify int null,
	 modified date null
	 CONSTRAINT PK_Student PRIMARY KEY (idStudent)
);

Create table Visit 
(
idVisit int IDENTITY (1,1) ,
numberofstudent int NOT NULL, 
duration varchar(50) NOT NULL, 
objetive varchar(100)NOT NULL ,
aplicacion date NOT NULL, 
datevisit date NOT NULL,
requiretransportation varchar(10) NOT NULL ,
result varchar(150)NOT NULL ,
idCompany int NOT NULL ,
idZone int NOT NULL,
idEmployee int NOT NULL,
idStudent int NOT NULL,
status bit NOT NULL DEFAULT 1 ,
idUsercreate int NOT NULL ,
datecreate date NOT NULL,
idusermodified int NOT NULL ,
datemodified date NOT NULL ,
CONSTRAINT PK_Visit Primary KEY(idVisit) 
);


 CREATE TABLE ComplementaryActivity 
(    
 idComplementaryActivity int IDENTITY (1,1), 
 activityname varchar(50) NOT NULL, 
 [status] bit NOT NULL DEFAULT 1, 
 idStudent int NOT NULL, 
 idActivityType int NOT NULL,--student-------------
 idusercreate int NULL, 
 datecreate date NULL, 
 idusermodified int NULL, 
 datemodified date NULL 
 CONSTRAINT PK_ComplementaryActivity PRIMARY KEY (idComplementaryActivity) 
 );

 CREATE TABLE Agreement (
idAgreement int IDENTITY  (1,1),
acronym varchar(50) NOT NULL,
objetive varchar(25)NOT NULL,
idObjetive int NOT NULL,---Objetive
idTerritory int NOT NULL,---Territory
statusAgreement varchar(50) NOT NULL,
[status] bit NOT NULL DEFAULT 1,
idUserCreate int NULL,
dateCreate date NULL,
idUserModified int NULL,
dateModified date NULL
CONSTRAINT PK_Agreement Primary KEY(idAgreement)
);

CREATE TABLE Empreneur(
idEmpreneur int IDENTITY(1,1),
request varchar(50) NOT NULL,
objetive varchar(50) NOT NULL,
codeOfEmpreneur varchar(50) NOT NULL,
workteam varchar(50)NOT NULL,
startdate date NOT NULL,
finaldate date NOT NULL,
duration varchar(50) NOT NULL,
idEmployee int NOT NULL,
idStudent int NOT NULL,
[status] bit NOT NULL DEFAULT 1, 
idUserCreate int NULL,
dateCreate date NULL,
idUserModified int NULL,
dateModified date NULL
CONSTRAINT PK_Empreneur Primary KEY(idEmpreneur)
);


CREATE TABLE Viatic
(    
	 idViatic int IDENTITY (1,1),
	 place varchar(200) NOT NULL,
	 description1 varchar(250) NOT NULL,
	 amount decimal (10,2) NOT NULL,
	 idEmployee int NOT NULL,
	 [status] bit NOT NULL DEFAULT 1,
	 IdUserCreate int null,
	 creationdate date NULL,
	 IdUserModify int null,
	 modified date null
	 CONSTRAINT PK_Viatic PRIMARY KEY (idViatic)
);


CREATE TABLE CompanyStudent (
IdCompanyStudent int IDENTITY(1,1),
[date] Date NULL,
workplace varchar(50) NOT NULL,
idStudent int NOT NULL,
[status] bit NOT NULL DEFAULT 1,
idUserCreate int NULL,
dateCreate date NULL,
idUserModified int NULL,
dateModified date NULL
CONSTRAINT PK_CompanyStudent Primary KEY(idCompanyStudent)
);



CREATE TABLE OfficeRequestcommission 
(    
 idOfficeRequestcommission int IDENTITY (1,1), 
 addressee varchar(50) NOT NULL, 
 header varchar(50) NOT NULL, 
 afftair varchar(150) NOT NULL, 
 date1 date NOT NULL, 
 [status] bit NOT NULL DEFAULT 1, 
 idEmploye int NOT NULL, 
 IdUserCreate int null, 
 creationdate date NULL, 
 IdUserModify int null, 
 modified date null 
 CONSTRAINT PK_OfficeRequestcommission PRIMARY KEY (idOfficeRequestcommission) 
); 

CREATE TABLE Position 
(    
 idPosition int IDENTITY (1,1), 
 jobDescription varchar(50) NOT NULL, 
 wage varchar(50) NOT NULL, 
 workingHours varchar(50) NOT NULL, 
 [status] bit NOT NULL DEFAULT 1, 
 idTypePosition int NOT NULL, 
 IdUserCreate int null, 
 creationdate date NULL, 
 IdUserModify int null, 
 modified date null 
 CONSTRAINT PK_Position PRIMARY KEY (idPosition) 
); 
 CREATE TABLE StudyPlan 
(    
   idStudyPlan int IDENTITY (1,1), 
   objetive varchar(50) NOT NULL, 
   starDate date NOT NULL, 
   finalDate date NOT NULL, 
   key1 varchar(50) NOT NULL, 
   [status] bit NOT NULL DEFAULT 1, 
   idCareer int NOT NUll, 
   IdUserCreate int NULL, 
   creationdate date NULL, 
   IdUserModify int NULL, 
   modified date NULL 
   CONSTRAINT PK_StudyPlan PRIMARY KEY (idStudyPlan) 
); 


CREATE TABLE ComplementaryActivityCompany 
(
idComplementaryActivityCompany int IDENTITY (1,1),
idComplementaryActivity int NOT NULL,
IdCompany int NOT NULL,
[status] bit NOT NULL DEFAULT 1,
idUsercreate int NULL,
datecreate date NULL,
idusermodified int NULL, 
datemodified date NULL
CONSTRAINT PK_ComplementaryActivityCompany Primary KEY(idComplementaryActivityCompany) 
);

CREATE TABLE AgreementCompany 
(
idAgreementCompany int IDENTITY (1,1),
idAgreement int NOT NULL, 
IdCompany int NOT NULL,
[status] bit NOT NULL DEFAULT 1,
idUsercreate int NULL, 
datecreate date NULL, 
idusermodified int NULL, 
datemodified date NULL 
CONSTRAINT PK_AgreementCompany Primary KEY(idAgreementCompany) 
);

CREATE TABLE AgreementPurpose
(
idAgreementPurpose int IDENTITY (1,1),
idAgreement int NOT NULL, 
IdPurpose int NOT NULL,
[status] bit NOT NULL DEFAULT 1,
idUsercreate int NULL, 
datecreate date NULL, 
idusermodified int NULL, 
datemodified date NULL 
CONSTRAINT PK_AgreementPurpose Primary KEY(idAgreementPurpose) 
);

CREATE TABLE EmployeePosition 
(    
idEmployeePosition int IDENTITY (1,1), 
IdEmployee int NOT NULL, 
IdPosition int NOT NULL, 
[status] bit NOT NULL DEFAULT 1, 
idusercreate int NULL, 
datecreate date NULL, 
idusermodified int NULL, 
datemodified date NULL 
CONSTRAINT PK_EmployeePosition PRIMARY KEY (idEmployeePosition) 
); 

CREATE TABLE SubjectStudyPlan 
(    
idSubjectStudyPlan int IDENTITY (1,1), 
IdSubject int NOT NULL, 
IdStudyPlan int NOT NULL, 
[status] bit NOT NULL DEFAULT 1, 
idusercreate int NULL, 
datecreate date NULL, 
idusermodified int NULL, 
datemodified date NULL 
CONSTRAINT PK_SubjectStudyPlan PRIMARY KEY (idSubjectStudyPlan) 
);


---------------------Index----------------
CREATE INDEX IX_ActivityDetail ON ActivityDetail(idActivityDetail)
CREATE INDEX IX_ActivityType ON ActivityType(idActivityType)
CREATE INDEX IX_Agreement ON Agreement(idAgreement)
CREATE INDEX IX_ComplementaryActivity ON ComplementaryActivity(idComplementaryActivity)
CREATE INDEX IX_Career ON Career(idCareer)
CREATE INDEX IX_Company ON Company(idCompany)
CREATE INDEX IX_CompanyStudent ON CompanyStudent(idCompanyStudent)
CREATE INDEX IX_Employee ON Employee(idEmployee)
CREATE INDEX IX_Entrepreneur ON Empreneur(idEmpreneur)
CREATE INDEX IX_EvaluationDetail ON EvaluationDetail(idEvaluationDetail )
CREATE INDEX IX_Objective ON Objective(idObjective)
CREATE INDEX IX_OfficeRequestcommission ON OfficeRequestcommission(idOfficeRequestcommission)
CREATE INDEX IX_Position ON Position(idPosition)
CREATE INDEX IX_TypePosition ON TypePosition(idTypePosition)
CREATE INDEX IX_Proof ON Proof (idProof)
CREATE INDEX IX_Purpose ON Purpose(idPurpose)
CREATE INDEX IX_Sector ON Sector(idSector)
CREATE INDEX IX_Student ON Student  (idStudent )
CREATE INDEX IX_StudyPlan ON StudyPlan(idStudyPlan)
CREATE INDEX IX_Subject ON Subject(idSubject)
CREATE INDEX IX_Territory ON Territory(idTerritory)
CREATE INDEX IX_User ON [User](idUser)
CREATE INDEX IX_Viatic ON Viatic(idViatic)
CREATE INDEX IX_Visit ON Visit(idVisit)
CREATE INDEX IX_Zone ON Zone (idZone)
CREATE INDEX IX_ComplementaryActivityCompany ON ComplementaryActivityCompany(idComplementaryActivityCompany)
CREATE INDEX IX_AgreementCompany ON AgreementCompany(idAgreementCompany)
CREATE INDEX IX_AgreementPurpose ON AgreementPurpose(idAgreementPurpose)
CREATE INDEX IX_EmployePosition ON EmployeePosition(idEmployeePosition)
CREATE INDEX IX_SubjectStudyPlan ON SubjectStudyPlan(idSubjectStudyPlan)

-------------------Alter Table----------------------------

ALTER TABLE Career
ADD CONSTRAINT FK_UserCreateCareer FOREIGN KEY (idUserCreate)
REFERENCES [User](idUser)

ALTER TABLE Career
ADD CONSTRAINT FK_UserModifiedCareer FOREIGN KEY (idUserModified)
REFERENCES [User](idUser)
------
ALTER TABLE ActivityType
ADD CONSTRAINT FK_UserCreateActivityType FOREIGN KEY (idUserCreate)
REFERENCES [User](idUser)

ALTER TABLE ActivityType
ADD CONSTRAINT FK_UserModifiedActivityType FOREIGN KEY (idUserModified)
REFERENCES [User](idUser)

ALTER TABLE EvaluationDetail 
ADD CONSTRAINT FK_UserCreateEvaluationDetail FOREIGN KEY (idUserCreate)
REFERENCES [User](idUser)

ALTER TABLE EvaluationDetail
ADD CONSTRAINT FK_UserModifiedEvaluationDetail FOREIGN KEY (idUserModified)
REFERENCES [User](idUser)

ALTER TABLE ActivityDetail 
ADD CONSTRAINT FK_UserCreateActivityDetail FOREIGN KEY (idUserCreate)
REFERENCES [User](idUser)

ALTER TABLE ActivityDetail
ADD CONSTRAINT FK_UserModifiedActivityDetail FOREIGN KEY (idUserModified)
REFERENCES [User](idUser)

ALTER TABLE Objective
ADD CONSTRAINT FK_UserCreateObjective FOREIGN KEY (idUserCreate)
REFERENCES [User](idUser)

ALTER TABLE Objective
ADD CONSTRAINT FK_UserModifiedObjective FOREIGN KEY (idUserModified)
REFERENCES [User](idUser)

ALTER TABLE TypePosition
ADD CONSTRAINT FK_UserCreateTypePosition FOREIGN KEY (idUserCreate)
REFERENCES [User](idUser)

ALTER TABLE TypePosition
ADD CONSTRAINT FK_UserModifiedTypePosition FOREIGN KEY (idUserModified)
REFERENCES [User](idUser)

ALTER TABLE ComplementaryActivity
ADD CONSTRAINT FK_UserCreateComplementaryActivity FOREIGN KEY (idUserCreate)
REFERENCES [User](idUser)

ALTER TABLE ComplementaryActivity
ADD CONSTRAINT FK_UserModifiedComplementaryActivity FOREIGN KEY (idUserModified)
REFERENCES [User](idUser)

ALTER TABLE Student
ADD CONSTRAINT FK_UserCreateStudent FOREIGN KEY (idUserCreate)
REFERENCES [User](idUser)

ALTER TABLE Student
ADD CONSTRAINT FK_UserModifiedStudent FOREIGN KEY (idUserModify)
REFERENCES [User](idUser)

ALTER TABLE Agreement
ADD CONSTRAINT FK_UserCreateAgreement FOREIGN KEY (idUserCreate)
REFERENCES [User](idUser)

ALTER TABLE Agreement
ADD CONSTRAINT FK_UserModifiedAgreement FOREIGN KEY (idUserModified)
REFERENCES [User](idUser)

ALTER TABLE Employee
ADD CONSTRAINT FK_UserCreateEmployee FOREIGN KEY (idUserCreate)
REFERENCES [User](idUser)

ALTER TABLE Employee
ADD CONSTRAINT FK_UserModifiedEmployee FOREIGN KEY (idUserModified)
REFERENCES [User](idUser)

ALTER TABLE Empreneur
ADD CONSTRAINT FK_UserCreateEmpreneur FOREIGN KEY (idUserCreate)
REFERENCES [User](idUser)

ALTER TABLE Empreneur
ADD CONSTRAINT FK_UserModifiedEmpreneur FOREIGN KEY (idUserModified)
REFERENCES [User](idUser)

ALTER TABLE Company
ADD CONSTRAINT FK_UserCreateCompany FOREIGN KEY (idUserCreate)
REFERENCES [User](idUser)

ALTER TABLE Company
ADD CONSTRAINT FK_UserModifiedCompany FOREIGN KEY (idUserModified)
REFERENCES [User](idUser)

ALTER TABLE CompanyStudent
ADD CONSTRAINT FK_UserCreateCompanyStudent FOREIGN KEY (idUserCreate)
REFERENCES [User](idUser)

ALTER TABLE CompanyStudent
ADD CONSTRAINT FK_UserModifiedCompanyStudent FOREIGN KEY (idUserModified)
REFERENCES [User](idUser)

ALTER TABLE Proof
ADD CONSTRAINT FK_UserCreateProof FOREIGN KEY (idUserCreate)
REFERENCES [User](idUser)

ALTER TABLE Proof
ADD CONSTRAINT FK_UserModifiedProof FOREIGN KEY (idUserModified)
REFERENCES [User](idUser)

ALTER TABLE [Subject]
ADD CONSTRAINT FK_UserCreateSubject FOREIGN KEY (idUserCreate)
REFERENCES [User](idUser)

ALTER TABLE [Subject]
ADD CONSTRAINT FK_UserModifiedSubject FOREIGN KEY (idUserModified)
REFERENCES [User](idUser)

ALTER TABLE OfficeRequestcommission
ADD CONSTRAINT FK_UserCreateOfficeRequestcommission FOREIGN KEY (idUserCreate)
REFERENCES [User](idUser)

ALTER TABLE OfficeRequestcommission
ADD CONSTRAINT FK_UserModifiedOfficeRequestcommission FOREIGN KEY (idUserModify)
REFERENCES [User](idUser)

ALTER TABLE StudyPlan
ADD CONSTRAINT FK_UserCreateStudyPlan FOREIGN KEY (idUserCreate)
REFERENCES [User](idUser)

ALTER TABLE StudyPlan
ADD CONSTRAINT FK_UserModifiedStudyPlan FOREIGN KEY (idUserModify)
REFERENCES [User](idUser)

ALTER TABLE Purpose
ADD CONSTRAINT FK_UserCreatePurpose FOREIGN KEY (idUserCreate)
REFERENCES [User](idUser)

ALTER TABLE Purpose
ADD CONSTRAINT FK_UserModifiedPurpose FOREIGN KEY (idUserModified)
REFERENCES [User](idUser)

ALTER TABLE Position
ADD CONSTRAINT FK_UserCreatePosition FOREIGN KEY (idUserCreate)
REFERENCES [User](idUser)

ALTER TABLE Position
ADD CONSTRAINT FK_UserModifiedPosition FOREIGN KEY (idUserModify)
REFERENCES [User](idUser)

ALTER TABLE Sector
ADD CONSTRAINT FK_UserCreateSector FOREIGN KEY (idUserCreate)
REFERENCES [User](idUser)

ALTER TABLE Sector
ADD CONSTRAINT FK_UserModifiedSector FOREIGN KEY (idUserModified)
REFERENCES [User](idUser)

ALTER TABLE Territory
ADD CONSTRAINT FK_UserCreateTerritory FOREIGN KEY (idUserCreate)
REFERENCES [User](idUser)

ALTER TABLE Territory
ADD CONSTRAINT FK_UserModifiedTerritory FOREIGN KEY (idUserModified)
REFERENCES [User](idUser)

ALTER TABLE Viatic
ADD CONSTRAINT FK_UserCreateViatic FOREIGN KEY (idUserCreate)
REFERENCES [User](idUser)

ALTER TABLE Viatic
ADD CONSTRAINT FK_UserModifiedViatic FOREIGN KEY (idUserModify)
REFERENCES [User](idUser)

ALTER TABLE Visit
ADD CONSTRAINT FK_UserCreateVisit FOREIGN KEY (idUserCreate)
REFERENCES [User](idUser)

ALTER TABLE Visit
ADD CONSTRAINT FK_UserModifiedVisit FOREIGN KEY (idUserModified)
REFERENCES [User](idUser)

ALTER TABLE [Zone]
ADD CONSTRAINT FK_UserCreateZone FOREIGN KEY (idUserCreate)
REFERENCES [User](idUser)

ALTER TABLE [Zone]
ADD CONSTRAINT FK_UserModifiedZone FOREIGN KEY (idUserModified)
REFERENCES [User](idUser)

ALTER TABLE ComplementaryActivityCompany
ADD CONSTRAINT FK_UserCreateComplementaryActivityCompany FOREIGN KEY (idUserCreate)
REFERENCES [User](idUser)

ALTER TABLE ComplementaryActivityCompany
ADD CONSTRAINT FK_UserModifiedComplementaryActivityCompany FOREIGN KEY (idUserModified)
REFERENCES [User](idUser)

ALTER TABLE AgreementCompany
ADD CONSTRAINT FK_UserCreateAgreementCompany FOREIGN KEY (idUserCreate)
REFERENCES [User](idUser)

ALTER TABLE AgreementCompany
ADD CONSTRAINT FK_UserModifiedAgreementCompany FOREIGN KEY (idUserModified)
REFERENCES [User](idUser)

ALTER TABLE AgreementPurpose
ADD CONSTRAINT FK_UserCreateAgreementPurpose FOREIGN KEY (idUserCreate)
REFERENCES [User](idUser)

ALTER TABLE AgreementPurpose
ADD CONSTRAINT FK_UserModifiedAgreementPurpose FOREIGN KEY (idUserModified)
REFERENCES [User](idUser)

ALTER TABLE EmployeePosition
ADD CONSTRAINT FK_UserCreateEmployeePosition FOREIGN KEY (idUserCreate)
REFERENCES [User](idUser)

ALTER TABLE EmployeePosition
ADD CONSTRAINT FK_UserModifiedEmployeePosition FOREIGN KEY (idUserModified)
REFERENCES [User](idUser)

ALTER TABLE SubjectStudyPlan
ADD CONSTRAINT FK_UserCreateSubjectStudyPlan FOREIGN KEY (idUserCreate)
REFERENCES [User](idUser)

ALTER TABLE SubjectStudyPlan
ADD CONSTRAINT FK_UserModifiedSubjectStudyPlan FOREIGN KEY (idUserModified)
REFERENCES [User](idUser)
-------------------------------------------------------
ALTER TABLE ComplementaryActivity--- bien
ADD CONSTRAINT FK_ComplementaryActivityStudent FOREIGN KEY (idStudent)
REFERENCES Student(idStudent)

ALTER TABLE ComplementaryActivity--- bien
ADD CONSTRAINT FK_ComplementaryActivityActivityType FOREIGN KEY (idActivityType)
REFERENCES ActivityType(idActivityType)


ALTER TABLE Agreement---bien
ADD CONSTRAINT FK_AgreementObjective FOREIGN KEY (idObjetive)
REFERENCES Objective (idObjective)

ALTER TABLE Agreement---bien
ADD CONSTRAINT FK_AgreementTerritory FOREIGN KEY (idTerritory)
REFERENCES Territory (idTerritory)

ALTER TABLE Employee---bien
ADD CONSTRAINT FK_AgreementSubject FOREIGN KEY (idSubject)
REFERENCES Subject (idSubject)

ALTER TABLE ActivityDetail---bien
ADD CONSTRAINT FK_ActivityDetailEvaluationDetail FOREIGN KEY (idEvaluationDetail)
REFERENCES EvaluationDetail (idEvaluationDetail)


ALTER TABLE ActivityDetail---bien
ADD CONSTRAINT FK_ActivityDetailComplementaryActivity FOREIGN KEY (idComplementaryActivity)
REFERENCES ComplementaryActivity (idComplementaryActivity)

ALTER TABLE Empreneur---bien
ADD CONSTRAINT FK_EmpreneurStudent FOREIGN KEY (idStudent)
REFERENCES Student (idStudent)

ALTER TABLE Empreneur---bien
ADD CONSTRAINT FK_EmpreneurEmployee FOREIGN KEY (idEmployee)
REFERENCES Employee (idEmployee)

ALTER TABLE Company---bien
ADD CONSTRAINT FK_CompanySector FOREIGN KEY (idSector)
REFERENCES Sector  (idSector)

ALTER TABLE CompanyStudent---bien
ADD CONSTRAINT FK_CompanyStudentStudent FOREIGN KEY (idStudent)
REFERENCES Student (idStudent)

ALTER TABLE OfficeRequestcommission---bien
ADD CONSTRAINT FK_OfficeRequestcommissionEmployee FOREIGN KEY (idEmploye)
REFERENCES Employee (idEmployee)

ALTER TABLE StudyPlan---bien
ADD CONSTRAINT FK_StudyPlanCareer FOREIGN KEY (idCareer)
REFERENCES Career (idCareer)

ALTER TABLE Position---bien
ADD CONSTRAINT FK_PositionTypePosition FOREIGN KEY (idTypePosition)
REFERENCES TypePosition (idTypePosition)

ALTER TABLE Viatic---bien
ADD CONSTRAINT FK_ViaticEmployee FOREIGN KEY (idEmployee)
REFERENCES Employee (idEmployee)


ALTER TABLE Visit---bien
ADD CONSTRAINT FK_VisitCompany FOREIGN KEY (idCompany)
REFERENCES Company (idCompany)

ALTER TABLE Visit---bien
ADD CONSTRAINT FK_VisitZone FOREIGN KEY (idZone)
REFERENCES Zone (idZone)

ALTER TABLE Visit---bien
ADD CONSTRAINT FK_VisitEmployee FOREIGN KEY (idEmployee)
REFERENCES Employee (idEmployee)

ALTER TABLE Visit---bien
ADD CONSTRAINT FK_VisitStudent FOREIGN KEY (idStudent)
REFERENCES Student (idStudent)

ALTER TABLE ComplementaryActivityCompany---
ADD CONSTRAINT FK_ActivityCompanyActivity FOREIGN KEY (idComplementaryActivity)
REFERENCES ComplementaryActivity (idComplementaryActivity)

ALTER TABLE ComplementaryActivityCompany
ADD CONSTRAINT FK_ActivityCompanyCompany FOREIGN KEY (idCompany)
REFERENCES Company (idCompany)

ALTER TABLE AgreementCompany
ADD CONSTRAINT FK_AgreementCompanyAgreement FOREIGN KEY (idAgreement)
REFERENCES Agreement (idAgreement)

ALTER TABLE AgreementCompany
ADD CONSTRAINT FK_AgreementCompanyCompany FOREIGN KEY (idCompany)
REFERENCES Company (idCompany)

ALTER TABLE AgreementPurpose
ADD CONSTRAINT FK_AgreementPurposePurpose FOREIGN KEY (idPurpose)
REFERENCES Purpose (idPurpose)

ALTER TABLE AgreementPurpose
ADD CONSTRAINT FK_AgreementPurposeAgreement FOREIGN KEY (idAgreement)
REFERENCES Agreement (idAgreement)


ALTER TABLE EmployeePosition
ADD CONSTRAINT FK_EmployeePositionEmployee FOREIGN KEY (idEmployee)
REFERENCES Employee (idEmployee)

ALTER TABLE EmployeePosition
ADD CONSTRAINT FK_EmployeePositionPosition FOREIGN KEY (idPosition)
REFERENCES Position (idPosition)



ALTER TABLE SubjectStudyPlan
ADD CONSTRAINT FK_SubjectStudyPlanSubject FOREIGN KEY (idSubject)
REFERENCES Subject (idSubject)

ALTER TABLE SubjectStudyPlan
ADD CONSTRAINT FK_SubjectStudyPlanStudyPlan FOREIGN KEY (idStudyPlan)
REFERENCES StudyPlan (idStudyPlan)



-----------------------poblacion-----------
INSERT INTO [User] ([name],[password], email)
VALUES ('Nallely', '130218','toledo@');

INSERT INTO Career([name],duration,[description],idUserCreate,dateCreate,idUserModified,dateModified)
VALUES('Informatica', '4 años 9 meses','Programacion',1,GETDATE(),1,GETDATE()),
      ('Mecanica', '4 años 9 meses','Automotriz',1,GETDATE(),1,GETDATE()),
	  ('Gestion Empresarial', '4 años 9 meses','Gestiona',1,GETDATE(),1,GETDATE()),
	  ('Electronica', '4 años 9 meses','Gestiona',1,GETDATE(),1,GETDATE()),
	  ('Energias Renovables', '4 años 9 meses','Medio ambiente',1,GETDATE(),1,GETDATE()),
	  ('Industrial', '4 años 9 meses','Industria',1,GETDATE(),1,GETDATE());

INSERT INTO Objective (objetivename,idUsercreate,dateCreate,idUserModified,dateModified)
VALUES  ('specific',1,GETDATE(),1,GETDATE()),
		('general',1,GETDATE(),1,GETDATE());
		

INSERT INTO TypePosition([level],typepositionname,idUserCreate,dateCreate,idUserModified,dateModified)
VALUES('intermedio', 'technicalAnalyst',1,GETDATE(),1,GETDATE()),
      ('intermedio', 'teacher',1,GETDATE(),1,GETDATE()),
	  ('intermedio', 'divisionChief',1,GETDATE(),1,GETDATE()),
	  ('intermedio', 'holderofthetransparencyUnit',1,GETDATE(),1,GETDATE()),
	    ('intermedio', 'headofDepartment',1,GETDATE(),1,GETDATE());

INSERT INTO  Proof([date],reason,idUsercreate,dateCreate,idUserModified,dateModified)
VALUES  ('2023-01-23','Visita a denso',1,GETDATE(),1,GETDATE()),
        ('2023-01-23','Visita a ahmsa',1,GETDATE(),1,GETDATE()),
		('2023-01-23','Visita a metro rey',1,GETDATE(),1,GETDATE()),
		('2023-01-23','Visita a wittur',1,GETDATE(),1,GETDATE()),
		('2023-01-23','Visita a ferromex',1,GETDATE(),1,GETDATE());

INSERT INTO  Purpose(investigation,purposename,idUsercreate,dateCreate,idUserModified,dateModified)
VALUES  ('investigation','investigation',1,GETDATE(),1,GETDATE()),
        ('practice','practice',1,GETDATE(),1,GETDATE()),
		('resindence','resindence',1,GETDATE(),1,GETDATE()),
		('socialService','socialService',1,GETDATE(),1,GETDATE()),
		('external','external',1,GETDATE(),1,GETDATE());

INSERT INTO  Sector(sectorname,idUsercreate,dateCreate,idUserModified,dateModified)
VALUES  ('public',1,GETDATE(),1,GETDATE()),
        ('private',1,GETDATE(),1,GETDATE()),
		('service',1,GETDATE(),1,GETDATE()),
		('social',1,GETDATE(),1,GETDATE()),
			('productive',1,GETDATE(),1,GETDATE()),
		('educative',1,GETDATE(),1,GETDATE());

INSERT INTO [Subject]([name],credit,unit,characteristic,keyMatter,idUsercreate,dateCreate,idUserModified,dateModified)
VALUES ('ingles','100','1','Actividad 1','0923',1,GETDATE(),1,GETDATE()),
       ('ingles','100','2','Actividad 2','0923',1,GETDATE(),1,GETDATE()),
	   ('ingles','100','3','Actividad 3','0923',1,GETDATE(),1,GETDATE()),
	   ('ingles','100','4','Actividad 4','0923',1,GETDATE(),1,GETDATE()),
	   ('ingles','100','5','Actividad 5','0923',1,GETDATE(),1,GETDATE());

INSERT INTO Territory(territoryname,idUsercreate,dateCreate,idUserModified,dateModified)
VALUES  ('nacional',1,GETDATE(),1,GETDATE()),
        ('internacional',1,GETDATE(),1,GETDATE());
	

INSERT INTO [Zone](zonename,idUserCreate,dateCreate,idUserModified,dateModified)
VALUES('regional',1,GETDATE(),1,GETDATE()),
      ('local',1,GETDATE(),1,GETDATE()),
	  ('national',1,GETDATE(),1,GETDATE());
	 

INSERt INTO Company([name],email,phone,[address],identificationNumber,idSector,idUserCreate,dateCreate,idUserModified,dateModified)
VALUES('Altos hornos de mexico','hornos@gmail.com','8661652344','kenedy 122 monclova','2023',1,1,GETDATE(),1,GETDATE()),
      ('Denso','denso@gmail.com','8661302344','de los hornos cd frontera','2023',2,1,GETDATE(),1,GETDATE()),
	  ('Ferromex','ferromex@gmail.com','8661623445','Americana cd frontera','2023',3,1,GETDATE(),1,GETDATE()),
	  ('Coahuila Durango','coahuiladurango@gmail.com','8662002344','porfirio diaz cd frontera','2023',4,1,GETDATE(),1,GETDATE()),
	  ('Aptiv','aptiv@gmail.com','8661702344','lib carlos salinas de gortari','2023',5,1,GETDATE(),1,GETDATE())

INSERT INTO Employee([name],lastname,[mother'sLastName]	,gender,phone,email,[address],socialSecurity,dateOfHire,idSubject,idUsercreate,dateCreate,idUserModified,dateModified)
VALUES ('Luis Alfonso','Rodriguez','Perez','Hombre','8662567822','luis@gmail.com','Ayuntamiento 212 Occidental','44180032044','2023-01-23',1,1,GETDATE(),1,GETDATE()),
       ('Alberto','Salazar','Zuñiga','Hombre','8662347822','alberto@gmail.com','Ignacio allende 313 La sierrita','44180032042','2023-02-12',2,1,GETDATE(),1,GETDATE()),
	   ('Antonio','Rodriguez','Tovar','Hombre','8661227822','antonio@gmail.com','Jalisco nte 1700 Monclova','44180032043','2023-02-10',3,1,GETDATE(),1,GETDATE()),
	   ('Gabriela','Mendoza','Aguilar','Mujer','8662137822','gabriela@gmail.com','C. Monaco 1010 Monclova','44180032044','2023-04-11',4,1,GETDATE(),1,GETDATE()),
	   ('Patricia','Hernendez','Mata','Mujer','8665437822','patricia@gmail.com','C. Zaragoza 227 Frontera','44180032045','2023-07-25',5,1,GETDATE(),1,GETDATE());

INSERT INTO Student ([name],lastname,mothersthestName,enrollment,birthdate,curp,phone,rfc,socialSegurity,idUsercreate,creationdate,IdUserModify,modified)
VALUES ('Nallely','Toledo','Alonso','I15171917','1996-06-09','TOASMNL000NLLN9654','8667882323','TOASMNL000NLL','44180032043',1,GETDATE(),1,GETDATE()),
       ('Alberto','Salazar','Zuñiga','I18050517','2000-04-08','SAZA000408HCLLXLA6','8661222321','SAZA000408K61','44180032089',1,GETDATE(),1,GETDATE()),
	   ('Antonio','Perez','Gaitan','I23050517','2003-08-20','PEGA030820HCLLXKLR','8664322321','PEGA030820HCL','44180032090',1,GETDATE(),1,GETDATE()),
	   ('Maria','Rivera','Soledad','I20050517','2005-01-25','RISM000408HCLLXLA6','8662332321','RISM000408HCL','44180032011',1,GETDATE(),1,GETDATE()),
	   ('Bertha','Ibarra','Vazquez','I17050517','2007-09-17','VAVB000408HCLLXLO6','8666542321','VAVB000408HCL','44180032055',1,GETDATE(),1,GETDATE());
	   
INSERT INTO Visit(numberofstudent,duration,objetive,aplicacion,datevisit,requiretransportation,result,idCompany,idZone,idEmployee,idStudent,idUsercreate,datecreate,idusermodified,datemodified)
VALUES ('23','3 Horas','Conocer las instalaciones','2023-09-17','2023-09-17','Si','Excelente',1,1,1,1,1,GETDATE(),1,GETDATE()),
       ('10','2 Horas','Conocer las instalaciones','2023-10-09','2023-10-09','No','Excelente',2,2,2,2,1,GETDATE(),1,GETDATE()),
	   ('50','8 Horas','Conocer las instalaciones','2023-10-05','2023-10-05','Si','Excelente',3,3,3,3,1,GETDATE(),1,GETDATE()),
	   ('32','3 Horas','Conocer las instalaciones','2023-11-23','2023-11-23','Si','Excelente',4,2,4,4,1,GETDATE(),1,GETDATE()),
	   ('27','3 Horas','Conocer las instalaciones','2023-12-01','2023-12-01','Si','Excelente',5,1,5,5,1,GETDATE(),1,GETDATE());

	   INSERt INTO EvaluationDetail(assessment,criterion,idUsercreate,dateCreate,idUserModified,dateModified)
VALUES('Excelente','Un buen desarrollo de trabajo',1,GETDATE(),1,GETDATE()),
      ('Buen trabajp ','Interesante trabajo solo la ortografia',1,GETDATE(),1,GETDATE()),
	  ('Excelente','Ninguno',1,GETDATE(),1,GETDATE()),
      ('Excelente','Ninguno',1,GETDATE(),1,GETDATE());

	 
INSERt INTO ActivityType(description,activityname,idUsercreate,dateCreate,idUserModified,dateModified)
VALUES('practice','Proyecto de energias renovables la luz',1,GETDATE(),1,GETDATE()),
      ('residence ','Proyecto de Redes computacionales',1,GETDATE(),1,GETDATE()),
	  ('stay','Proyecto de Funcionamiento de automotriz',1,GETDATE(),1,GETDATE()),
      ('socialservice','Proyecto de Diseñar una pagina web',1,GETDATE(),1,GETDATE());

INSERt INTO ComplementaryActivity(activityname,idStudent,idActivityType,idUsercreate,dateCreate,idUserModified,dateModified)
VALUES('practice',1,1,1,GETDATE(),1,GETDATE()),
      ('residence ',2,2,1,GETDATE(),1,GETDATE()),
	  (' stay',3,3,1,GETDATE(),1,GETDATE()),
      ('socialservice',4,4,1,GETDATE(),1,GETDATE());

 INSERt INTO ActivityDetail(activitydetailsdescription,idEvaluationDetail,idComplementaryActivity,idUsercreate,dateCreate,idUserModified,dateModified)
VALUES('Ninguno',1,1,1,GETDATE(),1,GETDATE()),
      ('Interesante trabajo solo falta menjorar la ortografia ',2,2,1,GETDATE(),1,GETDATE()),
	  ('Ninguno',3,3,1,GETDATE(),1,GETDATE()),
      ('Ninguno',4,4,1,GETDATE(),1,GETDATE());
	  INSERT INTO Agreement(acronym,objetive,idObjetive,idTerritory,statusAgreement,idUserCreate,dateCreate,idUserModified,dateModified)
VALUES ('CFE','Servicio',1,1,'Activo',1,GETDATE(),1,GETDATE()),
       ('Simas','Servicio',2,2,'Inactivo',1,GETDATE(),1,GETDATE()),
	   ('Telmex','Servicio',2,1,'Activo',1,GETDATE(),1,GETDATE()),
	   ('Transporte','Servicio',1,2,'Activo',1,GETDATE(),1,GETDATE()),
	   ('Mantenimiento','Servicio',2,1,'Inactivo',1,GETDATE(),1,GETDATE());

INSERt INTO Empreneur(request ,objetive,codeOfEmpreneur ,workteam ,startdate ,finaldate ,duration ,idEmployee ,idStudent,idUserCreate,dateCreate,idUserModified,dateModified)
VALUES('Solicitud de Proyecto 1','Investigacion sobre Redes ','A20230412 ','4','2023-09-17','2023-09-17','6 Meses',1,1,1,GETDATE(),1,GETDATE()),
      ('Solicitud de Proyecto 2','Investigacion de campo ','A20230923 ','2','2023-09-17','2023-09-17','6 Meses',1,1,1,GETDATE(),1,GETDATE()),
	  ('Solicitud de Proyecto 3','Exposicion','A20231131 ','5','2023-09-17','2023-09-17','6 Meses',1,1,1,GETDATE(),1,GETDATE()),
	  ('Solicitud de Proyecto 4','Test','A20231002 ','2','2023-09-17','2023-09-17','6 Meses',1,1,1,GETDATE(),1,GETDATE()),
	  ('Solicitud de Proyecto 5','Exposicion','A20232528 ','3','2023-09-17','2023-09-17','6 Meses',1,1,1,GETDATE(),1,GETDATE());

INSERT INTO Viatic(place,description1,amount,idEmployee,idUsercreate,creationdate,IdUserModify,modified)
VALUES ('Saltillo Coahuila','Realizar una visita para conocer las instalaciones y que es lo que realizan.','2500.50',1,1,GETDATE(),1,GETDATE()),
       ('Monterrey Nuevo Leon','Realizar una visita para conocer las instalaciones y que es lo que realizan.','3289.50',2,1,GETDATE(),1,GETDATE()),
	   ('Monclova Coahuila','Realizar una visita para conocer las instalaciones y que es lo que realizan.','1289.50',3,1,GETDATE(),1,GETDATE()),
	   ('Frontera Coahuila','Realizar una visita para conocer las instalaciones y que es lo que realizan.','1392.50',4,1,GETDATE(),1,GETDATE()),
	   ('Saltillo Coahuila','Realizar una visita para conocer las instalaciones y que es lo que realizan.','3478.50',5,1,GETDATE(),1,GETDATE());

INSERT INTO CompanyStudent (date,workplace,idStudent,idUsercreate,dateCreate,idUserModified,dateModified)
VALUES ('2023-10-23','HFI',1,1,GETDATE(),1,GETDATE()),
       ('2023-11-30','Grupo Fox',2,1,GETDATE(),1,GETDATE()),
	   ('2023-09-25','Denso',3,1,GETDATE(),1,GETDATE()),
	   ('2023-10-02','Aramak',4,1,GETDATE(),1,GETDATE()),
	   ('2023-11-09','Quality',5,1,GETDATE(),1,GETDATE());

INSERT INTO OfficeRequestcommission (addressee ,header ,afftair ,date1 ,idEmploye,IdUserCreate,creationdate,IdUserModify,modified)
VALUES ('Luis Alfonso Rodriguez Perez','Realizar Visita','Ir a las instalaciones y hacer una reunion','2023-11-09',1,1,GETDATE(),1,GETDATE()),
       ('Alberto Salazar Zuñiga', 'Revisión de Contrato', 'Reunión para revisar contrato', '2023-11-10',2, 1, GETDATE(), 1, GETDATE()),
       ('Antonio Rodriguez Tovar', 'Informe Mensual', 'Preparar informe de ventas', '2023-11-11', 3,1, GETDATE(), 1, GETDATE()),
       ('Gabriela Mendoza Aguilar', 'Entrevista de Trabajo', 'Realizar entrevista con candidato', '2023-11-12',4, 1, GETDATE(), 1, GETDATE()),
       ('Patricia Hernendez Mata', 'Reunión de Equipo', 'Planificar estrategia de equipo', '2023-11-13',5, 1, GETDATE(), 1, GETDATE()); 

 INSERT INTO Position( jobDescription, wage, workingHours ,idTypePosition ,IdUserCreate,creationdate,IdUserModify,modified)
VALUES ('Jefe de maestros','3210.99','8 Horas',1,1,GETDATE(),1,GETDATE()),
        ('Profesor de Matemáticas', '2500.00', '8 Horas', 2, 1, GETDATE(), 1, GETDATE()),
       ('Director', '4800.00', '8 Horas', 3, 1, GETDATE(), 1, GETDATE()),
       ('Psicologo/a', '2800.00', '8 Horas', 4, 1, GETDATE(), 1, GETDATE()),
       ('Subdirector', '2200.00', '8 Horas', 5, 1, GETDATE(), 1, GETDATE());

INSERT INTO StudyPlan(  objetive,starDate,finalDate,key1 ,idCareer  ,IdUserCreate,creationdate,IdUserModify,modified)
VALUES ('Informatica','2023-11-12','2023-11-12','I1920812',1,1,GETDATE(),1,GETDATE()),
       ('Gestion Empresarial','2023-11-07','2023-11-12','G8237288',2,1,GETDATE(),1,GETDATE()),
	   ('Electronica','2023-11-23','2023-11-12','E1920812',3,1,GETDATE(),1,GETDATE()),
       ('Mecanica','2023-10-31','2023-11-12','M765647',4,1,GETDATE(),1,GETDATE()),
	   ('Industrial','2023-09-12','2023-11-12','IN99087Y',5,1,GETDATE(),1,GETDATE());

INSERT INTO ComplementaryActivityCompany( idComplementaryActivity,IdCompany ,IdUserCreate,datecreate,idusermodified,datemodified)
Values (1,1,1,GETDATE(),1,GETDATE()),
       (2,2,1,GETDATE(),1,GETDATE()),
	   (3,3,1,GETDATE(),1,GETDATE()),
	   (4,4,1,GETDATE(),1,GETDATE()),
	   (1,1,1,GETDATE(),1,GETDATE());

INSERT INTO AgreementCompany(  idAgreement,IdCompany ,IdUserCreate,datecreate,idusermodified,datemodified)
Values (1,1,1,GETDATE(),1,GETDATE()),
       (2,2,1,GETDATE(),1,GETDATE()),
	   (3,3,1,GETDATE(),1,GETDATE()),
	   (4,4,1,GETDATE(),1,GETDATE()),
	   (5,5,1,GETDATE(),1,GETDATE());

INSERT INTO AgreementPurpose(  idAgreement,IdPurpose ,IdUserCreate,datecreate,idusermodified,datemodified)
Values (1,1,1,GETDATE(),1,GETDATE()),
       (2,2,1,GETDATE(),1,GETDATE()),
	   (3,3,1,GETDATE(),1,GETDATE()),
	   (4,4,1,GETDATE(),1,GETDATE()),
	   (5,5,1,GETDATE(),1,GETDATE());

INSERT INTO EmployeePosition(  IdEmployee,IdPosition ,IdUserCreate,datecreate,idusermodified,datemodified)
Values (1,1,1,GETDATE(),1,GETDATE()),
       (2,2,1,GETDATE(),1,GETDATE()),
	   (3,3,1,GETDATE(),1,GETDATE()),
	   (4,4,1,GETDATE(),1,GETDATE()),
	   (5,5,1,GETDATE(),1,GETDATE());

INSERT INTO SubjectStudyPlan(  IdSubject,IdStudyPlan ,IdUserCreate,datecreate,idusermodified,datemodified)
Values (1,1,1,GETDATE(),1,GETDATE()),
       (2,2,1,GETDATE(),1,GETDATE()),
	   (3,3,1,GETDATE(),1,GETDATE()),
	   (4,4,1,GETDATE(),1,GETDATE()),
	   (5,5,1,GETDATE(),1,GETDATE());

Select * from Career
Select * from Objective
Select * from TypePosition
Select * from ActivityDetail
Select * from ActivityType
Select * from EvaluationDetail
Select * from Proof
Select * from Purpose
Select * from Sector
Select * from [Subject]
Select * from Territory
Select * from [Zone]
Select * from Company
Select * from Employee
Select * from Student
Select * from Visit
Select * from ComplementaryActivity
Select * from Agreement
Select * from Empreneur
Select * from Viatic
Select * from CompanyStudent
Select * from OfficeRequestcommission
Select * from Position
Select * from StudyPlan
Select * from ComplementaryActivityCompany
Select * from AgreementCompany
Select * from AgreementPurpose
Select * from EmployeePosition
Select * from SubjectStudyPlan





