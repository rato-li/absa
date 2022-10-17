use [DAI_Survey_EDA]
go

with cte_asp as (
	select [aspect], [asp_cnt] = count(*)
	FROM [dbo].[df_out]
	where 1=1
	and convert(varchar,[resp_id]) <> [aspect]
	and [aspect] not like convert(varchar,[resp_id])+'%'
	and len([aspect]) > 2
	group by [aspect]
	having count(*) > 100
)
--insert into [dbo].[df_out]
SELECT distinct 
	[RESP_ID] = d.[resp_id]
	,d.[aspect]
	,d.[sentiment]
	,d.[confidence]
FROM [dbo].[df_out_01] d
JOIN [cte_asp] c on c.[aspect] = d.[aspect]
where 1=1
--order by [asp_cnt] desc, [aspect]
-- 448
