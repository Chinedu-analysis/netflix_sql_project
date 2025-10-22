# Netflix Data Analysis Project

1[Netflix Logo](https://github.com/Chinedu-analysis/netflix_sql_project/blob/main/logo.png)

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
· Ranking & Filtering: Advanced ranking techniques to identify top performer

💡 Use Cases

This analysis can help:

· Content strategists understand platform composition
· Marketing teams identify popular genres and trends
· Production companies analyze competitor content
· Researchers study streaming platform content patterns
· Data analysts learn advanced SQL techniques

🚀 Getting Started

The queries are written in PostgreSQL syntax and can be adapted to other SQL databases. Simply replace the netflix table references with your actual dataset and adjust date formats or functions as needed for your specific database system.

---

Explore the world of Netflix content through data-driven insights!
