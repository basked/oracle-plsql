﻿WITH q AS
 (SELECT LEVEL AS ID,
			'name' || LEVEL AS NAME
  FROM dual
  CONNECT BY LEVEL < 10
  
  ),
t AS
 (SELECT *
  FROM q
  WHERE q.id > 7)
SELECT *
FROM t
UNION
SELECT 99 AS ID,
		 'name99' AS NAME
FROM t
HAVING COUNT (*) = 0
