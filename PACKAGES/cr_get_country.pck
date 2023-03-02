CREATE OR REPLACE NONEDITIONABLE PACKAGE cr_get_country IS
	-- при объявлении в спецификации пакета типа коллекции - можно использовать pipeline функцию
	TYPE country_nt_type IS TABLE OF countries%ROWTYPE;
	TYPE employees_rec_type IS RECORD(
		EMPLOYEE_ID    employees.employee_id%TYPE,
		FIRST_NAME     employees.FIRST_NAME%TYPE,
		LAST_NAME      employees.last_name%TYPE,
		EMAIL          employees.EMAIL%TYPE,
		PHONE_NUMBER   employees.PHONE_NUMBER%TYPE,
		HIRE_DATE      employees.HIRE_DATE%TYPE,
		JOB_ID         employees.JOB_ID%TYPE,
		SALARY         employees.SALARY%TYPE,
		COMMISSION_PCT employees.COMMISSION_PCT%TYPE,
		MANAGER_ID     employees.MANAGER_ID%TYPE,
		DEPARTMENT_ID  employees.DEPARTMENT_ID%TYPE
		
		);
	TYPE employees_cur_type IS REF CURSOR RETURN employees_rec_type;
	TYPE employees_nt_type IS TABLE OF employees_rec_type;



	FUNCTION get_country(p_region countries.region_id%TYPE := 0) RETURN country_nt_type
		PIPELINED;
	FUNCTION get_country2(p_region countries.region_id%TYPE := 0) RETURN country_nt_type
		PIPELINED;
	FUNCTION get_enmployees_cur(p_department_id IN employees.department_id%TYPE := 0,
										 p_qrs_cursor    OUT SYS_REFCURSOR) RETURN NUMBER;
	FUNCTION get_report(p_dep_id employees.department_id%TYPE) RETURN employees_nt_type
		PIPELINED;
END cr_get_country;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY cr_get_country IS

	-- Refactored procedure bba 


	FUNCTION get_country(p_region countries.region_id%TYPE := 0) RETURN country_nt_type
		PIPELINED IS
		country_rec     countries%ROWTYPE;
		country_tab     country_nt_type;
		country_tab1    country_nt_type := country_nt_type();
		country_tab_res country_nt_type := country_nt_type();
	BEGIN
		dbms_output.put_line('asdf');
		BEGIN
			SELECT c.*
			BULK COLLECT
			INTO country_tab
			FROM countries c
			WHERE c.region_id = CASE
						WHEN p_region = 0 THEN
						 c.region_id
						ELSE
						 p_region
					END;
		
			-- создаем коллекцию
			country_tab.extend();
			country_tab(country_tab.last).COUNTRY_ID := 'bs';
			country_tab(country_tab.last).COUNTRY_NAME := 'basked';
			country_tab(country_tab.last).REGION_ID := 4;
		
			-- дубль  коллекции
			country_tab1.extend();
			country_tab1(country_tab1.last).COUNTRY_ID := 'ba';
			country_tab1(country_tab1.last).COUNTRY_NAME := 'basked';
			country_tab1(country_tab1.last).REGION_ID := 4;
			-- дубль записи второй коллекции      
			country_tab1.extend();
			country_tab1(country_tab1.last).COUNTRY_ID := 'bs';
			country_tab1(country_tab1.last).COUNTRY_NAME := 'basked';
			country_tab1(country_tab1.last).REGION_ID := 4;
		
			country_tab_res := country_tab MULTISET UNION country_tab1;
		
			FOR i IN country_tab_res.first .. country_tab_res.last
			LOOP
				PIPE ROW(country_tab_res(i));
			END LOOP;
			RETURN;
		EXCEPTION
			WHEN NO_DATA_NEEDED THEN
				DBMS_OUTPUT.put_line('NO_DATA_NEEDED');
				RAISE;
			WHEN OTHERS THEN
				DBMS_OUTPUT.put_line('OTHERS Handler');
				RAISE;
		END;
	END get_country;
	FUNCTION get_country2(p_region countries.region_id%TYPE := 0) RETURN country_nt_type
		PIPELINED IS
		country_rec     countries%ROWTYPE;
		country_tab     country_nt_type;
		country_tab1    country_nt_type := country_nt_type();
		country_tab_res country_nt_type := country_nt_type();
	BEGIN
		BEGIN
			SELECT c.*
			BULK COLLECT
			INTO country_tab
			FROM countries c
			WHERE c.region_id = CASE
						WHEN p_region = 0 THEN
						 c.region_id
						ELSE
						 p_region
					END;
		
			-- создаем коллекцию
			country_tab.extend();
			country_tab(country_tab.last).COUNTRY_ID := 'bs';
			country_tab(country_tab.last).COUNTRY_NAME := 'basked';
			country_tab(country_tab.last).REGION_ID := 4;
		
			-- дубль  коллекции
			country_tab1.extend();
			country_tab1(country_tab1.last).COUNTRY_ID := 'ba';
			country_tab1(country_tab1.last).COUNTRY_NAME := 'basked';
			country_tab1(country_tab1.last).REGION_ID := 4;
			-- дубль записи второй коллекции      
			country_tab1.extend();
			country_tab1(country_tab1.last).COUNTRY_ID := 'bs';
			country_tab1(country_tab1.last).COUNTRY_NAME := 'basked';
			country_tab1(country_tab1.last).REGION_ID := 4;
		
			country_tab_res := country_tab MULTISET UNION country_tab1;
		
			FOR i IN country_tab_res.first .. country_tab_res.last
			LOOP
				PIPE ROW(country_tab_res(i));
			END LOOP;
			RETURN;
		EXCEPTION
			WHEN NO_DATA_NEEDED THEN
				DBMS_OUTPUT.put_line('NO_DATA_NEEDED');
				RAISE;
			WHEN OTHERS THEN
				DBMS_OUTPUT.put_line('OTHERS Handler');
				RAISE;
		END;
	END get_country2;

	FUNCTION get_enmployees_cur(p_department_id IN employees.department_id%TYPE := 0,
										 p_qrs_cursor    OUT SYS_REFCURSOR) RETURN NUMBER IS
	BEGIN
		OPEN p_qrs_cursor FOR
			SELECT  e.*
			FROM employees e
			WHERE e.department_id = CASE
						WHEN p_department_id = 0 THEN
						 e.department_id
						ELSE
						 p_department_id
					END;
		RETURN 1;
	END;


	FUNCTION get_report(p_dep_id employees.department_id%TYPE) RETURN employees_nt_type
		PIPELINED IS
		v_ret        NUMBER;	
    empl_tab     employees_nt_type;
		v_qrs_cursor employees_cur_type;
		emp_rec      employees_rec_type;
	BEGIN
		v_ret := cr_get_country.get_enmployees_cur(p_department_id => p_dep_id, p_qrs_cursor => v_qrs_cursor);
		IF v_qrs_cursor%ISOPEN
		THEN
			LOOP
				EXIT WHEN v_qrs_cursor%NOTFOUND;
				FETCH v_qrs_cursor
					INTO emp_rec;
				PIPE ROW(emp_rec);
				/*FETCH v_qrs_cursor BULK COLLECT
            INTO empl_tab;*/
			END LOOP;
			dbms_output.put_line('uuu');
		
			/*FOR i IN empl_tab.first .. empl_tab.last
         LOOP
            PIPE ROW(empl_tab(i));
         END LOOP;*/
		END IF;
	END get_report;


END cr_get_country;
/
