module cimenteiro

pub struct Builder {
mut:
	table_name  string
	query_type QueryType =.select_
	query_args []FieldValue
}

fn generate_item(values map[string]string) string {
	mut generated_items := ''
	for key, value in values {
		generated_items += ' $key $value'
	}
	return generated_items
}

pub fn (builder Builder) update(columns, values []string, where string) Builder {
	mut sql_command := 'UPDATE $builder.table_name SET'
	for count := 0; count < columns.len; count++ {
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
	builder.query(sql_command)
	return builder
}

pub fn (builder Builder) query(the_query string) {
	println(the_query)
}

pub fn (builder Builder) insert(names, values []string) Builder {
	mut sql_command := 'INSERT INTO ' + builder.table_name + '('
	sql_command += names.join(',') + ') VALUES(' + values.join(',') + ')'
	return builder
}

pub fn (builder Builder) select_columns(columns []string) Builder {
	builder.query('SELECT ' + columns.join(',') + ' FROM $builder.table_name')
	return builder
}

pub fn (builder Builder) select_all(where, conditions string) Builder {
	mut sql_command := 'SELECT * FROM $builder.table_name'
	if where.len > 2 {
		sql_command += ' WHERE $where'
	}
	if conditions.len > 2 {
		sql_command += conditions
	}
	builder.query(sql_command)
	return builder
}

pub fn (builder Builder) delete(condition string) Builder {
	sql_command := 'DELETE FROM ' + builder.table_name + ' WHERE ' + condition + ';'
	builder.query(sql_command)
	return builder
}
