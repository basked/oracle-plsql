CREATE OR REPLACE NONEDITIONABLE PACKAGE bas_err_pkg IS
  -- Ошибки в диапазоне -20000 до -20999 
  err_val_not_null CONSTANT NUMBER := -20001;
  exc_val_not_null EXCEPTION;
  PRAGMA EXCEPTION_INIT(exc_val_not_null, -20001);

  PROCEDURE raise_by_lang(p_code_err IN bas_errors.error_num%TYPE);
END bas_err_pkg;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY bas_err_pkg IS
  PROCEDURE raise_by_lang(p_code_err IN bas_errors.error_num%TYPE) IS
    -- errors
    err_not_data EXCEPTION;
    err_not_data_code CONSTANT NUMBER := 100;
    PRAGMA EXCEPTION_INIT(err_not_data, err_not_data_code);
    l_error_string bas_errors.error_string%TYPE;
  
  BEGIN
    SELECT be.error_string
      INTO l_error_string
      FROM bas_errors be
     WHERE be.error_num = p_code_err
       AND be.lang_string = USERENV('lang');
    RAISE_APPLICATION_ERROR(p_code_err, l_error_string);
  EXCEPTION
    WHEN OTHERS THEN
      IF SQLCODE = 100 THEN
        dbms_output.put_line('Нет данных в таблице ошибок для кода=' ||
                             p_code_err);
      END IF;
  END;

END bas_err_pkg;
/
