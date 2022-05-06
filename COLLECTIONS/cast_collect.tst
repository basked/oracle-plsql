PL/SQL Developer Test script 3.0
59
-- Created on 06.05.2022 by BASKE 
DECLARE
	--c_qrs_cursor SYS_REFCURSOR;
	CURSOR c_qrs_cursor IS
		SELECT *
		FROM employees;
	TYPE typ_tab_empl IS TABLE OF c_qrs_cursor%ROWTYPE;
	TYPE typ_tab_last_name IS TABLE OF employees.first_name%TYPE;
	tab_nt_empl      typ_tab_empl;
	tab_nt_last_name typ_tab_last_name;

	v_department_name departments.department_name%TYPE;
BEGIN
	OPEN c_qrs_cursor;
	FETCH c_qrs_cursor BULK COLLECT
		INTO tab_nt_empl;
	CLOSE c_qrs_cursor;
	FOR i IN tab_nt_empl.first .. tab_nt_empl.last
	LOOP
		IF i = 1
		THEN
			dbms_output.put_line(tab_nt_empl(i).first_name);
			EXIT;
		END IF;
	END LOOP;
	------------------------------------------------------

	FOR rec IN (SELECT e.department_id,
							 CAST(COLLECT(last_name ORDER BY hire_date) AS strings_nt) AS col_nt,
							 COUNT(e.department_id) AS cnt
					FROM employees e
					GROUP BY e.department_id
					ORDER BY 1)
	LOOP
		dbms_output.put_line('==================');
	
		BEGIN
			SELECT department_name
			INTO v_department_name
			FROM departments
			WHERE department_id = rec.department_id;
		EXCEPTION
			WHEN OTHERS THEN
				--  dbms_output.put_line(SQLCODE ||'->'|| SQLERRM);
				IF SQLCODE = 100
				THEN
					v_department_name := 'NO DEPARTMENT';
				END IF;
		END;
		dbms_output.put_line(v_department_name);
		FOR i IN rec.col_nt.first .. rec.col_nt.last
		LOOP
			dbms_output.put_line('   ' || rec.col_nt(i));
		END LOOP;
	
	END LOOP;


END;
1
c_qrs_cursor
1
<Cursor>
-116
1
tab_nt_empl
