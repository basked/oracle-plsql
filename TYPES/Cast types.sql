DECLARE
  a_number1 NUMBER(5);
  a_number2 NUMBER(2);
BEGIN
  a_number1 := '12446';
  dbms_output.put_line(a_number1);
  a_number2 := '12446';
  dbms_output.put_line(a_number2);
EXCEPTION
  -- Неявная конвертация строки в число 
  WHEN OTHERS THEN
    IF SQLCODE = -6502 THEN
      dbms_output.put_line('Ошибка приведения типов: ' ||
                           dbms_utility.format_error_backtrace);
      --  RAISE;
    END IF;
  
END;
