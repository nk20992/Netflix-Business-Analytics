

--- 10 business analytics problems----
---1. Number of movies vs TV shows---

select type_of_content, count(*) as total_content
from netflix
group by type_of_content;


---2. Most common rating for movies and TV shows----
select 
	type_of_content,
	rating
from
(
	select
		type_of_content,
		rating,
		count(*),
		rank() over(partition by type_of_content order by count(*) desc) as ranking
	from netflix
	group by 1, 2 
) as t1
where
	ranking = 1;


----3.list all movies released in 2020
select * from netflix
where 
	type_of_content = 'Movies'
	and
	release_year = 2020;

-----4. Top 5 countries with the most Netflix content---
select 
	unnest(string_to_array(country, ',' )) as new_country,
	count(show_id) as total_content
from netflix
group by 1
order by 2 desc
limit 5;


----5.Identification of longest movies---
select 
	*
from netflix
where 
	type_of_content = 'Movie'
	and 
	duration = (select max(duration) from netflix)



------6.Finding content in last 5 year range----
select 
	*	
from netflix
where 
	date_added >= current_date - interval '5 years' 



-----7. List all series with more than 5 season---
select 
	*
from netflix
where
	type_of_content = 'TV Show'
	and
	split_part(duration, ' ', 1)::numeric > 5 


-----8.Count the number of content items in each genre
select 
	unnest(string_to_array(listed_in, ',')) as genre,
	count(show_id) as total_content
from netflix
group by 1;

----9.List all movies that are documentaries---
select 
	*
from netflix
where
	listed_in ilike '%Documentaries';

-----10. Find content without director---
select * from netflix
where
	director is null;


	
---Thank-you----


