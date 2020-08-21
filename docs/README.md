# Cimenteiro

It's a QueryBuilder library for V that allows users to simply create queries to their programs, without care about the database used

## Supporting DBs

- SQLite
- MySQL

## Examples

```v
import cimenteiro

cimento := cimenteiro.Builder{}
user_migration := cimenteiro.Migration{}
user_migration.add_field('name', .varchar,30)
println(user_migration.migrate())
```
