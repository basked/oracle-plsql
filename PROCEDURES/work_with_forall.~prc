-- WORK WITH BULK COLLECT
CREATE OR REPLACE PROCEDURE work_with_forall IS
  error_columns EXCEPTION;
  
  
  PROCEDURE add_field_salary2 IS
  
    sql_dml VARCHAR2(100) := 'ALTER TABLE EMPLOYEES ADD SALARY2 VARCHAR(50)';
  BEGIN
    EXECUTE IMMEDIATE sql_dml;
    dbms_output.put_line('ADD SALARY2');
  EXCEPTION
    WHEN OTHERS THEN
      dbms_output.put_line('Ошибка при добавлении поля SALARY2 ' ||
                           SQLERRM);
      RAISE error_columns;
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
BEGIN
  BEGIN
    add_field_salary2;
  EXCEPTION
    WHEN error_columns THEN
      dbms_output.put_line('Обработка ошибки возникшей при добавлении');
      del_field_salary2;
  END;
  del_field_salary2;
END;
/
