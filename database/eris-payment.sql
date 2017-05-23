select
	'' as ExternalReferenceId, 'C' as CT_DT,
	li.Mablagh as Amount, ef.office as OfficeId, tm.internal_id as TaxPayerId,
	'001' as BranchId, 'WST' as TaxType, 'TAXLB' as LiabilityType,
	li.Year as TaxYear, li.Month as Period, li.Ghabz_SN as Description,
	right('0000' + cast((li.PaidDate/10000) as varchar), 4) + '-' +
	right('00' + cast((((li.PaidDate/100)%100)) as varchar), 2) + '-' +
	right('00' + cast(((li.PaidDate%100)) as varchar), 2) as ValueDate
from
	List as li
	join Employer as em on em.id = li.userid
	join ErisHelper.dbo.EmployerFilter as ef on ef.tin = em.NationalCode
	join ErisHelper.dbo.tmp as tm on tm.nationalcode = ef.tin
order by
	TaxPayerId, Period
offset (2700) rows fetch next (3600) rows only
for xml PATH('TACExtPaymentTransaction'), ROOT('Data')