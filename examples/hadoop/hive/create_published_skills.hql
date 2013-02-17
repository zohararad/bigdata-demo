CREATE TABLE IF NOT EXISTS published_skills
ROW FORMAT
SERDE 'org.apache.hadoop.hive.serde2.avro.AvroSerDe'
STORED AS
INPUTFORMAT 'org.apache.hadoop.hive.ql.io.avro.AvroContainerInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.avro.AvroContainerOutputFormat'
TBLPROPERTIES ('avro.schema.literal'='{
  "type": "record",
  "name": "position",
  "fields": [
    {"name": "company", "type": "string"},
    {"name": "position", "type": "string"},
    {"name": "location", "type": "string"},
    {"name": "skill", "type": "string"},
    {"name": "created_at", "type": "int"}
  ]
}');

LOAD DATA LOCAL INPATH '/Users/zohar/workspace/bigdata-demo/log/positions.avr'
OVERWRITE INTO TABLE published_skills;

SELECT * FROM published_skills;