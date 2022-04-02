/*
 Создаем таблицу на основе таблицы All_Objects
 Drop TABLE my_all_objects
*/
CREATE TABLE my_all_objects AS 
 SELECT * FROM All_Objects
UNION 
SELECT * FROM All_Objects
UNION 
 SELECT * FROM All_Objects
UNION 
SELECT * FROM All_Objects 
UNION 
SELECT * FROM All_Objects
UNION 
SELECT * FROM All_Objects
---------------------------------
/*
 Заполняем её данными с сомой же таблицы
*/
DECLARE 
 sql_text VARCHAR2(500) := 'insert into my_all_objects select * from all_objects';
BEGIN 
 FOR i IN 1..10 LOOP
    EXECUTE IMMEDIATE sql_text;
   END LOOP; 
   COMMIT; 
END; 
---------------------------------
-- Смотрим кол-во вставленных строк 

SELECT COUNT(*)
FROM my_all_objects;

SELECT * FROM my_all_objects --WHERE  owner='SYST'

SELECT owner, COUNT(*) AS cnt_obj FROM my_all_objects /* WHERE  owner='SYST'*/ GROUP BY owner ORDER BY 1;


/*
 Создаем простое представление
*/
--DROP  VIEW v_all_objects_agg
CREATE VIEW v_all_objects_agg AS
  SELECT owner, COUNT(*) AS cnt_obj
    FROM my_all_objects
   GROUP BY owner
   ORDER BY owner;
SELECT * FROM v_all_objects_agg ;

/*
 Создаем материализованное представление,
  которое будет обновляться при каждом комите в таблице my_all_objects
*/
--DROP MATERIALIZED VIEW mv_all_objects_agg   
 -- V1
CREATE MATERIALIZED VIEW mv_all_objects_agg 
 BUILD IMMEDIATE  
 REFRESH ON COMMIT    -- обновление данных после коммита на таблице my_all_objects
 ENABLE QUERY REWRITE -- перестраивает запрос
 AS
 SELECT   owner, COUNT(*) AS cnt_obj
    FROM my_all_objects
   GROUP BY owner
   ORDER BY owner  ;
   -- V2 без настроек 
CREATE MATERIALIZED VIEW mv_all_objects_agg  AS
 SELECT owner, COUNT(*) AS cnt_obj
    FROM my_all_objects
   GROUP BY owner
   ORDER BY owner;
 
 
-- Смотрим на время выполнения запроса 
SELECT * FROM mv_all_objects_agg ; 
-- втавим строку для анализа    
INSERT INTO my_all_objects(OWNER, OBJECT_NAME,  OBJECT_ID,  TIMESTAMP, STATUS)
VALUES ('BASKET', 'I_OBJ5',    40,  40,  'INDEX')     

COMMIT;


-- Query
SELECT owner, COUNT(*) AS cnt_obj FROM my_all_objects WHERE owner = 'BASKET' GROUP BY owner ORDER BY 1;
-- Views
SELECT * FROM  v_all_objects_agg WHERE owner = 'BASKET'

--Materialized views
SELECT * FROM  mv_all_objects_agg --WHERE owner = 'BASKET'
 
