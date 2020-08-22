module cimenteiro

enum QueryType {
	insert
	qselect
	update
	delete
}

enum Operation {
	undefined
	sum
	sub
	mul
	div
	mod
}

struct FieldValue {
	name      string
	operation Operation = .undefined
	value     string = ''
}

enum DataType {
	id
	foreign_id
	big_increments
	big_integer
	binary
	boolean
	char
	date
	date_time
	date_time_tz
	decimal
	double
	enumeration
	float
	geometry
	geometry_collection
	increments
	integer
	ip_address
	json
	jsonb
	line_string
	long_text
	mac_address
	medium_increments
	medium_integer
	medium_text
	morphs
	uuid_morphs
	multi_line_string
	multi_point
	multi_polygon
	nullable_morphs
	nullable_uuid_morphs
	nullable_timestamps
	point
	polygon
	remember_token
	set
	small_increments
	small_integer
	soft_deletes
	soft_deletes_tz
	db_string
	text
	time
	time_tz
	timestamp
	timestamp_tz
	timestamps
	timestamps_tz
	tiny_increments
	tiny_integer
	unsigned_big_integer
	unsigned_decimal
	unsigned_integer
	unsigned_medium_integer
	unsigned_small_integer
	unsigned_tiny_integer
	uuid
	year
}

enum TypeModifier {
	auto_increment
	first
	nullable
}
