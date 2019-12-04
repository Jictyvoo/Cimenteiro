module database_connection
import mysql
#flag -I/usr/include/mysql

struct ClassDao {
	mut: columns [][]string
	table_name string
	connection mysql.DB
}

fn generate_item(values map[string]string) string {
	mut generated_items := ""
	for key, value in values { generated_items += " $key $value" }
	return generated_items
}

pub fn result_string_array(result mysql.Result) [][]string {
	mut query_result := [[]string]
	for row in result.rows() {query_result << row.vals}
	result.free()
	return query_result
}

fn (dao ClassDao) create() ?bool {
	mut sql_command := "CREATE TABLE $dao.table_name (id int PRIMARY KEY AUTO_INCREMENT);"
	dao.connection.query(sql_command) or {
		return error(err)
	}
	return true
}

pub fn (dao ClassDao) add_column(column_name string, datatype string) {
	dao.connection.query("ALTER TABLE $dao.table_name ADD $column_name $datatype;") or { eprintln(err) }
}

pub fn (dao ClassDao) drop_column(column_name string) {
	dao.connection.query("ALTER TABLE $dao.table_name DROP COLUMN $column_name;") or { eprintln(err) }
}

pub fn (dao ClassDao) modify_column(column_name string, datatype string) {
	dao.connection.query("ALTER TABLE $dao.table_name MODIFY COLUMN $column_name $datatype;") or { eprintln(err) }
}

pub fn (dao ClassDao) add_foreign_key(column_name string, table_name string, table_id string) {
	dao.connection.query("ALTER TABLE $dao.table_name ADD CONSTRAINT FK_$dao.table_name$table_name FOREIGN KEY ($column_name) REFERENCES $table_name($table_id);") or { eprintln(err) }
}

pub fn (dao ClassDao) drop_foreign_key(table_name string) {
	dao.connection.query("ALTER TABLE $dao.table_name DROP FOREIGN KEY FK_$dao.table_name$table_name;") or { eprintln(err) }
}

pub fn (dao ClassDao) update(columns []string, values []string, where string) ?bool {
	mut sql_command := "UPDATE $dao.table_name SET"
	for count := 0; count < columns.len; count += 1 {
		if count > 0 {sql_command += ","}
		column_name := columns[count]
		item_values := values[count]
		sql_command += " $column_name = '$item_values'"
	}
	if where.len > 2 { sql_command += " WHERE $where" }
	dao.connection.query(sql_command) or {
		return error(err)
	}
	return true
}

pub fn (dao ClassDao) insert(names []string, values []string) ?bool {
	mut sql_command := "INSERT INTO " + dao.table_name + "("
	sql_command += names.join(",") + ") VALUES(" + values.join(",") + ")"
	dao.connection.query(sql_command) or {
		return error(err)
	}
	return true
}

pub fn (dao ClassDao) select_columns(columns []string, conditions map[string]string) ?[][]string {
	result := dao.connection.query("SELECT " + columns.join(",") + " FROM $dao.table_name" + generate_item(conditions)) or {
		return error(err)
	}
	return result_string_array(result)
}

pub fn (dao ClassDao) select_all(where string, conditions string) ?[][]string {
	mut sql_command := "SELECT * FROM $dao.table_name"
	if where.len > 2 { sql_command += " WHERE $where" }
	if conditions.len > 2 {sql_command += conditions}
	result := dao.connection.query(sql_command) or {
		return error(err)
	}
	return result_string_array(result)
}

pub fn (dao ClassDao) delete(condition string) ?bool {
	sql_command := "DELETE FROM " + dao.table_name + " WHERE " + condition + ";"
	dao.connection.query(sql_command) or {
		return error(err)
	}
	return true
}
