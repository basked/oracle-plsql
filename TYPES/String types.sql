/*
-------------------------------------
Подтип                      Эквивалентный тип
--------------------------------------
CHAR VARYING               | VARCHAR2
CHARACTER                  | CHAR
CHARACTER VARYING          | VARCHAR2
NATIONAL CHAR              | NCHAR
NATIONAL CHAR VARYING      | NVARCHAR2
NATIONAL CHARACTER         | NCHAR
NATIONAL CHARACTER VARYING | NVARCHAR2
NCHAR VARYING              | NVARCHAR2
STRING                     | VARCHAR2
VARCHAR                    | VARCHAR2
---------------------------------------
*/

DECLARE
  small_string VARCHAR2(9 BYTE);
  yes_or_no    CHAR(1) DEFAULT 'Y';
  var_t        VARCHAR2(6);
  str          STRING(5);
BEGIN
  str          := '1234';
  small_string := '123456789';
  var_t        := 'basket';
  dbms_output.put_line('Длина строки ''str''=' || LENGTH(str));
  dbms_output.put_line(q'!Динная с'трока с ограничителем q !');
  dbms_output.put_line(u 'Pils vom fa\00DF: 1\20AC'); -- \20AC - знак евро
  dbms_output.put_line('Рок &' || CHR(10) || ' Ролл');
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE = -6502 THEN
      dbms_output.put_line('Строка > ''5' ||
                           dbms_utility.format_error_backtrace);
    END IF;
END;
