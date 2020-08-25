import cimenteiro

fn test_migration() {
	mut new_table := cimenteiro.migration('test')
	new_table.field_args('name', .string_, '60').nullable()
	result := new_table.end()
	println(result)
	assert result == 'CREATE TABLE test (name VARCHAR(60) NOT NULL);'
}
