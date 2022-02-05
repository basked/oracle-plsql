/*
drop table family;
CREATE OR REPLACE TYPE first_names_t IS VARRAY(2) OF VARCHAR2(100);
CREATE OR REPLACE TYPE child_names_t IS VARRAY(2) OF VARCHAR2(100);
CREATE TABLE family (
  surname VARCHAR2(100),
  parnet_names first_names_t, 
  children_names child_names_t
);
*/
DECLARE
  parents     first_names_t := first_names_t();
  children    child_names_t;
  l_separator VARCHAR2(2);
BEGIN
  parents.extend(2);
  parents(1) := 'basked';
  parents(2) := 'Iro4ka';

  children := child_names_t();
  children.extend;
  children(1) := 'TemiG';
  -- children.extend;
  -- children(2) := 'Vero4ka';
  -- вставка записи 
  INSERT INTO family
    (surname, parnet_names, children_names)
  VALUES
    ('MISULIA', parents, children);
  COMMIT;

  -- вывод коллекции
  FOR family_rec IN (SELECT * FROM family) LOOP
    -- вывод родителей
    dbms_output.put(family_rec.surname || '=>');
    dbms_output.put('Parrents:');
    FOR l_row IN family_rec.parnet_names.first .. family_rec.parnet_names.last LOOP
    
      IF family_rec.parnet_names.count = l_row THEN
        l_separator := '';
      ELSE
        l_separator := ',';
      END IF;
      dbms_output.put(family_rec.parnet_names(l_row) || l_separator);
    END LOOP;
    -- вывод детей
  
    dbms_output.put('; Children:');
    FOR l_row IN family_rec.children_names.first .. family_rec.children_names.last LOOP
      IF family_rec.children_names.count = l_row THEN
        l_separator := '';
      ELSE
        l_separator := ',';
      END IF;
      dbms_output.put(family_rec.children_names(l_row) || l_separator);
    END LOOP;
  
    dbms_output.put_line('');
  END LOOP;
END;

/*

  -- выборка при помощи SQL
  SELECT * 
  FROM TABLE(
  SELECT f.parnet_names FROM family  f)
  */
----- -------------------------------------------------------------------------
--ВТОРОЙ ВАРИАНТ
--CREATE OR REPLACE TYPE names_auto_tva IS VARRAY(5) OF VARCHAR2(25);
--CREATE TABLE auto_park(title VARCHAR2(15),names_auto names_auto_tva );
DECLARE
  names_auto_c names_auto_tva := names_auto_tva();
  l_separ      VARCHAR2(1) DEFAULT ',';
BEGIN
  -- вставка записи в таблицу
  names_auto_c.extend(5);
  names_auto_c(1) := 'FORD FOCUS 1';
  names_auto_c(2) := 'FORD FOCUS 2';
  names_auto_c(3) := 'FORD FOCUS 3';
  names_auto_c(4) := 'FORD FOCUS 4';
  INSERT INTO auto_park
    (title, names_auto)
  VALUES
    ('BREST AUTO PARK', names_auto_c);
  COMMIT;
  FOR l_names_auto_cur IN (SELECT * FROM auto_park) LOOP
    dbms_output.put(l_names_auto_cur.title || '=>');
    FOR l_row IN l_names_auto_cur.names_auto.first .. l_names_auto_cur.names_auto.last LOOP
      IF l_row = l_names_auto_cur.names_auto.count THEN
        l_separ := '';
      ELSE
        l_separ := ',';
      END IF;
      dbms_output.put(l_names_auto_cur.names_auto(l_row) || l_separ);
    END LOOP;
    dbms_output.put_line('');
  END LOOP;
END;
