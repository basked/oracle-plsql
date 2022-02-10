DECLARE
  fields      bas_pkg.list_fields_t := bas_pkg.list_fields_t('ID', 'NAME');
  field_types bas_pkg.list_fields_type_t := bas_pkg.list_fields_type_t('NUMBER', 
                                                                       'VARCHAR(25)');
BEGIN
  bas_pkg.create_table('blok_table_a', fields, field_types);
  bas_pkg.dummy('blok_table_a',5);
  bas_pkg.create_table('blok_table_b', fields, field_types);
  bas_pkg.dummy('blok_table_b',5);
END;
