use Eris;

select count(Employee.Id) as InsuranceId_IS_NULL_EmployeeIds
from Salary
join List on Salary.ListId=List.Id
join CompEmp on CompEmp.Id=Salary.CompEmpId
join Employee on Employee.Id=CompEmp.EmployeeId
where InsuranceId is NULL or InsuranceId = 0;


--select count(Employee.Id) as WorkPlaceStatus_IS_NULL_EmployeeIds
--from Salary
--join List on Salary.ListId=List.Id
--join CompEmp on CompEmp.Id=Salary.CompEmpId
--join Employee on Employee.Id=CompEmp.EmployeeId
--where CompEmp.WorkPlaceStatus is NULL or CompEmp.WorkPlaceStatus = 0;


select count(Employee.Id) as EmploymentTypeId_Is_NULL_EmployeeIds
from Salary
join List on Salary.ListId=List.Id
join CompEmp on CompEmp.Id=Salary.CompEmpId
join Employee on Employee.Id=CompEmp.EmployeeId
where EmploymentTypeId is NULL or EmploymentTypeId = 0;


--select count(Employee.Id) as MoafiatId_Is_NULL_EmployeeIds
--from Salary
--join List on Salary.ListId=List.Id
--join CompEmp on CompEmp.Id=Salary.CompEmpId
--join Employee on Employee.Id=CompEmp.EmployeeId
--where MoafiatId is NULL or MoafiatId = 0;


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


--select distinct CompEmp.WorkPlaceStatus
--from Salary
--join List on Salary.ListId=List.Id
--join CompEmp on CompEmp.Id=Salary.CompEmpId
--join Employee on Employee.Id=CompEmp.EmployeeId


--select distinct MoafiatId
--from Salary
--join List on Salary.ListId=List.Id
--join CompEmp on CompEmp.Id=Salary.CompEmpId
--join Employee on Employee.Id=CompEmp.EmployeeId


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





SELECT
	DISTINCT Em.NationalCode, Li.Id As ErrorListID, Ep.Id AS ErrorEmpID
FROM
	Eris.dbo.Salary
	JOIN Eris.dbo.List AS Li ON Eris.dbo.Salary.ListId = Li.Id
	JOIN Eris.dbo.Employer AS Em ON Em.Id = Li.UserId
	JOIN Eris.dbo.CompEmp AS Cm ON Cm.Id = Eris.dbo.Salary.CompEmpId
	JOIN Eris.dbo.Employee AS Ep ON Cm.EmployeeId = Ep.Id
	JOIN ErisHelper.dbo.EmployerFilter ON ErisHelper.dbo.EmployerFilter.tin = Em.NationalCode
WHERE
	(
		(continous_taxable_income_year_to_previous_month IS NULL
			OR continous_taxable_income_year_to_previous_month = 0)
		AND (
			SELECT SUM(IIF(outstanding_payments_received IS NULL, 0, outstanding_payments_received))
			FROM Eris.dbo.Salary
				JOIN Eris.dbo.List ON Eris.dbo.Salary.ListId = Eris.dbo.List.Id
				JOIN Eris.dbo.CompEmp ON Eris.dbo.Salary.CompEmpId = Eris.dbo.CompEmp.Id
				JOIN Eris.dbo.Employee ON Eris.dbo.Employee.Id = Eris.dbo.CompEmp.EmployeeId
			WHERE
				Li.Month > Eris.dbo.List.Month AND Em.Id = Eris.dbo.List.UserId AND Eris.dbo.Employee.Id = Ep.Id
		) + (
			SELECT SUM(IIF(sum_ongoing_gross_salary IS NULL, 0, sum_ongoing_gross_salary))
			FROM Eris.dbo.Salary
				JOIN Eris.dbo.List ON Eris.dbo.Salary.ListId = Eris.dbo.List.Id
				JOIN Eris.dbo.CompEmp ON Eris.dbo.Salary.CompEmpId = Eris.dbo.CompEmp.Id
				JOIN Eris.dbo.Employee ON Eris.dbo.Employee.Id = Eris.dbo.CompEmp.EmployeeId
			WHERE
				Li.Month > Eris.dbo.List.Month AND Em.Id = Eris.dbo.List.UserId AND Eris.dbo.Employee.Id = Ep.Id
		) != 0
		AND Li.Month != 1
	)
	OR (
		continous_taxable_income_year_to_previous_month IS NOT NULL
		AND continous_taxable_income_year_to_previous_month != 0
		AND Li.Month = 1
	)
ORDER BY
	NationalCode





SELECT
	DISTINCT Em.NationalCode, Li.Id
FROM
	Eris.dbo.Salary
	JOIN Eris.dbo.List AS Li ON Eris.dbo.Salary.ListId = Li.Id
	JOIN Eris.dbo.Employer AS Em ON Em.Id = Li.UserId
	JOIN Eris.dbo.CompEmp AS Cm ON Cm.Id = Eris.dbo.Salary.CompEmpId
	JOIN Eris.dbo.Employee AS Ep ON Cm.EmployeeId = Ep.Id
	JOIN ErisHelper.dbo.EmployerFilter ON ErisHelper.dbo.EmployerFilter.tin = Em.NationalCode
WHERE
	(
		(
			housing_expenses_previous_month IS NULL
			OR housing_expenses_previous_month = 0
		)
		AND
		(
			SELECT SUM(IIF(housing_expense_salary IS NULL, 0, housing_expense_salary))
			FROM Eris.dbo.Salary
				JOIN Eris.dbo.List ON Eris.dbo.Salary.ListId = Eris.dbo.List.Id
				JOIN Eris.dbo.CompEmp ON Eris.dbo.Salary.CompEmpId = Eris.dbo.CompEmp.Id
				JOIN Eris.dbo.Employee ON Eris.dbo.Employee.Id = Eris.dbo.CompEmp.EmployeeId
			WHERE
				Li.Month > Eris.dbo.List.Month AND Em.Id = Eris.dbo.List.UserId AND Eris.dbo.Employee.Id = Ep.Id
		) != 0
		AND Li.Month != 1
	) OR
	(
		housing_expenses_previous_month IS NOT NULL
		AND housing_expenses_previous_month != 0
		AND Li.Month = 1
	)
ORDER BY
	NationalCode





SELECT
	DISTINCT Em.NationalCode, Li.Id
FROM
	Eris.dbo.Salary
	JOIN Eris.dbo.List AS Li ON Eris.dbo.Salary.ListId = Li.Id
	JOIN Eris.dbo.Employer AS Em ON Em.Id = Li.UserId
	JOIN Eris.dbo.CompEmp AS Cm ON Cm.Id = Eris.dbo.Salary.CompEmpId
	JOIN Eris.dbo.Employee AS Ep ON Cm.EmployeeId = Ep.Id
	JOIN ErisHelper.dbo.EmployerFilter ON ErisHelper.dbo.EmployerFilter.tin = Em.NationalCode
WHERE
	(
		(
			vehicle_expenses_previous_month IS NULL
			OR vehicle_expenses_previous_month = 0
		)
		AND
		(
			SELECT SUM(IIF(vehicle_expense_salary IS NULL, 0, vehicle_expense_salary))
			FROM Eris.dbo.Salary
				JOIN Eris.dbo.List ON Eris.dbo.Salary.ListId = Eris.dbo.List.Id
				JOIN Eris.dbo.CompEmp ON Eris.dbo.Salary.CompEmpId = Eris.dbo.CompEmp.Id
				JOIN Eris.dbo.Employee ON Eris.dbo.Employee.Id = Eris.dbo.CompEmp.EmployeeId
			WHERE
				Li.Month > Eris.dbo.List.Month AND Em.Id = Eris.dbo.List.UserId AND Eris.dbo.Employee.Id = Ep.Id
		) != 0
		AND Li.Month != 1
	)
	OR
	(
		vehicle_expenses_previous_month IS NOT NULL
		AND vehicle_expenses_previous_month != 0
		AND Li.Month = 1
	)
ORDER BY
	NationalCode





SELECT
	DISTINCT Em.NationalCode, Li.Id
FROM
	Eris.dbo.Salary
	JOIN Eris.dbo.List AS Li ON Eris.dbo.Salary.ListId = Li.Id
	JOIN Eris.dbo.Employer AS Em ON Em.Id = Li.UserId
	JOIN Eris.dbo.CompEmp AS Cm ON Cm.Id = Eris.dbo.Salary.CompEmpId
	JOIN Eris.dbo.Employee AS Ep ON Cm.EmployeeId = Ep.Id
	JOIN ErisHelper.dbo.EmployerFilter ON ErisHelper.dbo.EmployerFilter.tin = Em.NationalCode
WHERE
	(
		(
			non_cash_year_to_last_month IS NULL
			OR non_cash_year_to_last_month = 0
		)
		AND
		(
			SELECT SUM(IIF(non_cash_payments IS NULL, 0, non_cash_payments))
			FROM Eris.dbo.Salary
				JOIN Eris.dbo.List ON Eris.dbo.Salary.ListId = Eris.dbo.List.Id
				JOIN Eris.dbo.CompEmp ON Eris.dbo.Salary.CompEmpId = Eris.dbo.CompEmp.Id
				JOIN Eris.dbo.Employee ON Eris.dbo.Employee.Id = Eris.dbo.CompEmp.EmployeeId
			WHERE
				Li.Month > Eris.dbo.List.Month AND Em.Id = Eris.dbo.List.UserId AND Eris.dbo.Employee.Id = Ep.Id
		) != 0
		AND Li.Month != 1
	)
	OR
	(
		non_cash_year_to_last_month IS NOT NULL
		AND non_cash_year_to_last_month != 0
		AND Li.Month = 1
	)
ORDER BY
	NationalCode





SELECT
	DISTINCT Em.NationalCode, Li.Id
FROM
	Eris.dbo.Salary
	JOIN Eris.dbo.List AS Li ON Eris.dbo.Salary.ListId = Li.Id
	JOIN Eris.dbo.Employer AS Em ON Em.Id = Li.UserId
	JOIN Eris.dbo.CompEmp AS Cm ON Cm.Id = Eris.dbo.Salary.CompEmpId
	JOIN Eris.dbo.Employee AS Ep ON Cm.EmployeeId = Ep.Id
	JOIN ErisHelper.dbo.EmployerFilter ON ErisHelper.dbo.EmployerFilter.tin = Em.NationalCode
WHERE
	(
		(
			sum_exemptions_deductions_to_last_month IS NULL
			OR sum_exemptions_deductions_to_last_month = 0
		)
		AND
		(
			SELECT SUM(IIF(total_exemption_deduction IS NULL, 0, total_exemption_deduction))
			FROM Eris.dbo.Salary
				JOIN Eris.dbo.List ON Eris.dbo.Salary.ListId = Eris.dbo.List.Id
				JOIN Eris.dbo.CompEmp ON Eris.dbo.Salary.CompEmpId = Eris.dbo.CompEmp.Id
				JOIN Eris.dbo.Employee ON Eris.dbo.Employee.Id = Eris.dbo.CompEmp.EmployeeId
			WHERE
				Li.Month > Eris.dbo.List.Month AND Em.Id = Eris.dbo.List.UserId AND Eris.dbo.Employee.Id = Ep.Id
		) != 0
		AND Li.Month != 1
	)
	OR
	(
		sum_exemptions_deductions_to_last_month IS NOT NULL
		AND sum_exemptions_deductions_to_last_month != 0
		AND Li.Month = 1
	)
ORDER BY
	NationalCode





SELECT
	DISTINCT Em.NationalCode, Li.Id, Li.KarkonanNo, Ep.Id, NumberRealWorkedMonth
FROM
	Eris.dbo.Salary
	JOIN Eris.dbo.List AS Li ON Eris.dbo.Salary.ListId = Li.Id
	JOIN Eris.dbo.Employer AS Em ON Em.Id = Li.UserId
	JOIN Eris.dbo.CompEmp AS Cm ON Cm.Id = Eris.dbo.Salary.CompEmpId
	JOIN Eris.dbo.Employee AS Ep ON Cm.EmployeeId = Ep.Id
	JOIN ErisHelper.dbo.EmployerFilter ON ErisHelper.dbo.EmployerFilter.tin = Em.NationalCode
WHERE
	(
		(
			continous_tax_year_to_previous_month IS NULL
			OR continous_tax_year_to_previous_month = 0
		)
		AND
		(
			SELECT SUM(IIF(tax_continous_wages_salary_current_month IS NULL, 0, tax_continous_wages_salary_current_month))
			FROM Eris.dbo.Salary
				JOIN Eris.dbo.List ON Eris.dbo.Salary.ListId = Eris.dbo.List.Id
				JOIN Eris.dbo.CompEmp ON Eris.dbo.Salary.CompEmpId = Eris.dbo.CompEmp.Id
				JOIN Eris.dbo.Employee ON Eris.dbo.Employee.Id = Eris.dbo.CompEmp.EmployeeId
			WHERE
				Li.Month > Eris.dbo.List.Month AND Em.Id = Eris.dbo.List.UserId AND Eris.dbo.Employee.Id = Ep.Id
		) != 0
		AND Li.Month != 1
	)
	OR
	(
		continous_tax_year_to_previous_month IS NOT NULL
		AND continous_tax_year_to_previous_month != 0
		AND Li.Month = 1
	)
ORDER BY
	NationalCode





SELECT
	DISTINCT Em.NationalCode, Li.Id
FROM
	Eris.dbo.Salary
	JOIN Eris.dbo.List AS Li ON Eris.dbo.Salary.ListId = Li.Id
	JOIN Eris.dbo.Employer AS Em ON Em.Id = Li.UserId
	JOIN Eris.dbo.CompEmp AS Cm ON Cm.Id = Eris.dbo.Salary.CompEmpId
	JOIN Eris.dbo.Employee AS Ep ON Cm.EmployeeId = Ep.Id
	JOIN ErisHelper.dbo.EmployerFilter ON ErisHelper.dbo.EmployerFilter.tin = Em.NationalCode
WHERE
	(
		(
			total_uncontinous_income_year_up_previous_month IS NULL
			OR total_uncontinous_income_year_up_previous_month = 0
		)
		AND
		(
			SELECT SUM(IIF(total_uncontinous_payments IS NULL, 0, total_uncontinous_payments))
			FROM Eris.dbo.Salary
				JOIN Eris.dbo.List ON Eris.dbo.Salary.ListId = Eris.dbo.List.Id
				JOIN Eris.dbo.CompEmp ON Eris.dbo.Salary.CompEmpId = Eris.dbo.CompEmp.Id
				JOIN Eris.dbo.Employee ON Eris.dbo.Employee.Id = Eris.dbo.CompEmp.EmployeeId
			WHERE
				Li.Month > Eris.dbo.List.Month AND Em.Id = Eris.dbo.List.UserId AND Eris.dbo.Employee.Id = Ep.Id
		) != 0
		AND Li.Month != 1
	)
	OR
	(
		total_uncontinous_income_year_up_previous_month IS NOT NULL
		AND total_uncontinous_income_year_up_previous_month != 0
		AND Li.Month = 1
	)
ORDER BY
	NationalCode





SELECT
	DISTINCT Em.NationalCode, Li.Id
FROM
	Eris.dbo.Salary
	JOIN Eris.dbo.List AS Li ON Eris.dbo.Salary.ListId = Li.Id
	JOIN Eris.dbo.Employer AS Em ON Em.Id = Li.UserId
	JOIN Eris.dbo.CompEmp AS Cm ON Cm.Id = Eris.dbo.Salary.CompEmpId
	JOIN Eris.dbo.Employee AS Ep ON Cm.EmployeeId = Ep.Id
	JOIN ErisHelper.dbo.EmployerFilter ON ErisHelper.dbo.EmployerFilter.tin = Em.NationalCode
WHERE
	(
		(
			non_cash_uncontinous_benefit_year_up_previous_month IS NULL
			OR non_cash_uncontinous_benefit_year_up_previous_month = 0
		)
		AND
		(
			SELECT SUM(IIF(non_cash_uncontinous_benefit_current_month IS NULL, 0, non_cash_uncontinous_benefit_current_month))
			FROM Eris.dbo.Salary
				JOIN Eris.dbo.List ON Eris.dbo.Salary.ListId = Eris.dbo.List.Id
				JOIN Eris.dbo.CompEmp ON Eris.dbo.Salary.CompEmpId = Eris.dbo.CompEmp.Id
				JOIN Eris.dbo.Employee ON Eris.dbo.Employee.Id = Eris.dbo.CompEmp.EmployeeId
			WHERE
				Li.Month > Eris.dbo.List.Month AND Em.Id = Eris.dbo.List.UserId AND Eris.dbo.Employee.Id = Ep.Id
		) != 0
		AND Li.Month != 1
	)
	OR
	(
		non_cash_uncontinous_benefit_year_up_previous_month IS NOT NULL
		AND non_cash_uncontinous_benefit_year_up_previous_month != 0
		AND Li.Month = 1
	)
ORDER BY
	NationalCode





SELECT
	DISTINCT Em.NationalCode, Li.Id
FROM
	Eris.dbo.Salary
	JOIN Eris.dbo.List AS Li ON Eris.dbo.Salary.ListId = Li.Id
	JOIN Eris.dbo.Employer AS Em ON Em.Id = Li.UserId
	JOIN Eris.dbo.CompEmp AS Cm ON Cm.Id = Eris.dbo.Salary.CompEmpId
	JOIN Eris.dbo.Employee AS Ep ON Cm.EmployeeId = Ep.Id
	JOIN ErisHelper.dbo.EmployerFilter ON ErisHelper.dbo.EmployerFilter.tin = Em.NationalCode
WHERE
	(
		(
			tax_uncontinous_income_the_year_up_previous_month IS NULL
			OR tax_uncontinous_income_the_year_up_previous_month = 0
		)
		AND
		(
			SELECT SUM(IIF(total_tax_uncontinous_income IS NULL, 0, total_tax_uncontinous_income))
			FROM Eris.dbo.Salary
				JOIN Eris.dbo.List ON Eris.dbo.Salary.ListId = Eris.dbo.List.Id
				JOIN Eris.dbo.CompEmp ON Eris.dbo.Salary.CompEmpId = Eris.dbo.CompEmp.Id
				JOIN Eris.dbo.Employee ON Eris.dbo.Employee.Id = Eris.dbo.CompEmp.EmployeeId
			WHERE
				Li.Month > Eris.dbo.List.Month AND Em.Id = Eris.dbo.List.UserId AND Eris.dbo.Employee.Id = Ep.Id
		) != 0
		AND Li.Month != 1
	)
	OR
	(
		tax_uncontinous_income_the_year_up_previous_month IS NOT NULL
		AND tax_uncontinous_income_the_year_up_previous_month != 0
		AND Li.Month = 1
	)
ORDER BY
	NationalCode





SELECT
	DISTINCT Em.NationalCode, Li.Id
FROM
	Eris.dbo.Salary
	JOIN Eris.dbo.List AS Li ON Eris.dbo.Salary.ListId = Li.Id
	JOIN Eris.dbo.Employer AS Em ON Em.Id = Li.UserId
	JOIN Eris.dbo.CompEmp AS Cm ON Cm.Id = Eris.dbo.Salary.CompEmpId
	JOIN Eris.dbo.Employee AS Ep ON Cm.EmployeeId = Ep.Id
	JOIN ErisHelper.dbo.EmployerFilter ON ErisHelper.dbo.EmployerFilter.tin = Em.NationalCode
WHERE
	(
		(total_bonus_start_year_to_previous_month IS NULL
		OR total_bonus_start_year_to_previous_month = 0)
		AND (
			SELECT SUM(IIF(year_end_bonus_new_year IS NULL, 0, year_end_bonus_new_year))
			FROM Eris.dbo.Salary
				JOIN Eris.dbo.List ON Eris.dbo.Salary.ListId = Eris.dbo.List.Id
				JOIN Eris.dbo.CompEmp ON Eris.dbo.Salary.CompEmpId = Eris.dbo.CompEmp.Id
				JOIN Eris.dbo.Employee ON Eris.dbo.Employee.Id = Eris.dbo.CompEmp.EmployeeId
			WHERE
				Li.Month > Eris.dbo.List.Month AND Em.Id = Eris.dbo.List.UserId AND Eris.dbo.Employee.Id = Ep.Id
		) != 0
		AND Li.Month != 1
	)
	OR
	(
		total_bonus_start_year_to_previous_month IS NOT NULL
		AND total_bonus_start_year_to_previous_month != 0
		AND Li.Month = 1
	)
ORDER BY
	NationalCode





SELECT
	DISTINCT Em.NationalCode, Li.Id
FROM
	Eris.dbo.Salary
	JOIN Eris.dbo.List AS Li ON Eris.dbo.Salary.ListId = Li.Id
	JOIN Eris.dbo.Employer AS Em ON Em.Id = Li.UserId
	JOIN Eris.dbo.CompEmp AS Cm ON Cm.Id = Eris.dbo.Salary.CompEmpId
	JOIN Eris.dbo.Employee AS Ep ON Cm.EmployeeId = Ep.Id
	JOIN ErisHelper.dbo.EmployerFilter ON ErisHelper.dbo.EmployerFilter.tin = Em.NationalCode
WHERE
	(
		(tax_bonus_from_first_year_to_month_before IS NULL
		OR tax_bonus_from_first_year_to_month_before = 0)
		AND (
			SELECT SUM(IIF(tax_continous_uncontinous_income IS NULL, 0, tax_continous_uncontinous_income))
			FROM Eris.dbo.Salary
				JOIN Eris.dbo.List ON Eris.dbo.Salary.ListId = Eris.dbo.List.Id
				JOIN Eris.dbo.CompEmp ON Eris.dbo.Salary.CompEmpId = Eris.dbo.CompEmp.Id
				JOIN Eris.dbo.Employee ON Eris.dbo.Employee.Id = Eris.dbo.CompEmp.EmployeeId
			WHERE
				Li.Month > Eris.dbo.List.Month AND Em.Id = Eris.dbo.List.UserId AND Eris.dbo.Employee.Id = Ep.Id
		) != 0
		AND Li.Month != 1
	)
	OR
	(
		tax_bonus_from_first_year_to_month_before IS NOT NULL
		AND tax_bonus_from_first_year_to_month_before != 0
		AND Li.Month = 1
	)
ORDER BY
	NationalCode





SELECT
	DISTINCT Em.NationalCode, Li.Id
FROM
	Eris.dbo.Salary
	JOIN Eris.dbo.List AS Li ON Eris.dbo.Salary.ListId = Li.Id
	JOIN Eris.dbo.Employer AS Em ON Em.Id = Li.UserId
	JOIN Eris.dbo.CompEmp AS Cm ON Cm.Id = Eris.dbo.Salary.CompEmpId
	JOIN Eris.dbo.Employee AS Ep ON Cm.EmployeeId = Ep.Id
	JOIN ErisHelper.dbo.EmployerFilter ON ErisHelper.dbo.EmployerFilter.tin = Em.NationalCode
WHERE
	(
		(
			total_previous_compensation_unused_leave_from_beginig_year_up IS NULL
			OR total_previous_compensation_unused_leave_from_beginig_year_up = 0
		)
		AND (
			SELECT SUM(IIF(unused_leave_payments_amount IS NULL, 0, unused_leave_payments_amount))
			FROM Eris.dbo.Salary
				JOIN Eris.dbo.List ON Eris.dbo.Salary.ListId = Eris.dbo.List.Id
				JOIN Eris.dbo.CompEmp ON Eris.dbo.Salary.CompEmpId = Eris.dbo.CompEmp.Id
				JOIN Eris.dbo.Employee ON Eris.dbo.Employee.Id = Eris.dbo.CompEmp.EmployeeId
			WHERE
				Li.Month > Eris.dbo.List.Month AND Em.Id = Eris.dbo.List.UserId AND Eris.dbo.Employee.Id = Ep.Id
		) != 0
		AND Li.Month != 1
	)
	OR
	(
		total_previous_compensation_unused_leave_from_beginig_year_up IS NOT NULL
		AND total_previous_compensation_unused_leave_from_beginig_year_up != 0
		AND Li.Month = 1
	)
ORDER BY
	NationalCode





SELECT
	DISTINCT Em.NationalCode, Li.Id, Ep.Id
FROM
	Eris.dbo.Salary
	JOIN Eris.dbo.List AS Li ON Eris.dbo.Salary.ListId = Li.Id
	JOIN Eris.dbo.Employer AS Em ON Em.Id = Li.UserId
	JOIN Eris.dbo.CompEmp AS Cm ON Cm.Id = Eris.dbo.Salary.CompEmpId
	JOIN Eris.dbo.Employee AS Ep ON Cm.EmployeeId = Ep.Id
	JOIN ErisHelper.dbo.EmployerFilter ON ErisHelper.dbo.EmployerFilter.tin = Em.NationalCode
WHERE
	(
		(annual_tax_up_month_before_compensation_unused_leave IS NULL
		OR annual_tax_up_month_before_compensation_unused_leave = 0)
		AND (
			SELECT SUM(IIF(tax_continous_uncontinous_income_bonus IS NULL, 0, tax_continous_uncontinous_income_bonus))
			FROM Eris.dbo.Salary
				JOIN Eris.dbo.List ON Eris.dbo.Salary.ListId = Eris.dbo.List.Id
				JOIN Eris.dbo.CompEmp ON Eris.dbo.Salary.CompEmpId = Eris.dbo.CompEmp.Id
				JOIN Eris.dbo.Employee ON Eris.dbo.Employee.Id = Eris.dbo.CompEmp.EmployeeId
			WHERE
				Li.Month > Eris.dbo.List.Month AND Em.Id = Eris.dbo.List.UserId AND Eris.dbo.Employee.Id = Ep.Id
		) != 0
		AND Li.Month != 1
	)
	OR
	(
		annual_tax_up_month_before_compensation_unused_leave IS NOT NULL
		AND annual_tax_up_month_before_compensation_unused_leave != 0
		AND Li.Month = 1
	)
ORDER BY
	NationalCode