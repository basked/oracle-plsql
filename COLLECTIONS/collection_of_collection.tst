PL/SQL Developer Test script 3.0
36
DECLARE
	TYPE typ_words_nt IS TABLE OF VARCHAR2(1000);
	TYPE typ_user_source_nt IS TABLE OF User_Source%ROWTYPE;
	TYPE typ_user_source_at IS TABLE OF typ_user_source_nt INDEX BY VARCHAR2(500);

	tab_wors typ_words_nt := typ_words_nt('%into%', '%WHEN%NO_DATA_NEED%THEN%', '%RAISE%');
	tab_us   typ_user_source_nt := typ_user_source_nt();
	tab_a_ut typ_user_source_at;

BEGIN
	FOR w IN tab_wors.first .. tab_wors.last
	LOOP
		SELECT us.*
		BULK COLLECT
		INTO tab_a_ut(tab_wors(w))
		FROM User_Source us
		WHERE UPPER(us.TYPE) LIKE '%PACKAGE BODY%'
				AND NAME = 'CR_GET_COUNTRY'
				AND UPPER(text) LIKE UPPER(tab_wors(w));
	END LOOP;
	--dbms_output.put_line(tab_a_ut('%into%')(1).text);


	FOR w IN tab_wors.first .. tab_wors.last
	LOOP
	
		FOR k IN tab_a_ut(tab_wors(w)).first .. tab_a_ut(tab_wors(w)).last
		LOOP
			dbms_output.put_line(tab_a_ut(tab_wors(w))(k).name || '=>' || tab_a_ut(tab_wors(w))(k).text
										
										);
		END LOOP;
	END LOOP;


END;
1
sdf
1
CR_GET_COUNTRY
-5
0
