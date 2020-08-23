module cimenteiro

pub fn migration(table_name string) Migration {
	return Migration{
		table_name: table_name
	}
}

pub fn table(name string) Builder {
	return Builder{table_name:name}
}
