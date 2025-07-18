-- Which companies laid off the most employees and over
-- what period of time?
SELECT company, industry
    , SUM(total_laid_off) AS total_layoffs
    , (MIN(`date`)) AS earliest_layoffs
    , (MAX(`date`)) AS latest_layoffs
    , DATEDIFF(MAX(`date`), MIN(`date`)) + 1 AS 'layoff_span (days)'
FROM world_layoffs.layoffs_staging2
GROUP BY company, industry
ORDER BY 3 DESC;

-- Which industries had the most layoffs?
SELECT industry,
    SUM(total_laid_off) AS total_layoffs
FROM world_layoffs.layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

-- What were the rolling monthly layoffs?
WITH monthly_layoffs_cte AS (
    SELECT SUBSTRING(`date`, 1, 7) AS `month`
        , SUM(total_laid_off) AS monthly_layoffs
    FROM world_layoffs.layoffs_staging2
    WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
    GROUP BY `month`
),
rolling_monthly_layoffs_cte AS (
    SELECT `month`
        , monthly_layoffs
        , SUM(monthly_layoffs) OVER(ORDER BY `month`) AS rolling_layoffs
        , SUM(monthly_layoffs) OVER() AS total_layoffs
    FROM monthly_layoffs_cte
    ORDER BY `month` ASC
)
SELECT `month`
    , monthly_layoffs
    , rolling_layoffs
    , ROUND(monthly_layoffs * 100.0 / total_layoffs, 2) AS percent_layoffs
    , ROUND(rolling_layoffs * 100.0 / total_layoffs, 2) AS rolling_percent_layoffs
FROM rolling_monthly_layoffs_cte;

-- What rank was each company in terms of most layoffs per year?
WITH company_year_cte AS (
    SELECT company,
        SUM(total_laid_off) AS yearly_layoffs,
        YEAR(`date`) AS `year`
    FROM world_layoffs.layoffs_staging2
    GROUP BY company, `year`
),
company_rank_cte AS (
    SELECT company
        , `year`
        , yearly_layoffs
        , DENSE_RANK() OVER(PARTITION BY `year` ORDER BY yearly_layoffs DESC) AS `rank`
    FROM company_year_cte
    WHERE `year` IS NOT NULL
        AND yearly_layoffs IS NOT NULL
    ORDER BY `year` ASC
)
SELECT *
FROM company_rank_cte
WHERE `rank` <= 5;
