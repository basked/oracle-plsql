DECLARE

	TYPE collateral_obj IS RECORD(
		CODE NUMBER,
		NAME VARCHAR2(250));

	TYPE collateral_type IS TABLE OF collateral_obj;
	TYPE ids_obj IS TABLE OF NUMBER;

	tab_collateral collateral_type := collateral_type(
                     collateral_obj(4, '4'), 
                     collateral_obj(5, '5'), 
                     collateral_obj(6, '6'));
	ids_tab        ids_obj;
BEGIN
	DELETE test_tab;
	--s_test_tab_pk

	FORALL idx IN 1 .. tab_collateral.last
		INSERT INTO test_tab
		VALUES
			(s_test_tab_pk.nextval, tab_collateral(idx).code, tab_collateral(idx).name) RETURN ID BULK COLLECT INTO ids_tab;


	FOR idx IN 1 .. ids_tab.last
	LOOP
		dbms_output.put_line(ids_tab(idx));
	END LOOP;
	COMMIT;
END;
