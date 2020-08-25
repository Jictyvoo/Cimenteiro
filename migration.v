module cimenteiro

[ref_only]
struct Field {
	name          string
	data_type     ColumnType = .id
	args          string = ''
mut:
	default_value string = ''
	modifiers     []TypeModifier
}

struct Migration {
	table_name string = ''
mut:
	fields     []&Field
}

pub fn (mut migration Migration) field_args(name string, ftype ColumnType, args string) &Field {
	new_field := &Field{
		name: name
		data_type: ftype
		args: args
	}
	migration.fields << new_field
	return new_field
}

pub fn (mut migration Migration) field(name string, ftype ColumnType) &Field {
	return migration.field_args(name, ftype, '')
}

fn (field &Field) add_modifier(modifier TypeModifier) &Field {
	mut modification := field
	modification.modifiers << modifier
	return modification
}

pub fn (field &Field) nullable() &Field {
	return field.add_modifier(.nullable)
}

pub fn (field &Field) auto_increment() &Field {
	return field.add_modifier(.auto_increment)
}

pub fn (field &Field) default_value(value string) &Field {
	mut modification := field
	modification.default_value = value
	return modification
}

fn (field &Field) build() string {
	mut to_return := '$field.name $field.data_type.to_str()'
	if field.args.len > 0 {
		to_return += '($field.args)'
	}
	for modifier in field.modifiers {
		to_return += ' $modifier.str()'
	}
	return to_return
}

pub fn (migration Migration) end() string {
	mut sql_command := 'CREATE TABLE $migration.table_name ('
	for index := 0; index < migration.fields.len; index++ {
		if index > 0 {
			sql_command += ','
		}
		sql_command += migration.fields[index].build()
	}
	sql_command += ');'
	return sql_command
}

pub fn (migration Migration) free() {
	for field in migration.fields {
		unsafe {
			C.free(field)
		}
	}
	unsafe {
		C.free(&migration)
	}
}

/*
add modifications in table, like
* ADD
* DROP
* MODIFY
* ADD CONSTRAINT FK_
* DROP FOREIGN KEY FK_
*/
