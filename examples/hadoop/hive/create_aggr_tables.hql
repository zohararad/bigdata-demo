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
STORED AS TEXTFILE LOCATION '/exports/';