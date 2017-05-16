SELECT Li.Id, Li.UserId, Em.NationalCode
FROM
    Eris.dbo.List AS Li
    JOIN Eris.dbo.Employer AS Em ON Li.UserId = Em.Id
WHERE
	((
		Li.Date_Ghabz   IS NULL
		AND Li.PaidDate IS NULL
	)
	OR
	(
		((Li.Date_Ghabz/ 100) % 100) - ((Li.RoznameDate / 100) % 100) < 2
		AND Li.Date_Ghabz IS NOT NULL
		AND Li.PaidDate   IS NOT NULL
		AND Li.RoznameDate IS NOT NULL
	))
	AND Li.UserId IN (
        SELECT Emp.Id
        FROM
            Eris.dbo.Employer AS Emp
        WHERE
            (
                SELECT
                    COUNT(Lis.Id)
                FROM
                    Eris.dbo.List AS Lis
                WHERE
                    Lis.UserId = Emp.Id
					AND
					((
						Lis.Date_Ghabz   IS NULL
						AND Lis.PaidDate IS NULL
					)
					OR
					(
						((Lis.Date_Ghabz/ 100) % 100) - ((Lis.RoznameDate / 100) % 100) < 2
						AND Lis.Date_Ghabz  IS NOT NULL
						AND Lis.PaidDate    IS NOT NULL
						AND Lis.RoznameDate IS NOT NULL
					))
            ) = 12
            AND (
                SELECT COUNT(DISTINCT Li3.Month)
                FROM Eris.dbo.List AS Li3
                WHERE
                    Li3.UserId = Emp.Id
                    --AND Li3.hozeh LIKE '3625%'
            ) = 12
            AND (
                SELECT COUNT(Li3.Id)
                FROM Eris.dbo.List AS Li3
                WHERE
                    Li3.UserId = Emp.Id
                    --AND Li3.hozeh LIKE '3625%'
            ) = 12
            AND (
                SELECT MAX(Li3.Month)
                FROM Eris.dbo.List AS Li3
                WHERE
                    Li3.UserId = Emp.Id
                    --AND Li3.hozeh LIKE '3625%'
            ) = 12
	)
ORDER BY
	Li.UserId, Li.Id

-- No exemption
SELECT Li.Id, Li.UserId, Em.NationalCode
FROM
    Eris.dbo.List AS Li
    JOIN Eris.dbo.Employer AS Em ON Li.UserId = Em.Id
WHERE
	((Li.Date_Ghabz/ 100) % 100) - ((Li.RoznameDate / 100) % 100) < 2
	AND Li.Date_Ghabz IS NOT NULL
	AND Li.PaidDate   IS NOT NULL
	AND Li.RoznameDate IS NOT NULL
	AND Li.UserId IN (
        SELECT Emp.Id
        FROM
            Eris.dbo.Employer AS Emp
        WHERE
            (
                SELECT
                    COUNT(Lis.Id)
                FROM
                    Eris.dbo.List AS Lis
                WHERE
                    Lis.UserId = Emp.Id
					AND ((Lis.Date_Ghabz/ 100) % 100) - ((Lis.RoznameDate / 100) % 100) < 2
					AND Lis.Date_Ghabz  IS NOT NULL
					AND Lis.PaidDate    IS NOT NULL
					AND Lis.RoznameDate IS NOT NULL
            ) = 12
            AND (
                SELECT COUNT(DISTINCT Li3.Month)
                FROM Eris.dbo.List AS Li3
                WHERE
                    Li3.UserId = Emp.Id
            ) = 12
            AND (
                SELECT COUNT(Li3.Id)
                FROM Eris.dbo.List AS Li3
                WHERE
                    Li3.UserId = Emp.Id
            ) = 12
            AND (
                SELECT MAX(Li3.Month)
                FROM Eris.dbo.List AS Li3
                WHERE
                    Li3.UserId = Emp.Id
            ) = 12
	)
ORDER BY
	Li.UserId, Li.Id


SELECT
	Li.RoznameDate,
	Li.Date_Ghabz,
	Li.PaidDate,
	Li.Month,
	Em.NationalCode
FROM
    Eris.dbo.List AS Li
    JOIN Eris.dbo.Employer AS Em ON Li.UserId = Em.Id
ORDER BY
	Em.NationalCode,
	Li.Month