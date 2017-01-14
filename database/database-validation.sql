select count(Employee.Id) as InsuranceId_IS_NULL_EmployeeIds
from Salary
join List on Salary.ListId=List.Id
join CompEmp on CompEmp.Id=Salary.CompEmpId
join Employee on Employee.Id=CompEmp.EmployeeId
where InsuranceId is NULL or InsuranceId = 0;


select count(Employee.Id) as WorkPlaceStatus_IS_NULL_EmployeeIds
from Salary
join List on Salary.ListId=List.Id
join CompEmp on CompEmp.Id=Salary.CompEmpId
join Employee on Employee.Id=CompEmp.EmployeeId
where CompEmp.WorkPlaceStatus is NULL or CompEmp.WorkPlaceStatus = 0;


select count(Employee.Id) as EmploymentTypeId_Is_NULL_EmployeeIds
from Salary
join List on Salary.ListId=List.Id
join CompEmp on CompEmp.Id=Salary.CompEmpId
join Employee on Employee.Id=CompEmp.EmployeeId
where EmploymentTypeId is NULL or EmploymentTypeId = 0;


select count(Employee.Id) as MoafiatId_Is_NULL_EmployeeIds
from Salary
join List on Salary.ListId=List.Id
join CompEmp on CompEmp.Id=Salary.CompEmpId
join Employee on Employee.Id=CompEmp.EmployeeId
where CompEmp.MoafiatId is NULL or CompEmp.MoafiatId = 0;


select count(Employee.Id) as NumberRealWorkedMonth_IS_NULL_EmployeeIds
from Salary
join List on Salary.ListId=List.Id
join CompEmp on CompEmp.Id=Salary.CompEmpId
join Employee on Employee.Id=CompEmp.EmployeeId
where NumberRealWorkedMonth is NULL or NumberRealWorkedMonth = 0;


select count(Employee.Id) as PayType_IS_NULL_EmployeeIds
from Salary
join List on Salary.ListId=List.Id
join CompEmp on CompEmp.Id=Salary.CompEmpId
join Employee on Employee.Id=CompEmp.EmployeeId
where PayType is NULL or PayType = 0;


select count(Employee.Id) as ExchangeRate_IS_NULL_EmployeeIds
from Salary
join List on Salary.ListId=List.Id
join CompEmp on CompEmp.Id=Salary.CompEmpId
join Employee on Employee.Id=CompEmp.EmployeeId
where ExchangeRate is NULL or ExchangeRate = 0;


select count(Employee.Id) as HouseId_IS_NULL_EmployeeIds
from Salary
join List on Salary.ListId=List.Id
join CompEmp on CompEmp.Id=Salary.CompEmpId
join Employee on Employee.Id=CompEmp.EmployeeId
where HouseId is NULL or HouseId = 0;


select count(Employee.Id) as carId_IS_NULL_EmployeeIds
from Salary
join List on Salary.ListId=List.Id
join CompEmp on CompEmp.Id=Salary.CompEmpId
join Employee on Employee.Id=CompEmp.EmployeeId
where carId is NULL or carId = 0;



select distinct EducationCertificate
from Salary
join List on Salary.ListId=List.Id
join CompEmp on CompEmp.Id=Salary.CompEmpId
join Employee on Employee.Id=CompEmp.EmployeeId


select distinct NationalityId
from Salary
join List on Salary.ListId=List.Id
join CompEmp on CompEmp.Id=Salary.CompEmpId
join Employee on Employee.Id=CompEmp.EmployeeId


select distinct InsuranceId
from Salary
join List on Salary.ListId=List.Id
join CompEmp on CompEmp.Id=Salary.CompEmpId
join Employee on Employee.Id=CompEmp.EmployeeId


select distinct EmploymentTypeId
from Salary
join List on Salary.ListId=List.Id
join CompEmp on CompEmp.Id=Salary.CompEmpId
join Employee on Employee.Id=CompEmp.EmployeeId


select distinct CompEmp.WorkPlaceStatus
from Salary
join List on Salary.ListId=List.Id
join CompEmp on CompEmp.Id=Salary.CompEmpId
join Employee on Employee.Id=CompEmp.EmployeeId


select distinct CompEmp.MoafiatId
from Salary
join List on Salary.ListId=List.Id
join CompEmp on CompEmp.Id=Salary.CompEmpId
join Employee on Employee.Id=CompEmp.EmployeeId


select distinct HouseId
from Salary
join List on Salary.ListId=List.Id
join CompEmp on CompEmp.Id=Salary.CompEmpId
join Employee on Employee.Id=CompEmp.EmployeeId


select distinct CarId
from Salary
join List on Salary.ListId=List.Id
join CompEmp on CompEmp.Id=Salary.CompEmpId
join Employee on Employee.Id=CompEmp.EmployeeId


select distinct PaymentId
from Salary
join List on Salary.ListId=List.Id
join CompEmp on CompEmp.Id=Salary.CompEmpId
join Employee on Employee.Id=CompEmp.EmployeeId


select count(Id) as KarkonanNoIsZeroOrNull
from Eris.dbo.List
where KarkonanNo is null or KarkonanNo = 0
