/* Netflix Project
CREATE TABLE netflix(
show_id	VARCHAR(10),
type VARCHAR (10),
title VARCHAR (150),
director VARCHAR (250),
casts VARCHAR (1000),
country	VARCHAR (150),
date_added VARCHAR (50),
release_year INT,
rating	VARCHAR (10),
duration VARCHAR (15),
listed_in VARCHAR (150),
description VARCHAR (250)
); */

SELECT * FROM netflix;

SELECT COUNT(*)
FROM netflix;

-- BUSINESS PROBLEMS AND SOLUTIONS
-- 15 Business Problems & Solutions
/*
1. Count the number of Movies vs TV Shows
2. Find the most common rating for movies and TV shows
3. List all movies released in a specific year (e.g., 2020)
4. Find the top 5 countries with the most content on Netflix
5. Identify the longest movie
6. Find content added in the last 5 years
7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
8. List all TV shows with more than 5 seasons
9. Count the number of content items in each genre
10.Find each year and the average numbers of content release in India on netflix. 
return top 5 year with highest avg content release!
11. List all movies that are documentaries
12. Find all content without a director
13. Find how many movies actor 'Salman Khan' appeared in last 10 years!
14. Find the top 10 actors who have appeared in the highest number of movies produced in India.
15.
Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
the description field. Label content containing these keywords as 'Bad' and all other 
content as 'Good'. Count how many items fall into each category. 
*/

-- 1. Count the number of Movies vs TV Shows
SELECT 
	type,
	COUNT(*) AS total_content
FROM netflix
GROUP BY type;

-- 2. Find the most common rating for movies and TV shows
SELECT 
	type,
	rating
FROM (
	SELECT 
		type,
		rating,
		COUNT(*) AS total_rating,
		RANK () OVER (PARTITION BY type ORDER BY COUNT(*) DESC) AS ranking
	FROM netflix
	GROUP BY type, rating
	-- ORDER BY type;
	) AS t1
WHERE ranking = 1;

-- 3. List all movies released in a specific year (e.g., 2020)
SELECT 
	*
FROM netflix
WHERE type = 'Movie' and release_year = 2020;

-- 4. Find the top 5 countries with the most content on Netflix

SELECT
	ltrim(UNNEST(STRING_TO_ARRAY(country, ','))) AS countries,
	COUNT(*) AS total_content,
	RANK () OVER (ORDER BY COUNT(*) DESC)
FROM netflix
GROUP BY ltrim(UNNEST(STRING_TO_ARRAY(country, ',')))
LIMIT 5;

-- 5. Identify the longest movie
SELECT
	type,
	MAX(duration_interval)
FROM (
	SELECT
		*,
		(duration || 'utes') :: INTERVAL AS duration_interval
	FROM netflix
	WHERE type = 'Movie'
	) AS t1
WHERE duration_interval IS NOT NULL
GROUP BY 1
ORDER BY 2 DESC;

-- 6. Find content added in the last 5 years
SELECT 
	*,
	TO_DATE(date_added, 'Month DD - YY') AS new_date_added
FROM netflix
WHERE TO_DATE(date_added, 'Month DD - YY') >= CURRENT_DATE - INTERVAL '5 YEARS';

-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!

SELECT
	*
FROM netflix
WHERE director ILIKE '%Rajiv Chilaka%';

-- 8. List all TV shows with more than 5 seasons 
SELECT 
	*
FROM netflix
WHERE type = 'TV Show' AND SPLIT_PART(duration, ' ', 1) :: NUMERIC > 5;

--9. Count the number of content items in each genre

SELECT 
	COUNT(*),
	UNNEST(STRING_TO_ARRAY(listed_in, ', ')) AS genres
FROM netflix
GROUP BY UNNEST(STRING_TO_ARRAY(listed_in, ', '))
ORDER BY COUNT(*) DESC;

--10.Find each year and the average numbers of content release in India on netflix. 
-- return top 5 year with highest avg content release!

SELECT
	EXTRACT(YEAR FROM TO_DATE(date_added, 'MONTH DD - YY')),
	COUNT(*),
	ROUND(COUNT(*) / SUM(COUNT(*)) OVER (), 2) * 100 AS yearly_avg
FROM netflix
WHERE country = 'India'
GROUP BY 1;


-- 11. List all movies that are documentaries
SELECT *
FROM netflix
WHERE listed_in ILIKE '%Documentaries%';

-- 12. Find all content without a director
SELECT *
FROM netflix
WHERE director IS NULL,

-- 13. Find how many movies actor 'Salman Khan' appeared in last 10 years!
SELECT
	*
FROM netflix
WHERE casts ILIKE '%Salman Khan%' AND release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10;

-- 14. Find the top 10 actors who have appeared in the highest number of movies produced in India.
SELECT
	UNNEST(STRING_TO_ARRAY(casts, ', ')) AS total_actors,
	COUNT (*)
FROM netflix
WHERE country ILIKE '%India%'
GROUP BY 1
ORDER BY COUNT (*) DESC
LIMIT 10;

-- 15. Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
-- the description field. Label content containing these keywords as 'Bad' and all other 
-- content as 'Good'. Count how many items fall into each category. 
SELECT 
	CASE
		WHEN description ILIKE '%kill%' OR description ILIKE '%violence%' THEN 'Bad'
		ELSE 'Good'
	END description_category,
	COUNT(*) AS total_content
FROM netflix
-- WHERE description ILIKE '%kill%' OR description ILIKE '%violence%'
GROUP BY 1;











