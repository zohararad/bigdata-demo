# Avro Storage

* Display Avro Loggers
* Explain Schema

```
padrino rake avro:seed_positions
padrino rake avro:seed_skill_search
```

# Apache Hive

```
$HADOOP_HOME/bin/start-all.sh # start hadoop
jps # check Hadoop is running

hive -f create_published_skills.hql
hive -f create_searched_skills.hql
hive -f create_aggr_tables.hql
hive -f aggregate_data.hql

hadoop dfs -ls /exports/
hadoop dfs -get /exports/000000_0.avro ./results.tsv
cat results.tsv
```

# Apache Pig

```
$HADOOP_HOME/bin/stop-all.sh # stop hadoop
jps # check Hadoop is running
```

## Hive example in Pig

```
pig -x local popular_skills_by_position.pql
```

## Aggregated search term popularity by hour

```
pig -x local search_history.pql
```

### Show stored term popularity results in MongoDB

```
mongo bigdata_demo_development find_hourly_searches.js
```

### Create additional log entries:

```
padrino rake avro:seed_skill_search
```

### Run MapR Again

```
pig -x local search_history.pql
```

## Show stored term popularity results in MongoDB

```
mongo bigdata_demo_development find_hourly_searches.js
```