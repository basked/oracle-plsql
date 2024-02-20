
WITH setting AS
 (SELECT 1 ordernum,
			978 AS curcode,
			'EUR' AS currname
  FROM dual
  UNION
  SELECT 2 ordernum,
			840 AS curcode,
			'USD' AS currname
  FROM dual),
prepare_data AS
 (
 -- кредиты мульты 
 
  select  1100 as contractid,1  as contract_number, 1 as contracttype , 933 as currcode,to_date('01.03.2023','dd.mm.yyyy') as contractdate, 1 as is_check_99112 from dual union
  select  1234 as contractid,22 as contract_number, 1 as contracttype , 933 as currcode,to_date('01.03.2018','dd.mm.yyyy') as contractdate, 0 as is_check_99112 from dual union
  select  1235 as contractid,33 as contract_number, 1 as contracttype , 978 as currcode,to_date('01.03.2019','dd.mm.yyyy') as contractdate, 0 as is_check_99112 from dual union
  select  1236 as contractid,44 as contract_number, 1 as contracttype , 840 as currcode,to_date('01.03.2020','dd.mm.yyyy') as contractdate, 0 as is_check_99112 from dual union
  select  1237 as contractid,55 as contract_number, 1 as contracttype , 978 as currcode,to_date('01.03.2021','dd.mm.yyyy') as contractdate, 0 as is_check_99112 from dual union
  select  1238 as contractid,66 as contract_number, 1 as contracttype , 647 as currcode,to_date('01.03.2022','dd.mm.yyyy') as contractdate, 0 as is_check_99112 from dual union 
-- кредиты не мульты
  select  1200 as contractid,2  as contract_number, 1 as contracttype , 933 as currcode,to_date('15.02.2023','dd.mm.yyyy') as contractdate, 1 as is_check_99112 from dual union
  select  1230 as contractid,3  as contract_number, 1 as contracttype , 647 as currcode,to_date('01.03.2023','dd.mm.yyyy') as contractdate, 1 as is_check_99112 from dual union
  select  1187 as contractid,4  as contract_number, 1 as contracttype , 840 as currcode,to_date('01.01.2023','dd.mm.yyyy') as contractdate, 1 as is_check_99112 from dual union

 --Овердрафт
  select  1301 as contractid,5  as contract_number, 28 as contracttype , 933 as currcode,to_date('19.03.2023','dd.mm.yyyy') as contractdate, 1 as is_check_99112 from dual union
  select  1302 as contractid,6  as contract_number, 28 as contracttype , 647 as currcode,to_date('20.03.2023','dd.mm.yyyy') as contractdate, 0 as is_check_99112 from dual union
  select  1303 as contractid,7  as contract_number, 28 as contracttype , 840 as currcode,to_date('21.03.2023','dd.mm.yyyy') as contractdate, 1 as is_check_99112 from dual union 

 --факторинг
  select  1401 as contractid,8  as contract_number, 2 as contracttype , 933 as currcode,to_date('19.02.2023','dd.mm.yyyy') as contractdate, 1 as is_check_99112 from dual union
  select  1304 as contractid,9  as contract_number, 2 as contracttype , 647 as currcode,to_date('20.02.2023','dd.mm.yyyy') as contractdate, 1 as is_check_99112 from dual 
 
),

Cr_ContractsRelations AS (

 select  1234 as contractid,1100 as groupid, 102 as relationtype from dual  union
 select  1235 as contractid,1100 as groupid, 102 as relationtype from dual  union
 select  1236 as contractid,1100 as groupid, 102 as relationtype from dual  union
 select  1237 as contractid,1100 as groupid, 102 as relationtype from dual  union
 select  1238 as contractid,1100 as groupid, 102 as relationtype from dual     ),

Cr_Contracts  AS (
SELECT * 
FROM prepare_data pd
WHERE pd.is_check_99112=1
),
cr_contracts_multi AS (
SELECT *
FROM   prepare_data pd  
WHERE  pd.contractid IN (  SELECT ContractID
                           FROM Cr_ContractsRelations r
                           WHERE RelationType = 102 
                                 AND (ContractID = pd.ContractID OR GroupID = pd.ContractID)
                                 AND EXISTS (SELECT 1 
                                             FROM cr_contracts 
                                             WHERE contractid IN (r.contractid,r.GroupID ))
                           UNION ALL
                           SELECT GroupID
                           FROM Cr_ContractsRelations r
                           WHERE RelationType = 102  
                                 AND (ContractID = pd.ContractID OR GroupID = pd.ContractID)
                                 AND EXISTS (SELECT 1 
                                             FROM cr_contracts 
                                             WHERE contractid IN (r.contractid,r.GroupID ))
                                 )
                                 
                                 
                                 ) 
 /*TEST MULTI */
SELECT cr.*, 0 AS is_multi
FROM cr_contracts cr 
WHERE  NOT EXISTS (SELECT 1 
                   FROM cr_contracts_multi 
                   WHERE contractid=cr.contractid ) 
UNION
SELECT crm.*, 1 AS is_multi 
FROM cr_contracts_multi crm  


/* -- TEST ORDERS 
SELECT cr.*
FROM cr_contracts cr
WHERE cr.is_check_99112 =1 
ORDER BY CASE
				WHEN contracttype = 29 THEN
				 2
				WHEN contracttype = 26 THEN
				 3
				ELSE
				 contracttype
			END
   */
