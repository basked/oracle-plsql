/*Операции с множествами*/
DECLARE
  TYPE names_aat IS TABLE OF VARCHAR2(25) INDEX BY PLS_INTEGER;
  TYPE names_nt IS TABLE OF VARCHAR2(25);
  names1  names_nt NOT NULL := names_nt('basket', 'teksab', 'bas', 'tek');
  names11 names_nt := names_nt('teksab', 'basket', 'bas', 'tek', 'bas');
  names2  names_nt := names_nt('basket', 'teksab');
  names3  names_nt;
  names_a names_aat;
  PROCEDURE collect_info(col_name IN VARCHAR2, names_n IN names_nt) IS
  BEGIN
    dbms_output.put(col_name || '(');
    FOR i IN names_n.first .. names_n.last LOOP
      IF names_n.exists(i) THEN
        IF (i <> names_n.count) THEN
          dbms_output.put(names_n(i) || ',');
        ELSE
          dbms_output.put_line(names_n(i) || ')');
        END IF;
      END IF;
    END LOOP;
    dbms_output.put_line('Info : First=' || names11(names11.first) ||
                         ' , Last=' || names11(names11.last) || ', Count=' ||
                         names1.count);
  END;
BEGIN
  names_a(5) := 'basket';
  names_a(10) := 'teksab';
  names_a(64) := 'deksab';
  BEGIN
    -- перебор всего асоативного массива с проверкой на существование элемента
    bas_pkg.line_separ('Перебор всего асоативного массива ');
    FOR i IN names_a.first .. names_a.last LOOP
      IF names_a.exists(i) THEN
        dbms_output.put_line('Index=' || i || ' ,value=' || names_a(i) ||
                             ' from ' || names_a.count);
      END IF;
    END LOOP;
  EXCEPTION
    WHEN no_data_found THEN
      dbms_output.put_line('Element not found in collections');
  END;

  -- равенство колекций
  bas_pkg.line_separ('Проверка на равенство.');
  IF names1 = names11 THEN
    bas_pkg.line_separ('Коллекции равны.');
  END IF;
  IF names1 != names2 THEN
    bas_pkg.line_separ('Коллекции names1 и names2 не равны.');
  END IF;
  -- оператор IN
  IF names2 IN (names1, names2) THEN
    bas_pkg.line_separ('Коллекция names2 существует в списках  names1 или names3 .');
  END IF;

  -- выводим все элементы таблицы
  bas_pkg.line_separ('Коллекция names11');
  collect_info('names11', names11);
  names11.delete(1);
 
  bas_pkg.line_separ('Коллекция names11 после DELETE(1)');
  collect_info('names11', names11);
END;
