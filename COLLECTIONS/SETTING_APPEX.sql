-- подключаемся под sys@xe as SYSDBA
-- https://oracle-base.com/articles/12c/multitenant-connecting-to-cdb-and-pdb-12cr1
--alter session set container=xepdb1;

--
/*
ДОБАВИЛ в TNSORA

CICD =
  (DESCRIPTION =
    (ADDRESS_LIST =
      (ADDRESS = (PROTOCOL = TCP)(HOST = basked.XE.host)(PORT = 1521))
    )
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = xepdb1)
    )
  )  
*/

SELECT name, pdb
FROM   v$services
ORDER BY name;

select username from all_users where username like '%%';

SELECT *
FROM  User_Source us
WHERE UPPER(us.NAME) LIKE UPPER('%apex')
ORDER BY name;



--- --Смена пользователя APEX
ALTER SESSION SET CURRENT_SCHEMA = APEX_220100;


SELECT   t.*, ROWID
FROM   wwv_flow_fnd_user t
--WHERE  user_name = 'ADMIN'
ORDER BY last_update_date DESC;
