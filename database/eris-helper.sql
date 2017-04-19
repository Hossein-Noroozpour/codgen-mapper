USE master;
IF DB_ID (N'ErisHelper') IS NOT NULL
DROP DATABASE ErisHelper;
CREATE DATABASE ErisHelper collate Persian_100_CI_AI;
USE ErisHelper;
CREATE TABLE EmployerFilter (
    tin VARCHAR(255),
    office VARCHAR(255)
);

INSERT INTO EmployerFilter (tin, office) values
    ('0056026153', '3688'),
    ('0559403224', '3688'),
    ('1380684811', '3688');



SELECT * FROM ErisHelper.dbo.EmployerFilter;
CREATE TABLE ErisHelper.dbo.InstEmployers;
INSERT INTO ErisHelper.dbo.InstEmployers (real_tin, fake_tin, real_office, fake_office)
VALUES
('14002921259', '10103132631'),
('10320203766', '10103383619'),
('10103788072', '10103485883'),
('10101554831', '10103515284'),
('10102242977', '10103639376'),
('10100322633', '10100505849'),
('10102171988', '10100537713'),
('10103302489', '10102430629'),
('10101002474', '10103171584'),
('10103343741', '10103206847'),
('14004299328', '10103337800');
SELECT tin
FROM ErisHelper.dbo.EmployerFilter;

SELECT *
FROM ErisHelper.dbo.InstEmployers;
