module database_connection

import mysql

#flag -I/usr/include/mysql
struct DatabaseAcess {
	connection  mysql.DB
	dao_classes map[string]ClassDao
}

fn (mut db DatabaseAcess) table_exists(table_name string) bool {
	tables := db.connection.query('SHOW TABLES') or {
		eprintln(err)
		return false
	}
	for row in tables.rows() {
		if row.vals[0] == table_name {
			return true
		}
	}
	return false
}

pub fn (mut db DatabaseAcess) generate_dao(table_name string) ?ClassDao {
	if !table_name in db.dao_classes {
		mut table_columns := [[]string{}]
		mut exist := true
		if db.table_exists(table_name) {
			table_description := db.connection.query('DESCRIBE $table_name') or {
				eprintln(err)
				return none
			}
			for columns in table_description.rows() {
				table_columns << columns.vals
			}
		} else {
			exist = false
		}
		db.dao_classes[table_name] = ClassDao{
			table_name: table_name
			connection: db.connection
			columns: table_columns
		}
		if !exist {
			db.dao_classes[table_name].create() or {
				return error(err)
			}
		}
	}
	return db.dao_classes[table_name]
}

pub fn create_connection(server, user, passwd, dbname string) ?DatabaseAcess {
	conn := mysql.connect(server, user, passwd, dbname) or {
		return error(err)
	}
	db := DatabaseAcess{
		connection: conn
	}
	return db
}

pub fn (db DatabaseAcess) get_connection() mysql.DB {
	return db.connection
}

pub fn (db DatabaseAcess) end() {
	db.connection.close()
}
