-- ПЕРЕБОР ВСЕХ ЭЛЕМЕНТОВ КОЛЕКЦИИ КОЛЛЕКЦИЙ

DECLARE
  TYPE t_aa IS TABLE OF VARCHAR2(10) INDEX BY PLS_INTEGER;
  TYPE t_aa2 IS TABLE OF t_aa INDEX BY PLS_INTEGER;
  t  t_aa;
  t2 t_aa2;
  l_row  PLS_INTEGER;
  l_row2 PLS_INTEGER;
BEGIN
  t(0) := '0';
  t(1) := '1';
  t(2) := '2';
  t2(0) := t;
  t(3) := '3';
  t2(1) := t;
  l_row2 := t2.first;
  WHILE (l_row2 IS NOT NULL) LOOP
    l_row := t2(l_row2).first;
    WHILE (l_row IS NOT NULL) LOOP
      dbms_output.put_line('t(' || l_row2 || ')(' || l_row || ')=' ||
                           t2(l_row2) (l_row));
      l_row := t2(l_row2).next(l_row);
    END LOOP;
    l_row2 := t2.next(l_row2);
  END LOOP;
END;
