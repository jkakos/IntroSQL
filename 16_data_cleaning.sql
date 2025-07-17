-- Steps:    
-- 1. Remove duplicates
-- 2. Standardize the data
-- 3. Handle null or blank values
-- 4. Remove unnecessary rows/columns

-- Create a staging table to insert data into rather than modifying the raw data
CREATE TABLE world_layoffs.layoffs_staging
LIKE world_layoffs.layoffs;

INSERT world_layoffs.layoffs_staging
SELECT *
FROM world_layoffs.layoffs;

-- 1. Remove duplicates
-- ------------------------------------------------------------
WITH duplicates_cte AS (
	SELECT *
		, ROW_NUMBER() OVER(
			PARTITION BY company
            , location
            , industry
            , total_laid_off
            , percentage_laid_off
            , `date`
            , stage
            , country
            , funds_raised_millions
		) AS row_num
	FROM world_layoffs.layoffs_staging
)
SELECT *
FROM duplicates_cte
WHERE row_num != 1;

SELECT *
FROM world_layoffs.layoffs_staging
WHERE company = 'Casper';

-- Create a dummy layoffs_staging table to handle removing duplicates
CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Insert all the data into layoffs_staging2
INSERT INTO world_layoffs.layoffs_staging2
SELECT *
	, ROW_NUMBER() OVER(
		PARTITION BY company
		, location
		, industry
		, total_laid_off
		, percentage_laid_off
		, `date`
		, stage
		, country
		, funds_raised_millions
	) AS row_num
FROM world_layoffs.layoffs_staging;

-- Delete the rows that are duplicates
DELETE
FROM world_layoffs.layoffs_staging2
WHERE row_num != 1;

-- This is now empty
SELECT *
FROM world_layoffs.layoffs_staging2
WHERE row_num != 1;


-- 2. Standardizing data
-- ------------------------------------------------------------
-- Remove whitespace around company names
UPDATE world_layoffs.layoffs_staging2
SET company = TRIM(company);

-- Convert Crypto, CryptoCurrency, and Crypto Currency to Crypto
SELECT *
FROM world_layoffs.layoffs_staging2
WHERE industry LIKE 'Crypto%';

UPDATE world_layoffs.layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

-- Convert United States. to United States
SELECT *
FROM world_layoffs.layoffs_staging2
-- WHERE country LIKE 'United States%'  AND country != 'United States';
WHERE country LIKE '%.';

UPDATE world_layoffs.layoffs_staging2
SET country = 'United States'
WHERE country LIKE 'United States%';

-- Convert date to datetime dtype
UPDATE world_layoffs.layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE world_layoffs.layoffs_staging2
MODIFY COLUMN `date` DATE;


-- 3. Handle null or blank values
-- ------------------------------------------------------------
UPDATE world_layoffs.layoffs_staging2
SET industry = NULL
WHERE industry = '';

SELECT *
FROM world_layoffs.layoffs_staging2
WHERE industry IS NULL;

-- Look for companies where there are multiple entries and at least
-- one of them has a known industry
SELECT t1.company
	, t1.industry
    , t2.industry
FROM world_layoffs.layoffs_staging2 AS t1
JOIN world_layoffs.layoffs_staging2 AS t2
	ON t1.company = t2.company
		AND t1.location = t2.location
WHERE t1.industry IS NULL
	AND t2.industry IS NOT NULL;

-- Use the known industries to update the missing industries
UPDATE world_layoffs.layoffs_staging2 AS t1
JOIN world_layoffs.layoffs_staging2 AS t2
	ON t1.company = t2.company
		AND t1.location = t2.location
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
	AND t2.industry IS NOT NULL;

-- Bally's Interactive only has one entry so its industry
-- could not be populated
SELECT *
FROM world_layoffs.layoffs_staging2
WHERE company LIKE 'Bally%';


-- 4. Remove unnecessary rows/columns
-- ------------------------------------------------------------
SELECT COUNT(*)
FROM world_layoffs.layoffs_staging2
WHERE total_laid_off IS NULL
	AND percentage_laid_off IS NULL;
    
-- There are 361 rows that have no values for total_laid_off and
-- percentage_laid_off. Since we need these values for the next
-- part, we can delete these rows now.
DELETE
FROM world_layoffs.layoffs_staging2
WHERE total_laid_off IS NULL
	AND percentage_laid_off IS NULL;

-- Drop the row_num column that was used for finding duplicates
ALTER TABLE world_layoffs.layoffs_staging2
DROP COLUMN row_num;