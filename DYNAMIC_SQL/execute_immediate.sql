-- deadlock example
DECLARE
  PROCEDURE create_table(p_tab_name IN VARCHAR2) IS
    l_sql_create_stmt VARCHAR(1000);
  BEGIN
    l_sql_create_stmt := 'CREATE TABLE ' || p_tab_name ||
                         '(ID NUMBER , CONSTRAINTS ' || p_tab_name ||
                         '_pk PRIMARY KEY (ID))';
  
    EXECUTE IMMEDIATE 'drop table ' || p_tab_name;
    EXECUTE IMMEDIATE l_sql_create_stmt;
    dbms_output.put_line('Table ' || p_tab_name || ' was created!');
  EXCEPTION
    WHEN OTHERS THEN
      IF SQLCODE = -942 THEN
        EXECUTE IMMEDIATE l_sql_create_stmt;
        dbms_output.put_line('Table ' || p_tab_name || ' was created!');
      END IF;
  END;
BEGIN
  create_table('blok_table_a');
  create_table('blok_table_b');

END;
