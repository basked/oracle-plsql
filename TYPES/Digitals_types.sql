﻿DECLARE
  num_type NUMBER(9, 2);
  -- Появились в Oracle10, могут быть NULL  
  bin_float_type  BINARY_FLOAT;
  bin_double_type BINARY_DOUBLE;
  -- Появились в Oracle11, не могут быть NULL  и определяяються изначально 
  simple_float_type  SIMPLE_FLOAT := 123.456;
  simple_double_type SIMPLE_DOUBLE := 123.456;
BEGIN
  num_type := 1234567.8698;
  dbms_output.put_line('NUMBER(9, 2): ' || num_type);
  /* Два двоичных типа с плавающей запятой 
     Однако в отличие от NUMBER, эти типы хранят значение в двоичном виде, а следова-
     тельно, при работе с ними могут возникнуть погрешности округления
  */
  bin_float_type := NULL;
  bin_float_type := 12345.86;
  dbms_output.put_line('BINARY_FLOAT: ' || bin_float_type);

  bin_double_type := 12322245.8226;
  dbms_output.put_line('BINARY_DOUBLE: ' || bin_double_type);

  simple_float_type := 12345.86;
  dbms_output.put_line('SIMPLE_FLOAT: ' || simple_float_type);

  simple_double_type := 12322245.8226;
  dbms_output.put_line('SIMPLE_DOUBLE: ' || BINARY_FLOAT_MAX_NORMAL);
END;








