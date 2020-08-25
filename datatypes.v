module cimenteiro

enum QueryType {
	insert
	select_
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
