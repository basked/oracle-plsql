DECLARE
  l_row        NUMBER;
  l_names_auto names_auto_tva;
  -- Передача колексции как параметра в подпрограмму
  PROCEDURE get_auto(names_auto OUT auto_park.names_auto%TYPE) IS
  BEGIN
    SELECT t.names_auto
      INTO names_auto
      FROM AUTO_PARK t
     WHERE t.title = 'AUTO PARK';
  END get_auto;
  --Возврат колекции как параметра в подпрограмму
  FUNCTION get_auto2(p_title IN auto_park.title%TYPE)
    RETURN auto_park.names_auto%TYPE IS
    l_names_auto auto_park.names_auto%TYPE;
  BEGIN
    SELECT t.names_auto
      INTO l_names_auto
      FROM AUTO_PARK t
     WHERE t.title = p_title;
    RETURN l_names_auto;
  END get_auto2;
BEGIN
  dbms_output.put_line('Передача колекции как параметра в подпрограмму: ');
  get_auto(l_names_auto);
  l_row := l_names_auto.first;
  dbms_output.put_line(l_names_auto(l_row));
  l_row := l_names_auto.last;
  dbms_output.put_line(l_names_auto(l_row));
  -------------------------------------------------------------------------
  dbms_output.put_line('Возврат коллекции колекции из подпрограммы: ');
  l_names_auto := get_auto2('AUTO PARK');
  l_row        := l_names_auto.first;
  dbms_output.put_line(l_names_auto(l_row));
  l_row := l_names_auto.last;
  dbms_output.put_line(l_names_auto(l_row));
END;

/*select * from AUTO_PARK t */
