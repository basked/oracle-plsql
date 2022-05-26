WITH q1 AS
 (SELECT 1111 client_code,
			3154 + LEVEL AS accbalance
  FROM dual
  CONNECT BY LEVEL < 5),
q2 AS
 (SELECT 1111 client_code,
			3154 AS accbalance
  FROM dual
  CONNECT BY LEVEL < 4),
q3 AS
 (SELECT 3333 client_code,
			6127 AS accbalance
  FROM dual),
q4 AS
 (SELECT 4444 client_code,
			6157 AS accbalance
  FROM dual),
res AS
 (SELECT q1.*
  FROM q1
  UNION ALL
  SELECT q2.*
  FROM q2
  UNION ALL
  SELECT q3.*
  FROM q3
  UNION ALL
  SELECT q4.*
  FROM q4)
/*SELECT CASE
          WHEN res.accbalance IN (3155, 3156, 3157, 3158, 3159, 6127, 6157) THEN  
       END
FROM res
*/

SELECT *
FROM res
WHERE client_code = CASE
			WHEN client_code <> &v_client_code THEN
			 &v_client_code
			WHEN client_code = &v_client_code THEN
			 client_code
			ELSE
			 client_code
		END
		AND (&v_client_type = 2 AND (accbalance BETWEEN 3155 AND 3159 OR accbalance = 6127 OR accbalance = 6157))
		OR (&v_client_type = 1 AND accbalance = 3154)
