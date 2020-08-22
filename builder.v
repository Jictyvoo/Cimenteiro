module cimenteiro

pub struct Builder {
mut:
	table_name  string
	query_type QueryType =.qselect
	query_args []FieldValue
}

fn generate_item(values map[string]string) string {
	mut generated_items := ''
	for key, value in values {
		generated_items += ' $key $value'
	}
	return generated_items
}

pub fn (builder Builder) add_column(column_name, datatype string) {
	builder.connection.query('ALTER TABLE $builder.table_name ADD $column_name $datatype;') or {
		eprintln(err)
	}
}

pub fn (builder Builder) drop_column(column_name string) {
	builder.connection.query('ALTER TABLE $builder.table_name DROP COLUMN $column_name;') or {
		eprintln(err)
	}
}

pub fn (builder Builder) modify_column(column_name, datatype string) {
	builder.connection.query('ALTER TABLE $builder.table_name MODIFY COLUMN $column_name $datatype;') or {
		eprintln(err)
	}
}

pub fn (builder Builder) add_foreign_key(column_name, table_name, table_id string) {
	builder.connection.query('ALTER TABLE $builder.table_name ADD CONSTRAINT FK_$builder.table_name$table_name FOREIGN KEY ($column_name) REFERENCES ${table_name}($table_id);') or {
		eprintln(err)
	}
}

pub fn (builder Builder) drop_foreign_key(table_name string) {
	builder.connection.query('ALTER TABLE $builder.table_name DROP FOREIGN KEY FK_$builder.table_name$table_name;') or {
		eprintln(err)
	}
}

pub fn (builder Builder) update(columns, values []string, where string) ?bool {
	mut sql_command := 'UPDATE $builder.table_name SET'
	for count := 0; count < columns.len; count += 1 {
		if count > 0 {
			sql_command += ','
		}
		column_name := columns[count]
		item_values := values[count]
		sql_command += " $column_name = '$item_values'"
	}
	if where.len > 2 {
		sql_command += ' WHERE $where'
	}
	builder.connection.query(sql_command) or {
		return error(err)
	}
	return true
}

pub fn (builder Builder) insert(names, values []string) ?bool {
	mut sql_command := 'INSERT INTO ' + builder.table_name + '('
	sql_command += names.join(',') + ') VALUES(' + values.join(',') + ')'
	builder.connection.query(sql_command) or {
		return error(err)
	}
	return true
}

pub fn (builder Builder) select_columns(columns []string, conditions map[string]string) ?[][]string {
	result := builder.connection.query('SELECT ' + columns.join(',') + ' FROM $builder.table_name' + generate_item(conditions)) or {
		return error(err)
	}
	return [][]string{}
}

pub fn (builder Builder) select_all(where, conditions string) ?[][]string {
	mut sql_command := 'SELECT * FROM $builder.table_name'
	if where.len > 2 {
		sql_command += ' WHERE $where'
	}
	if conditions.len > 2 {
		sql_command += conditions
	}
	result := builder.connection.query(sql_command) or {
		return error(err)
	}
	return [][]string{}
}

pub fn (builder Builder) delete(condition string) ?bool {
	sql_command := 'DELETE FROM ' + builder.table_name + ' WHERE ' + condition + ';'
	builder.connection.query(sql_command) or {
		return error(err)
	}
	return true
}
