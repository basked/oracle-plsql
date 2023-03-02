PL/SQL Developer Test script 3.0
43
-- Выполнять под SYS
DECLARE
	l_ws_user VARCHAR2(32) := 'SYS'; -- Указать имя схемы БД, где предполагается развернуть объекты для обработки запросов WS
	l_acl     VARCHAR2(250) := 'acl_allow_all.xml';
	l_tmp     VARCHAR2(250);
BEGIN
	EXECUTE IMMEDIATE 'GRANT XDB_WEBSERVICES TO "' || l_ws_user || '"';
	EXECUTE IMMEDIATE 'GRANT XDB_WEBSERVICES_OVER_HTTP TO "' || l_ws_user || '"';
	EXECUTE IMMEDIATE 'GRANT XDB_WEBSERVICES_WITH_PUBLIC TO "' || l_ws_user || '"';

	-- Создание списка разрешений сетевого доступа из PL/SQL пакетов
	BEGIN
		dbms_network_acl_admin.drop_acl(acl => '/sys/acls/' || l_acl);
	EXCEPTION
		WHEN dbms_network_acl_admin.acl_not_found THEN
			NULL;
	END;

	-- Создание ACL
	dbms_network_acl_admin.create_acl(acl         => l_acl,
												 description => 'Allow all connections',
												 is_grant    => TRUE,
												 start_date  => SYSTIMESTAMP,
												 end_date    => NULL,
												 principal   => 'SYS',
												 privilege   => 'connect');

	dbms_network_acl_admin.assign_acl(acl => l_acl, host => '*.*', 
   lower_port => NULL, 
   upper_port => NULL);

	-- Права на разрешение (resolve)сетевого имени
	dbms_network_acl_admin.add_privilege(acl        => l_acl,
													 principal  => l_ws_user,
													 is_grant   => TRUE,
													 privilege  => 'resolve',
													 POSITION   => NULL,
													 start_date => SYSTIMESTAMP,
													 end_date   => NULL);

	COMMIT;
END;
/
0
0
