DECLARE
  TYPE list_of_countries_str_t IS TABLE OF COUNTRIES.Country_Name%TYPE INDEX BY VARCHAR2(6);
  TYPE list_of_countries_int_t IS TABLE OF COUNTRIES.Country_Name%TYPE INDEX BY PLS_INTEGER;
  list_of_countries_str list_of_countries_str_t;
  list_of_countries_int list_of_countries_int_t;
  l_row_str             VARCHAR(6);
  l_row_int             PLS_INTEGER;
BEGIN
  -- Работа с ассативным масивом - индексы - это строки
  list_of_countries_str('0') := 'a';
  list_of_countries_str('1') := 'b';
  list_of_countries_str('2') := 'c';
  list_of_countries_str('3') := 'd';
  list_of_countries_str('bas') := 'e';
  dbms_output.put_line('Обращение к индексу по строке');
  l_row_str := list_of_countries_str.FIRST;
  WHILE (l_row_str IS NOT NULL) LOOP
    dbms_output.put_line(list_of_countries_str(l_row_str));
    l_row_str := list_of_countries_str.next(l_row_str);
  END LOOP;
  -- Работа с ассативным масивом - индексы - это числа
  list_of_countries_int(1) := 'a';
  list_of_countries_int(2) := 'b';
  list_of_countries_int(3) := 'c';
  list_of_countries_int(4) := 'd';
  dbms_output.put_line('Обращение к индексу по номеру');
  l_row_int := list_of_countries_int.FIRST;
  WHILE (l_row_int IS NOT NULL) LOOP
    dbms_output.put_line(list_of_countries_int(l_row_int));
    l_row_int := list_of_countries_int.next(l_row_int);
  END LOOP;
END;
