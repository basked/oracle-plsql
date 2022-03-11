-- ОБЯЪЯВЛЯЕМ ГЛОБАЛЬНЫЕ ТИПЫ
CREATE OR REPLACE TYPE fio_list_ot AS OBJECT
(
  fio VARCHAR2(500)
)

CREATE OR REPLACE TYPE fio_ntt IS TABLE OF VARCHAR2(500);--emp_list_ot;

CREATE OR REPLACE TYPE fio_vat IS VARRAY(20) OF VARCHAR2(500);--emp_list_ot;

DROP TABLE tab_with_collect;

-- СОЗДАЕМ ТАБЛИЦУ С ДВУМЯ ВИДАМИ СТОЛБЦОВ ТИПА КОЛЛЕКЦИИ
CREATE TABLE tab_with_collect(ID NUMBER CONSTRAINT tab_with_collect_pk PRIMARY KEY, job_id VARCHAR2(20) CONSTRAINT tab_with_collect_fk REFERENCES jobs, fio_nt fio_ntt, fio_at fio_vat) NESTED TABLE fio_nt store AS tab_with_fio;

--ВСТАВЛЯЕМ ДАННЫЕ
 INSERT INTO tab_with_collect
  (id, job_id, fio_nt, fio_at)
VALUES
  (1, 'FI_MGR', fio_ntt('nt_tek'), fio_vat('at_tek'));
----
 INSERT INTO tab_with_collect
  (id, job_id, fio_nt, fio_at)
VALUES
  (2, 'FI_MGR', fio_ntt('nt_bas'), fio_vat('at_bas'));
----
 INSERT INTO tab_with_collect
  (id, job_id, fio_nt, fio_at)
VALUES
  (3, 'FI_MGR', fio_ntt('nt_bas', 'nt_tek'), fio_vat('at_bas', 'at_tek'));
--- 
--Выборка данных
SELECT id,
       job_id,
       (SELECT listagg(COLUMN_VALUE, ', ') WITHIN GROUP(ORDER BY 1)
          FROM TABLE(t.FIO_NT)) AS FIO_NT,
       (SELECT listagg(COLUMN_VALUE, ', ') WITHIN GROUP(ORDER BY 1)
          FROM TABLE(t.FIO_AT)) AS FIO_AT

  FROM (SELECT * FROM tab_with_collect) t
