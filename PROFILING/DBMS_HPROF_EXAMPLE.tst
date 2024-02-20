﻿PL/SQL Developer Test script 3.0
54
DECLARE

	PROCEDURE doit IS
		k NUMBER := 0;
		t basked.cr_get_country.country_nt_type;
	BEGIN
		FOR i IN 1 .. 1000
		LOOP
			SELECT *
			BULK COLLECT
			INTO t
			FROM TABLE(basked.cr_get_country.get_country);
		END LOOP;
		FOR i IN t.first .. t.last
		LOOP
			dbms_output.put_line(t(i).country_name);
		END LOOP;
	END doit;

BEGIN
	sys.DBMS_HPROF.start_profiling(location => 'PROFILER_DIR', filename => 'output_filename.txt');
	doit;
	sys.DBMS_HPROF.stop_profiling;

	:v_runid := sys.dbms_hprof.analyze(location => 'PROFILER_DIR', filename => 'output_filename.txt');


	OPEN :cur FOR
		SELECT LEVEL,
				 line,
             sql_text,
				 symbolid,
				 RPAD(' ', (LEVEL - 1) * 2, ' ') || a.name AS NAME,
				 round(a.subtree_elapsed_time / 60000000, 4),
				 round(a.function_elapsed_time / 60000000, 4),
				 a.calls,
				 rownum rn
		FROM (SELECT fi.symbolid,
						 fi.line# AS line,
                   fi.sql_text,                   
						 pci.parentsymid,
						 RTRIM(fi.owner || '.' || fi.module || '.' || NULLIF(fi.function, fi.module), '.') AS NAME,
						 NVL(pci.subtree_elapsed_time, fi.subtree_elapsed_time) AS subtree_elapsed_time,
						 NVL(pci.function_elapsed_time, fi.function_elapsed_time) AS function_elapsed_time,
						 NVL(pci.calls, fi.calls) AS calls
				FROM sys.dbmshp_function_info fi
				LEFT JOIN sys.dbmshp_parent_child_info pci
				ON fi.runid = pci.runid
					AND fi.symbolid = pci.childsymid
				WHERE fi.runid = :v_runid
						AND NVL(fi.module, ' ') <>'DBMS_HPROF') a
		CONNECT BY a.parentsymid = PRIOR a.symbolid
		START WITH a.parentsymid IS NULL;
END;
3
v_runid
1
24
5
p_runid
1
1
-5
cur
1
<Cursor>
116
0
