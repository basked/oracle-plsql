/*-=1=- ОПИСАНИЕ ОШИБКИ В ОДНОЙ ПРОЦЕДУРЕ*/
DECLARE
  em_bas1 EXCEPTION;
  em_bas2 EXCEPTION;
  PROCEDURE call_error1 IS
  BEGIN
    RAISE em_bas2;
  EXCEPTION
    -- через OR вызывается исключение 
    WHEN em_bas1 OR em_bas2 THEN
      dbms_output.put_line(Dbms_Utility.format_error_backtrace);
  END call_error1;
  ----------------------
  PROCEDURE call_error1_1 IS
  BEGIN
    dbms_output.put_line('call_error1_1');
  END call_error1_1;
  PROCEDURE call_error2 IS
  BEGIN
    call_error1;
    call_error1_1;
  END call_error2;
BEGIN
  call_error2;
END;
----------------------------------------------------
/*-=2=- СТЕК ВЫЗОВЫ ОШИБОК В РАЗНЫХ ПРОЦЕДУРАХ*/
CREATE OR REPLACE PROCEDURE proc1 IS 
BEGIN
  dbms_output.put_line('Вызов процедуры proc1');
  RAISE NO_DATA_FOUND;
END proc1;

CREATE OR REPLACE PROCEDURE proc2 IS
BEGIN
  dbms_output.put_line('Вызов процедуры proc2');
  proc1;
END proc2;

CREATE OR REPLACE PROCEDURE proc3 IS
BEGIN
  dbms_output.put_line('Вызов процедуры proc3');
  -- вызываем и бросаем исключение из первой процедуры
  proc2;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    bt.show_info(Dbms_Utility.format_error_backtrace);
    -- dbms_output.put_line(Dbms_Utility.format_error_backtrace);
END proc3;

BEGIN
 proc3;
END;
----------------------------------------------------------------------
/*-=3=- ВЫВОД ОШИБКИ АНАЛИЗИРУЯ СТЕК СМ PACKAGE BT*/
----------------------------------------------------------------------
/*-=4=- ОШИБКИ ПРИ КОПИЛЯЦИИ ПРОЦЕДУРЫ */
SELECT *
FROM user_errors

 
