-- =========================================================
-- Netflix Content Analysis
-- Tool    : MySQL
-- Database: netflix_project
-- Table   : netflix_titles
-- =========================================================
   USE netflix_project;
-- ======================================================
-- Understanding the Dataset
-- ======================================================
    
-- Q1. Display all records.
   
-- SELECT * FROM netflix_titles;

-- Q2. Count the total number of titles.

-- SELECT 
         COUNT(title) 
         FROM netflix_titles;

-- Q3. Find all unique content types (Movie/TV Show).

-- SELECT 
          DISTINCT(type)
          FROM netflix_titles;
          
-- Q4. Find all TV shows with more than 5 seasons.

-- SELECT 
         type,
         title
         FROM netflix_titles
         WHERE type = 'TV Show'
         AND season_count >5;

-- Q5. List titles from India.

-- SELECT 
         title,
         country
         FROM netflix_titles
         WHERE country ='India';


-- Q6. Find movies longer than 150 minutes.

-- SELECT 
         title,
         type,
         duration_minutes
         FROM netflix_titles
         WHERE type = 'Movie'
         AND duration_minutes > 150;

-- ======================================================
-- Key Aggregations
-- ======================================================

-- Q7. Count of titles per rating.

-- SELECT 
         COUNT(title) AS title_count,
         rating 
         FROM netflix_titles
         GROUP BY rating;

-- Q8. Average movie duration per release year.

-- SELECT
         release_year,
         AVG(duration_minutes) AS "Average movie duration"
		 FROM netflix_titles
         WHERE type = "Movie"
		 GROUP BY release_year;

-- Q9. Count of titles per country.

-- SELECT 
        Country,
        COUNT(title) AS title_count
        FROM netflix_titles
        GROUP BY country;

-- Q10. Number of titles added per year (year_added).

-- SELECT 
         COUNT(title) AS title_count,
         year_added
         FROM netflix_titles
         GROUP BY year_added;

-- Q11. Which director has the most titles.

-- SELECT 
         director,
         COUNT(title) AS title_count
         FROM netflix_titles
         WHERE director IS NOT NULL
         GROUP BY director
         ORDER BY title_count DESC
         LIMIT 1;
         
-- Q12. Average number of seasons per rating category.

-- SELECT 
		 rating,
         AVG(season_count) AS avg_seasons
         FROM netflix_titles
         WHERE type = 'TV Show'
         GROUP BY rating;
-- ======================================================
-- Deeper Analysis
-- ======================================================

-- Q13. Count how many titles have no director listed.

-- SELECT
         COUNT(*) AS 'titles without director'
         FROM netflix_titles
         WHERE director IS NULL;
         
-- Q14. List the top 10 most recently added titles.

-- SELECT 
         title,
         year_added
         FROM netflix_titles
         WHERE year_added IS NOT NULL
         ORDER BY year_added DESC
         LIMIT 10;

-- Q15. Find the year with the highest number of releases.

-- SELECT 
         COUNT(title) AS title_count,
         release_year
         FROM netflix_titles
         GROUP BY release_year
         ORDER BY title_count DESC
         LIMIT 1;
         

-- ======================================================
-- Subqueries
-- ======================================================

-- Q16. Titles longer than the average movie duration.

-- SELECT 
          title,
          duration_minutes
		  FROM netflix_titles
          WHERE type = 'Movie'
          AND duration_minutes >(
          SELECT AVG(duration_minutes)
          FROM netflix_titles
          WHERE type = 'Movie'
	);
    
    
-- Q17. Countries with an above-average number of titles.

-- SELECT 
         country,
         COUNT(title) AS count_title
         FROM netflix_titles
         WHERE country IS NOT NULL
         GROUP BY country
         HAVING count_title> (
         SELECT AVG(count_title)
         FROM (
         SELECT country,
				COUNT(title) AS count_title
                FROM netflix_titles
                GROUP BY country 
		 )AS country_count
	);


-- Q18. Years where more titles were added than the yearly average.

-- SELECT 
          year_added,
          COUNT(title) AS count_title
          FROM netflix_titles
          GROUP BY year_added
          HAVING count_title >(
          SELECT AVG(count_title)
          FROM (
          SELECT 
                year_added,
                COUNT(title) AS count_title
                FROM netflix_titles
                GROUP BY year_added
		 ) AS yearly_counts
		);
        
        
-- Q19. Directors who have more titles than the average director.

-- SELECT
          director,
          COUNT(title) AS count_title
          FROM netflix_titles
          WHERE director IS NOT NULL
          GROUP BY director
          HAVING count_title > (
          SELECT AVG(count_title)
          FROM (
          SELECT director,
                 COUNT(title) AS count_title
                 FROM netflix_titles
                 GROUP BY director
		 ) AS Director_count
	);



-- Q20. Find the titles whose release year is later than the average release year of all titles.

-- SELECT
         title,
         release_year
         FROM netflix_titles
         WHERE release_year > (
         SELECT AVG(release_year)
         FROM netflix_titles
	);
         