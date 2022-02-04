DECLARE
  TYPE list_of_countries_t IS TABLE OF COUNTRIES.Country_Name%TYPE INDEX BY PLS_INTEGER;
  list_of_countries list_of_countries_t;
  l_row             PLS_INTEGER;
BEGIN
  list_of_countries(0) := 'a';
  list_of_countries(1) := 'b';
  list_of_countries(2) := 'c';
  list_of_countries(3) := 'd';
  l_row := list_of_countries.FIRST;
  WHILE (l_row IS NOT NULL) LOOP
    dbms_output.put_line(list_of_countries(l_row));
    l_row := list_of_countries.next(l_row);
  END LOOP;

END;
