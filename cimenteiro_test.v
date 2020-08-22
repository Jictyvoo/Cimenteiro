module cimenteiro

fn test_migration() {
	assert false == true
	assert cimenteiro.new_migration("a_test").table_name == "a_test"
}

/*fn test_nani() {
	mut db := cimenteiro.create_connection('remotemysql.com', 'OBx64VGjgM', 'Bi3NXOeAst', 'OBx64VGjgM')?
	test_dao := db.generate_dao("Testsdsdse")?
	test_dao.delete("id IS NULL")?
	test_dao.update(["nome", "capacidade"], ["Odivio", "Testador"], "id = 2")?
	chapter_dao := db.create_table("chapters", ["id", "name", "pages"], ["int primary key auto_increment", "varchar(50)", "int"])?
	result := db.get_connection().query("show tables")?
	for row in result.rows() { println(row) }
	where := map[string]string
	mut other_result := chapter_dao.select_all("", "")?
	println(other_result)
	other_result = test_dao.select_columns(["nome", "capacidade"], where)?
	println(other_result)
	other_result = test_dao.select_all("", "")?
	println(other_result)
	db.end()
}*/
