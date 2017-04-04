USE master;
GO
IF DB_ID (N'ErisHelper') IS NOT NULL
DROP DATABASE ErisHelper;
GO
create database ErisHelper collate Persian_100_CI_AI;
GO
use ErisHelper;
create table EmployerFilter (
    tin varchar(255),
    office varchar(255)
);

insert into EmployerFilter (tin, office) values
('14003623812', '2863'),
('14003720500', '1807'),
('14003640215', '3688'),
('0042240654', '2012'),
('14003624429', '1946'),
('0042467179', '2008'),
('1219667048', '1031'),
('0050067052', '1738'),
('14003706183', '1766'),
('14003995570', '1809'),
('0035175230', '1031'),
('14003484900', '2034'),
('14003486862', '1907'),
('0051189933', '1855'),
('0050737074', '1816'),
('14004295548', '1766'),
('14003957118', '2040');


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
