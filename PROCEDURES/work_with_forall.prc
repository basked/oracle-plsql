﻿-- WORK WITH BULK COLLECT
CREATE OR REPLACE PROCEDURE work_with_forall IS
  error_add_columns EXCEPTION;

  PROCEDURE add_field_salary2 IS
  
    sql_dml VARCHAR2(100) := 'ALTER TABLE EMPLOYEES ADD SALARY2 VARCHAR(50)';
  BEGIN
    EXECUTE IMMEDIATE sql_dml;
    dbms_output.put_line('ADD SALARY2');
  EXCEPTION
    WHEN OTHERS THEN
      dbms_output.put_line('Ошибка при добавлении поля SALARY2 ' ||
                           SQLERRM);
      RAISE error_add_columns;
  END;

  PROCEDURE del_field_salary2 IS
    sql_dml VARCHAR2(100) := 'ALTER TABLE EMPLOYEES DROP COLUMN SALARY2';
  BEGIN
    EXECUTE IMMEDIATE sql_dml;
    dbms_output.put_line('DROP SALARY2');
  EXCEPTION
    WHEN OTHERS THEN
      dbms_output.put_line('Ошибка при удалении поля SALARY2 ' || SQLERRM);
  END;

  PROCEDURE select_empl(source_tbl IN VARCHAR2) IS
    empl_cursor INTEGER;
    ignore      INTEGER;
    fn  VARCHAR2(30);
  BEGIN
    -- Prepare a cursor to select from the source table: 
    empl_cursor := dbms_sql.open_cursor;
    DBMS_SQL.PARSE(empl_cursor,
                   'SELECT first_name  FROM ' || source_tbl,
                   DBMS_SQL.NATIVE);
    DBMS_SQL.DEFINE_COLUMN(empl_cursor, 1, fn,50);
    ignore := DBMS_SQL.EXECUTE(empl_cursor);
    
    LOOP
      IF DBMS_SQL.FETCH_ROWS(empl_cursor) > 0 THEN
        -- get column values of the row 
       DBMS_SQL.COLUMN_VALUE(empl_cursor, 1, fn);
       Dbms_Output.put_line(fn);
      END IF;
    END LOOP;
  EXCEPTION
    WHEN OTHERS THEN
      IF DBMS_SQL.IS_OPEN(empl_cursor) THEN
        DBMS_SQL.CLOSE_CURSOR(empl_cursor);
      END IF;
      --RAISE;
  END;

BEGIN
  BEGIN
    add_field_salary2;
  EXCEPTION
    WHEN error_add_columns THEN
      dbms_output.put_line('Обработка ошибки возникшей при добавлении');
      del_field_salary2;
  END;
  del_field_salary2;
  select_empl('employees');

END;
/
