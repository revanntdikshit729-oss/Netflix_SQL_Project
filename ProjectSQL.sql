-- Netflix Project

DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix
(
	Show_id VARCHAR(6),
	type	 VARCHAR(10),
	title    VARCHAR(150),
	director VARCHAR(250),
	casts     VARCHAR(1000),
	country  VARCHAR(150),
	date_added   VARCHAR(50),
	release_year   INT,
	rating      VARCHAR(10),
	duration    VARCHAR(15),
	listed_in   VARCHAR(100),
	description    VARCHAR(250)
);

select * from netflix;

-- 10 Business Problems and Solutions

-- 1. Count the number of Movies vs TV Shows

select
	Type,
	count(*) as Total_content
from netflix
group by Type;


-- 2.Find the most common rating for movies and TV Shows

select
	type,
	rating
from(
select
	type,
	rating,
	count(*),
	rank() over(partition by type order by count(*) desc) as ranking
from netflix
group by type,rating
order by type,count(*) desc
) as t1
where ranking = 1;

-- 3. List all movies released in a specific year (e.g., 2020)

select *
from netflix
where type = 'Movie' and release_year = 2020;

-- 4. Find the top 5 countries with the most content on netflix

select 
	unnest(string_to_array(country,',')) as new_country,
	count(show_id) as tot_content
from netflix
group by new_country
order by tot_content desc
limit 5;

-- 5. Identify the longest movie

select *
from netflix
where type = 'Movie' and duration = (select max(duration) from netflix)

-- 6. Find Content added in last 5 years

select * 
from netflix
where to_date(date_added, 'month DD, YYYY') >= current_date - interval '5 years'

-- 7. Find all the movies/TV Shows directed by Rajiv Chilaka

select *
from netflix
where director like '%Rajiv Chilaka%';

-- 8. List all TV shows with more than 5 seasons

select *
from netflix
where type = 'TV Show' and split_part(duration,' ',1) :: numeric > 5 

--9. Count the number of content items in each genre

select 
	unnest(string_to_array(listed_in,',')) as genre,
	count(*) as no_of_content
from netflix
group by genre;

--10. List all movies that are documentaries

select *
from netflix
where listed_in ilike '%Documentaries%'


















