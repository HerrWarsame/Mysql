-- Exploratory Data Analysis " EDA Process"
-- Here we are simply examining the data to identify trends, patterns, or any interesting observations such as outliers

-- Typically, when beginning the EDA process, you have a general sense of what to look for

-- With this data, we will explore and see what insights we can uncover!

SELECT * 
FROM layoffs_staging2;

-- EASIER QUERIES
SELECT MAX(total_laid_off)
FROM layoffs_staging2;

-- Examining the percentages to assess the scale of these layoffs

SELECT MAX(percentage_laid_off),  MIN(percentage_laid_off)
FROM   layoffs_staging2
WHERE  percentage_laid_off IS NOT NULL;

-- Finding companies that had a layoff percentage of 1 (effectively 100% of the company)
SELECT *
FROM layoffs_staging2
WHERE  percentage_laid_off = 1;

-- Let's examine these companies in detail. Many appear to be startups that shut down during this period.
-- Ordering by funds_raised_millions will reveal the scale of investment lost.
SELECT *
FROM layoffs_staging2
WHERE  percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;


-- SOMEWHAT TOUGHER AND MOSTLY USING GROUP BY--------------------------------------------------------------------------------------------------

-- Companies with the biggest single Layoff

SELECT company, total_laid_off
FROM  layoffs_staging
ORDER BY 2 DESC
LIMIT 5;
-- Companies with the most Total Layoffs
SELECT company, SUM(total_laid_off)
FROM  layoffs_staging2
GROUP BY company
ORDER BY 2 DESC
LIMIT 10;

-- let we look when it started this layoff till when

SELECT MIN(`date`)  , MAX(`date`)
FROM layoffs_staging2;

-- let we check what about the columns 
-- we check which industry hat musst layoffs 
SELECT industry, SUM(total_laid_off)
FROM  layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC ;

-- by location
SELECT location, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY location
ORDER BY 2 DESC
LIMIT 10;


-- by country 
SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

-- let check by Year 

SELECT YEAR(date), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(date)
ORDER BY 1 DESC;

SELECT * 
FROM layoffs_staging2;

-- by stage ""

SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

-- let we look precentages

SELECT company, AVG(percentage_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;



-- Advanced Queries-----------------------------------

-- Previously, we identified companies with the highest total layoffs. Let's now analyze this trend on a yearly basis, which presents a more detailed challenge.
-- Our goal is to examine...

WITH Company_Year AS 
(
  SELECT company, YEAR(date) AS years, SUM(total_laid_off) AS total_laid_off
  FROM layoffs_staging2
  GROUP BY company, YEAR(date)
)
, Company_Year_Rank AS (
  SELECT company, years, total_laid_off, DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
  FROM Company_Year
)
SELECT company, years, total_laid_off, ranking
FROM Company_Year_Rank
WHERE ranking <= 3
AND years IS NOT NULL
ORDER BY years ASC, total_laid_off DESC;


-- Calculate the Rolling Total of Monthly Layoffs
SELECT 
    LEFT(date, 7) AS month_year,  -- Extracts Year-Month (YYYY-MM)
    SUM(total_laid_off) AS monthly_layoffs
FROM layoffs_staging2
WHERE LEFT(date, 7) IS NOT NULL -- Filter out null dates
	 AND total_laid_off IS NOT NULL -- Consider adding this if you have null values
GROUP BY month_year
ORDER BY month_year ASC;              -- ASC is optional (default behavior)


SELECT * 
FROM layoffs_staging2;




-- now use it in a CTE so we can query off of it

-- Step 1: Group layoffs by month
WITH MonthlyData AS 
(
    SELECT 
        LEFT(date, 7) AS month_year,  -- Gets YYYY-MM format
        SUM(total_laid_off) AS monthly_layoffs
    FROM layoffs_staging2
    WHERE date IS NOT NULL
        AND total_laid_off IS NOT NULL
    GROUP BY LEFT(date, 7)
)
-- Step 2: Calculate running total
SELECT 
    month_year,
    monthly_layoffs,
    -- Adds up all monthly_layoffs from the beginning to current month
    SUM(monthly_layoffs) OVER (ORDER BY month_year) AS running_total
FROM MonthlyData
ORDER BY month_year;


-- Having reviewed the aggregate layoff figures by company, the next step is to break that data down year by year. 
WITH yearly_layoffs AS (
    -- Step 1: Get total layoffs per company per year
    SELECT 
        company,
        YEAR(date) AS years,
        SUM(total_laid_off) AS total_laid_off
    FROM layoffs_staging2
    WHERE YEAR(date) IS NOT NULL
    GROUP BY company, YEAR(date)
),
ranked_layoffs AS (
    -- Step 2: Rank companies by layoffs each year
    SELECT 
        company,
        years,
        total_laid_off,
        DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
    FROM yearly_layoffs
)
-- Step 3: Get top 3 companies each year
SELECT 
    company,
    years,
    total_laid_off,
    ranking
FROM ranked_layoffs
WHERE ranking <= 3
ORDER BY years ASC, total_laid_off DESC;

-- let we rank by country 

-- Country ranking analysis
WITH yearly_country_layoffs AS (
    -- Get yearly layoffs by country
    SELECT 
        country,
        YEAR(date) AS years,
        SUM(total_laid_off) AS total_laid_off
    FROM layoffs_staging2
    WHERE YEAR(date) IS NOT NULL
      AND country IS NOT NULL
    GROUP BY country, YEAR(date)
),
ranked_countries AS (
    -- Rank countries yearly
    SELECT 
        country,
        years,
        total_laid_off,
        DENSE_RANK() OVER (
            PARTITION BY years 
            ORDER BY total_laid_off DESC
        ) AS country_rank
    FROM yearly_country_layoffs
)
SELECT 
    years,
    country,
    total_laid_off,
    country_rank,
    CASE 
        WHEN country_rank = 1 THEN ' Highest'
        WHEN country_rank <= 3 THEN ' Top 3'
        WHEN country_rank <= 5 THEN ' Top 5'
        ELSE 'Other'
    END AS rank_category
FROM ranked_countries
WHERE country_rank <= 10
ORDER BY years, country_rank;


-- Combined ranking: Companies within Countries
WITH yearly_data AS (
    SELECT 
        country,
        company,
        YEAR(date) AS years,
        SUM(total_laid_off) AS total_laid_off
    FROM layoffs_staging2
    WHERE YEAR(date) IS NOT NULL
      AND country IS NOT NULL
      AND company IS NOT NULL
    GROUP BY country, company, YEAR(date)
),
ranked_companies AS (
    SELECT 
        country,
        company,
        years,
        total_laid_off,
        -- Rank companies within each country and year
        DENSE_RANK() OVER (
            PARTITION BY country, years 
            ORDER BY total_laid_off DESC
        ) AS company_rank_in_country,
        -- Rank countries each year
        DENSE_RANK() OVER (
            PARTITION BY years 
            ORDER BY total_laid_off DESC
        ) AS country_rank_global
    FROM yearly_data
)
SELECT 
    years,
    country,
    company,
    total_laid_off,
    company_rank_in_country,
    country_rank_global
FROM ranked_companies
WHERE company_rank_in_country <= 3  -- Top 3 companies in each country
ORDER BY years ASC, 
         country_rank_global ASC, 
         country ASC,
         company_rank_in_country ASC;