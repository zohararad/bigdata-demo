# MongoDB CRUD

```
mongo bigdata_demo_development examples/mongo/crud/create.js
mongo bigdata_demo_development examples/mongo/crud/find.js
mongo bigdata_demo_development examples/mongo/crud/update.js
mongo bigdata_demo_development examples/mongo/crud/delete.js
```

# MongoDB Advanced

## Generate some data
```
padrino rake db:seed_users
padrino rake db:seed_user_friends
padrino rake db:seed_positions
```

## Advanced Queries

```
mongo bigdata_demo_development examples/mongo/advanced/indices.js
mongo bigdata_demo_development examples/mongo/advanced/find_regex_begin.js
mongo bigdata_demo_development examples/mongo/advanced/find_regex_not.js
mongo bigdata_demo_development examples/mongo/advanced/find_size.js
mongo bigdata_demo_development examples/mongo/advanced/find_where.js
mongo bigdata_demo_development examples/mongo/advanced/find_sorted.js
```

# MongoDB MapR

```
mongo bigdata_demo_development examples/mongo/mapr/count_skills.js
```