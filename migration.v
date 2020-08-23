module cimenteiro

struct Field {
	name          string
	data_type     DataType = .id
	size          string = ''
	mut:
		default_value string = ''
		modifiers     []TypeModifier
}

struct Migration {
	table_name string = ''
	mut:
		fields     []Field
}

/*add modifications in table, like
* ADD
* DROP
* MODIFY
* ADD CONSTRAINT FK_
* DROP FOREIGN KEY FK_
*/
pub fn (mut migration Migration) field(name string, ftype DataType, size string) &Field {
	migration.fields << Field{
		name: name
		data_type: ftype
		size: size
	}
	return &migration.fields[migration.fields.len]
}

pub fn (mut field Field) nullable() &Field {
	field.modifiers << .nullable
	return field
}

pub fn (mut field Field) auto_increment() &Field {
	field.modifiers << .auto_increment
	return field
}

pub fn (mut field Field) default_value(value string) &Field {
	field.default_value = value
	return field
}

fn (field Field) build() string {
	return '$field.name $field.data_type.str()'
}

pub fn (migration Migration) end() {
	mut sql_command := 'CREATE TABLE $migration.table_name ('
	for index := 0; index < migration.fields.len; index++ {
		if index > 0 {
			sql_command += ','
		}
		sql_command += migration.fields[index].build()
	}
	sql_command += ');'
}

// create drop and modify functions
