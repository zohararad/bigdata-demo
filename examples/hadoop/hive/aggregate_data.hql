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