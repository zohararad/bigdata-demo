CREATE TABLE IF NOT EXISTS searched_skills
ROW FORMAT
SERDE 'org.apache.hadoop.hive.serde2.avro.AvroSerDe'
STORED AS
INPUTFORMAT 'org.apache.hadoop.hive.ql.io.avro.AvroContainerInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.avro.AvroContainerOutputFormat'
TBLPROPERTIES ('avro.schema.literal'='{
  "type": "record",
  "name": "skill",
  "fields": [
    {"name": "keyword", "type": "string"},
    {"name": "timestamp", "type": "int"}
  ]
}');

LOAD DATA LOCAL INPATH '/Users/zohar/workspace/bigdata-demo/log/skills.avr'
OVERWRITE INTO TABLE searched_skills;

SELECT * FROM searched_skills;