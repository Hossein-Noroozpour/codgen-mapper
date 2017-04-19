USE Eris;
SELECT List.Id, List.UserId, Employer.NationalCode
FROM
    List
    JOIN Employer ON List.UserId = Employer.Id
WHERE
	((List.RoznameDate / 100) % 100) - ((List.Date_Ghabz/ 100) % 100) < 2
	and List.Date_Ghabz IS NOT NULL
	AND List.PaidDate   IS NOT NULL
	AND List.RoznameDate IS NOT NULL and list.hozeh like '3625%'
	AND List.UserId in (
		SELECT emp.Id
		FROM
		    Employer as emp
		WHERE
			(
				select
					count(list.Id)
				from
					List
				where
					list.UserId = emp.Id
					and ((List.RoznameDate / 100) % 100) - ((List.Date_Ghabz/ 100) % 100) < 2
					and List.Date_Ghabz IS NOT NULL
					AND List.PaidDate   IS NOT NULL
					AND List.RoznameDate IS NOT NULL and list.hozeh like '3625%') = 6
			and (select count(distinct list.Month) from List where List.UserId = emp.Id and list.hozeh like '3625%') = 6
			and (select count(list.Id) from List where List.UserId = emp.Id and list.hozeh like '3625%') = 6
			and (select max(list.month) from List where List.UserId = emp.Id and list.hozeh like '3625%') = 6
	)
ORDER BY
	List.UserId, List.Id