module cimenteiro

enum ColumnType {
	boolean // ColumnSameNameType
	char
	date
	double
	float
	integer
	time
	timestamp
	timestamps
	text
	string_ // ColumnCloseName
	id // ColumnHelperType
	big_increments // ColumnNameBySpace
	big_integer
	date_time
	date_time_tz
	ip_address
	line_string
	mac_address
	medium_increments
	medium_integer
	medium_text
	long_text
	uuid_morphs
	multi_line_string
	multi_point
	multi_polygon
	nullable_morphs
	nullable_uuid_morphs
	nullable_timestamps
	geometry_collection
	small_increments
	small_integer
	soft_deletes
	soft_deletes_tz
	time_tz
	timestamp_tz
	timestamps_tz
	tiny_increments
	tiny_integer
	unsigned_big_integer
	unsigned_decimal
	unsigned_integer
	unsigned_medium_integer
	unsigned_small_integer
	unsigned_tiny_integer
	binary
	decimal
	enumeration
	geometry
	increments
	json
	jsonb
	morphs
	point
	polygon
	set
	uuid
	year
}

fn (dt ColumnType) to_str() string {
	if dt in
		[ColumnType.boolean, .char, .date, .double, .float, .integer, .time, .timestamp, .timestamps, .text] {
		// types with same name
		return dt.str().to_upper()
	} else if dt in
		[ColumnType.big_increments, .big_integer, .ip_address, .line_string, .mac_address, .medium_increments, .medium_integer, .medium_text, .long_text, .uuid_morphs, .multi_line_string, .multi_point, .multi_polygon, .nullable_morphs, .nullable_uuid_morphs, .nullable_timestamps, .geometry_collection, .small_increments, .small_integer, .soft_deletes, .soft_deletes_tz, .time_tz, .timestamp_tz, .timestamps_tz, .tiny_increments, .tiny_integer, .unsigned_big_integer, .unsigned_decimal, .unsigned_integer, .unsigned_medium_integer, .unsigned_small_integer, .unsigned_tiny_integer] {
		// types with same name but space between
		return dt.str().replace('_', ' ').to_upper()
	} else if dt == ColumnType.date_time {
		// types with same name but without space between
		return dt.str().replace('_', '').to_upper()
	} else if dt == .string_ {
		return 'VARCHAR'
	}
	return dt.str().to_upper()
}
