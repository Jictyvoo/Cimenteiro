module cimenteiro

pub fn new_migration(table_name string) Migration {
	return Migration{
		table_name: table_name
	}
}
