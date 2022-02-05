DECLARE
  TYPE list_of_names_t IS TABLE OF VARCHAR2(100); 
  happyfamily list_of_names_t := list_of_names_t();
  children    list_of_names_t;
  parents     list_of_names_t := list_of_names_t();
BEGIN
  happyfamily.extend(4);
  happyfamily(1) := 'Iro4ka';
  happyfamily(2) := 'TeMIG';
  happyfamily(4) := 'BaskeD';

  children := list_of_names_t();
  children.extend;
  children(1) := 'TeMIG';

  parents := happyfamily MULTISET EXCEPT children;

  FOR l_row IN parents.FIRST .. parents.LAST LOOP
    dbms_output.put_line(l_row||'=>'||parents(l_row));
  END LOOP;
END;
