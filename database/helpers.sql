SELECT COUNT(Salary.Id)
FROM Eris.dbo.Salary
JOIN Eris.dbo.List                  ON Salary.ListId      = List.Id
JOIN Eris.dbo.CompEmp               ON CompEmp.Id         = Salary.CompEmpId
JOIN Eris.dbo.Employee              ON Employee.Id        = CompEmp.EmployeeId
JOIN Eris.dbo.Employer              ON Employer.Id        = List.UserId
JOIN ErisHelper.dbo.EmployerFilter  ON EmployerFilter.tin = Employer.NationalCode
WHERE Employee.MoafiatId = 0