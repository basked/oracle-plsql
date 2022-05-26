CREATE OR REPLACE NONEDITIONABLE PACKAGE cr_get_country IS
	-- при объявлении в спецификации пакета типа коллекции - можно использовать pipeline функцию
	TYPE country_nt_type IS TABLE OF countries%ROWTYPE;
	FUNCTION get_country(p_region countries.region_id%TYPE := 0) RETURN country_nt_type
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
END cr_get_country;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE cr_get_country IS
	-- при объявлении в спецификации пакета типа коллекции - можно использовать pipeline функцию
	TYPE country_nt_type IS TABLE OF countries%ROWTYPE;
	FUNCTION get_country(p_region countries.region_id%TYPE := 0) RETURN country_nt_type
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
END cr_get_country;
/
