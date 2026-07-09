SELECT *
FROM "2019";

1. Query: List all countries and their happiness scores (descending). CORRECT
SELECT country_or_region, score AS happiness_score
FROM "2019";


2.Top 10 happiest & bottom 10 countries. CORRECT 
SELECT country_or_region, score 
FROM "2019"
ORDER BY score ASC
LIMIT 10;

SELECT country_or_region, score
FROM "2019"
ORDER BY score DESC
LIMIT 10;


3 . Count of countries in the dataset. CORRECT
SELECT COUNT (country_or_region) AS total_countries,
		ROUND (AVG (score),2) AS avg_happiness_score,
		ROUND (AVG(gdp_per_capita),2) AS avg_gdp_per_capita,
		ROUND (AVG(social_support),2) AS avg_social_support,
		ROUND (AVG(healthy_life_expectancy),2) AS avg_healthy_life_expectancy,
		ROUND (AVG(freedom_to_make_life_choices),2) AS avg_freedom_to_make_life_choices,
		ROUND (AVG(generosity),2) AS avg_generosity,
		ROUND (AVG(perceptions_of_corruption),2) AS avg_perceptions_of_corruption
FROM "2019";


SELECT country_or_region as max_happy_country_score
FROM "2019"
WHERE score =
	(SELECT MAX (score) AS max_Happy_country
	FROM "2019");
	
SELECT country_or_region AS less_happy_country
FROM "2019"
WHERE score =
	(SELECT MIN (score) AS less_happy_country
	FROM "2019");

SELECT country_or_region as country_highest_gdp_per_capita
FROM "2019"
WHERE gdp_per_capita =
	(SELECT MAX (gdp_per_capita)
	FROM "2019");

SELECT country_or_region AS country_highest_perception_corruption
FROM "2019"
WHERE perceptions_of_corruption =
	(SELECT MIN (perceptions_of_corruption)
	FROM "2019");


4.. Average global happiness score. CORRECT 
SELECT ROUND(AVG(score),2) as Avg_global_happiness_score
FROM "2019";

SELECT country_or_region
FROM "2019"
WHERE score >
	(SELECT AVG(score)
FROM "2019");

SELECT country_or_region
FROM "2019"
WHERE score <
	(SELECT AVG(score)
FROM "2019");


5 Country with the highest GDP per capita vs global average happiness. CORRECT
SELECT country_or_region, gdp_per_capita, (SELECT AVG(score) FROM "2019") as Global_avg_hapiness
FROM "2019"
ORDER BY gdp_per_capita DESC
LIMIT 1;

6 Top 5 countries with the highest social support CORRECT 
SELECT country_or_region, social_support
FROM "2019"
ORDER BY social_support DESC
LIMIT 5

7 Top 5 countries ranked by healthy life expectancy. CORRECT 
SELECT country_or_region, healthy_life_expectancy
FROM "2019"
ORDER BY healthy_life_expectancy DESC
LIMIT 5;

8 . Lowest corruption perception countries vs happiness scores. CORRECT
SELECT country_or_region, perceptions_of_corruption, score
FROM "2019"
ORDER BY perceptions_of_corruption DESC;

9 Generosity vs happiness correlation (above vs below average generosity DONE BY CHAT GPT
SELECT
    country_or_region,
    generosity,
    score,
    CASE
        WHEN generosity > (
            SELECT AVG(generosity)
            FROM "2019"
        )
        THEN 'Above Average'
        ELSE 'Below Average'
    END AS generosity_group
FROM "2019"
ORDER BY generosity DESC;

SELECT
    CASE
        WHEN generosity > (
            SELECT AVG(generosity)
            FROM "2019"
        )
        THEN 'Above Average'
        ELSE 'Below Average'
    END AS generosity_group,
    ROUND(AVG(score), 2) AS average_happiness
FROM "2019"
GROUP BY generosity_group;


10. Countries with the largest difference between GDP rank and happiness rank. CORRECT
SELECT country_or_region, gdp_ranking, happiness_ranking , ABS(gdp_ranking - happinesS_ranking) as difference
FROM (
	SELECT country_or_region, gdp_per_capita, score,
	RANK() OVER (ORDER BY gdp_per_capita DESC) AS gdp_ranking,
	RANK() OVER (ORDER BY score DESC) AS happiness_ranking
FROM "2019")
ORDER BY difference DESC;


11. Compare GDP per capita ranking vs happiness ranking.  CORRECT 
SELECT country_or_region, gdp_per_capita, score,
	DENSE_RANK() OVER (ORDER BY gdp_per_capita) AS gdp_ranking,
	DENSE_RANK() OVER (ORDER BY score) AS happiness_ranking
FROM "2019"
ORDER BY gdp_ranking DESC;


12. Categorise into High/Medium/Low happiness groups.  CORRECT
SELECT country_or_region, score,
	CASE
		WHEN score >=7 THEN 'High'
		WHEN score >=4.5 THEN 'Medium'
		ELSE 'Low'
	END AS happiness_score_categories
FROM "2019"
ORDER BY score DESC;


13. Top 5 countries with high social support & freedom. CORRECT 
SELECT country_or_region, social_support, freedom_to_make_life_choices
FROM "2019"
ORDER BY social_support DESC
LIMIT 5;

SELECT country_or_region, social_support, freedom_to_make_life_choices
FROM "2019"
ORDER BY freedom_to_make_life_choices DESC
LIMIT 5;