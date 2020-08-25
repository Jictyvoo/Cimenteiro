module cimenteiro

enum TypeModifier {
	auto_increment
	first
	nullable
}

fn (tymod TypeModifier) str() string {
	return match tymod {
		.auto_increment { 'AUTO INCREMENT' }
		.first { 'FIRST' }
		.nullable { 'NOT NULL' }
	}
}
