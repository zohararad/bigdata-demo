-- $HADOOP_HOME/bin/start-all.sh

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

LOAD DATA LOCAL INPATH '/Users/zohar/workspace/linkedin-clone/log/positions.avr'
OVERWRITE INTO TABLE published_skills;

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

LOAD DATA LOCAL INPATH '/Users/zohar/workspace/linkedin-clone/log/skills.avr'
OVERWRITE INTO TABLE searched_skills;

CREATE TABLE IF NOT EXISTS published_skills_popularity (
  skill           STRING,
  popularity      INT
);

CREATE TABLE IF NOT EXISTS searched_skills_popularity (
  skill           STRING,
  popularity      INT
);

CREATE EXTERNAL TABLE IF NOT EXISTS aggregated_skills_popularity (
  skill                 STRING,
  position_popularity   INT,
  search_popularity     INT
)
ROW FORMAT delimited fields TERMINATED BY ',' lines TERMINATED BY '\n'
STORED AS TEXTFILE LOCATION '/exports/'
;

INSERT OVERWRITE TABLE published_skills_popularity
SELECT skill, COUNT(skill) FROM published_skills GROUP BY skill;

INSERT OVERWRITE TABLE searched_skills_popularity
SELECT keyword, COUNT(keyword) FROM searched_skills GROUP BY keyword;

INSERT OVERWRITE TABLE aggregated_skills_popularity
SELECT published_skills_popularity.*, searched_skills_popularity.popularity AS search_popularity
FROM published_skills_popularity
LEFT OUTER JOIN searched_skills_popularity ON
published_skills_popularity.skill = searched_skills_popularity.skill;

SELECT * FROM aggregated_skills_popularity
ORDER BY position_popularity DESC, search_popularity DESC;

-- hadoop dfs -ls /exports/
-- hadoop dfs -get /exports/000000_0.avro .