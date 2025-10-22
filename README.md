# Netflix Data Analysis Project

[Netflix Logo](https://github.com/Chinedu-analysis/netflix_sql_project/blob/main/logo.png)

A comprehensive SQL-based analysis of Netflix's content catalog, exploring various aspects of movies and TV shows available on the streaming platform.

📊 Project Overview

This repository contains SQL queries that analyze Netflix's content database to extract meaningful insights about movies, TV shows, ratings, genres, and more. The analysis covers content distribution, popularity trends, geographical patterns, and content categorization.

🎯 Key Analyses Performed

Content Statistics

· Content Type Distribution: Count of Movies vs TV Shows
· Rating Analysis: Most common ratings for movies and TV shows
· Genre Breakdown: Number of content items in each genre category

Temporal Analysis

· Recent Content: Content added in the last 5 years
· Annual Releases: Movies released in specific years (e.g., 2020)
· Career Analysis: Actor appearances over time (e.g., Salman Khan in last 10 years)

Geographical Insights

· Top Countries: Top 5 countries with the most Netflix content
· Regional Content: Content release patterns in specific countries like India

Content Characteristics

· Duration Analysis: Identification of the longest movies
· Season Analysis: TV shows with more than 5 seasons
· Director Focus: Content by specific directors (e.g., Rajiv Chilaka)
· Genre Filtering: Documentary movies and specific content types

Advanced Analytics

· Actor Popularity: Top 10 actors in Indian-produced content
· Content Categorization: Classification based on content description keywords
· Missing Data: Identification of content without directors

🛠 Technical Features

· SQL Functions Used: Window functions, string manipulation, date conversion, aggregation
· Data Processing: Handling of array-like data in columns using UNNEST and STRING_TO_ARRAY
· Pattern Matching: ILIKE operations for flexible text searching
· Ranking & Filtering: Advanced ranking techniques to identify top performers

💡 Use Cases

This analysis can help:

· Content strategists understand platform composition
· Marketing teams identify popular genres and trends
· Production companies analyze competitor content
· Researchers study streaming platform content patterns
· Data analysts learn advanced SQL techniques

## 📋 SQL Queries

### Database Creation & Table Setup

```sql
-- Create Netflix table structure
CREATE TABLE netflix(  
    show_id VARCHAR(10),  
    type VARCHAR(10),  
    title VARCHAR(150),  
    director VARCHAR(250),  
    casts VARCHAR(1000),  
    country VARCHAR(150),  
    date_added VARCHAR(50),  
    release_year INT,  
    rating VARCHAR(10),  
    duration VARCHAR(15),  
    listed_in VARCHAR(150),  
    description VARCHAR(250)  
);
```

```sql
-- View all data from Netflix table
SELECT * FROM netflix;
```

## Business Problems and Solutions

### 1. Count the number of Movies vs TV Shows

```sql
SELECT
    type,
    COUNT(*) AS total_content
FROM netflix
GROUP BY type;
```

### 2. Find the most common rating for movies and TV shows

```sql
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
) AS tl
WHERE ranking = 1;
```

### 3. List all movies released in a specific year (e.g., 2020)

```sql
SELECT
    * 
FROM netflix
WHERE type = 'Movie' and release_year = 2020;
```

### 4. Find the top 5 countries with the most content on Netflix

```sql
SELECT
    ltrim(UNNEST(STRING_TO_ARRAY(country, ','))) AS countries,
    COUNT(*) AS total_content,
    RANK () OVER (ORDER BY COUNT(*) DESC)
FROM netflix
GROUP BY ltrim(UNNEST(STRING_TO_ARRAY(country, ',')))
LIMIT 5;
```

### 5. Identify the longest movie

```sql
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
```

### 6. Find content added in the last 5 years

```sql
SELECT
    *,
    TO_DATE(date_added, 'Month DD - YY') AS new_date_added
FROM netflix
WHERE TO_DATE(date_added, 'Month DD - YY') >= CURRENT_DATE - INTERVAL '5 YEARS';
```

### 7. Find all the movies/TV shows by director 'Rajiv Chilaka'

```sql
SELECT
    *
FROM netflix
WHERE director ILIKE '%Rajiv Chilaka%';
```

### 8. List all TV shows with more than 5 seasons

```sql
SELECT
    *
FROM netflix
WHERE type = 'TV Show' AND SPLIT_PART(duration, ' ', 1) :: NUMERIC > 5;
```

### 9. Count the number of content items in each genre

```sql
SELECT
    COUNT(*),
    UNNEST(STRING_TO_ARRAY(listed_in, ', ')) AS genres
FROM netflix
GROUP BY UNNEST(STRING_TO_ARRAY(listed_in, ', '))
ORDER BY COUNT(*) DESC;
```

### 10. Find each year and the average numbers of content release in India on Netflix

```sql
SELECT
    EXTRACT(YEAR FROM TO_DATE(date_added, 'MONTH DD - YY')),
    COUNT(*),
    ROUND(COUNT(*) / SUM(COUNT(*)) OVER (), 2) * 100 AS yearly_avg
FROM netflix
WHERE country = 'India'
GROUP BY 1;
```

### 11. List all movies that are documentaries

```sql
SELECT *
FROM netflix
WHERE listed_in ILIKE '%Documentaries%';
```

### 12. Find all content without a director

```sql
SELECT *
FROM netflix
WHERE director IS NULL;
```

### 13. Find how many movies actor 'Salman Khan' appeared in last 10 years

```sql
SELECT
    *
FROM netflix
WHERE casts ILIKE '%Salman Khan%' AND release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10;
```

### 14. Find the top 10 actors who have appeared in the highest number of movies produced in India

```sql
SELECT
    UNNEST(STRING_TO_ARRAY(casts, ', ')) AS total_actors,
    COUNT(*)
FROM netflix
WHERE country ILIKE '%India%'
GROUP BY 1
ORDER BY COUNT(*) DESC
LIMIT 10;
```

### 15. Categorize content based on keywords in description

```sql
SELECT
    CASE
        WHEN description ILIKE '%kill%' OR description ILIKE '%violence%' THEN 'Bad'
        ELSE 'Good'
    END description_category,
    COUNT(*) AS total_content
FROM netflix
GROUP BY 1;
```

🚀 Getting Started

The queries are written in PostgreSQL syntax and can be adapted to other SQL databases. Simply replace the netflix table references with your actual dataset and adjust date formats or functions as needed for your specific database system.

Prerequisites

· PostgreSQL database
· Netflix dataset with appropriate table structure
· Basic SQL knowledge

Usage

1. Clone this repository
2. Ensure you have the Netflix dataset loaded in your database
3. Execute the queries in your preferred SQL client
4. Modify parameters as needed for your analysis

---
## About the Author

Data Analyst | SQL Specialist

Passionate about transforming raw data into meaningful insights through SQL and data storytelling. I enjoy exploring entertainment trends and building analytical solutions.

Connect with me:

### • LinkedIn [Connect with me professionally](https://www.linkedin.com/in/emodi-emeka-8ba2071b2?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app)
### • Twitter [Let's connect](https://x.com/Emodi__E?t=tCstz-0wZgSynu8gjOXnfg&s=09)

Open to:

· Data Analyst opportunities
· SQL and analytics projects
· Collaborative data initiatives

"Turning data into decisions, one query at a time."
Explore the world of Netflix content through data-driven insights!
