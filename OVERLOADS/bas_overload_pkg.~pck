CREATE OR REPLACE NONEDITIONABLE PACKAGE bas_overload_pkg IS
  FUNCTION square(a IN INTEGER, b IN INTEGER) RETURN INTEGER DETERMINISTIC;
  FUNCTION square(a IN INTEGER, b IN VARCHAR2) RETURN INTEGER DETERMINISTIC;
  PROCEDURE test_square;
  --- NOTATIONS
  PROCEDURE cal_total(zone_in IN VARCHAR2);
  PROCEDURE cal_total(region_in IN VARCHAR2);
  PROCEDURE test_cal_total;
END bas_overload_pkg;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY bas_overload_pkg IS
  -- OVERLOAD 
  --1=-
  FUNCTION square(a IN INTEGER, b IN INTEGER) RETURN INTEGER DETERMINISTIC IS
  BEGIN
    RETURN(a * b);
  END square;
  FUNCTION square(a IN INTEGER, b IN VARCHAR2) RETURN INTEGER DETERMINISTIC IS
  BEGIN
    RETURN a * CAST(b AS INTEGER) + 1;
  END square;

  PROCEDURE test_square IS
  BEGIN
    FOR l_row IN (SELECT LEVEL,
                     bas_overload_pkg.square(LEVEL, LEVEL) AS ints,
                     bas_overload_pkg.square(LEVEL, to_char(LEVEL)) AS chars
                FROM dual
              CONNECT BY LEVEL < 10) LOOP
     dbms_output.put_line(l_row.level||'  |  '|| l_row.ints||'  |  '||  l_row.chars);
    END LOOP;
  END test_square;
   --2=- NOTATIONS
  PROCEDURE cal_total(zone_in IN VARCHAR2) IS
  BEGIN
    dbms_output.put_line(zone_in);
  END cal_total;
  
  PROCEDURE cal_total(region_in IN VARCHAR2) IS
  BEGIN
    dbms_output.put_line(region_in);
  END cal_total;
  
  PROCEDURE test_cal_total  IS
  BEGIN
    cal_total(zone_in=>'zone');
    cal_total(region_in=>'region');
  END;
END bas_overload_pkg;
/
