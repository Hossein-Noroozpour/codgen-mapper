USE master;
GO
IF DB_ID (N'MyOptionsTest') IS NOT NULL
DROP DATABASE ErisHelper;
GO
create database ErisHelper collate Persian_100_CI_AI;
GO
use ErisHelper;
create table EmployerFilter (
    tin varchar(255)
);

insert into EmployerFilter (tin) values
('14002921259'),
('10320203766'),
('10103788072'),
('10101554831'),
('10102242977'),
('10100322633'),
('10102171988'),
('10103302489'),
('10101002474'),
('10103343741'),
('14004299328');