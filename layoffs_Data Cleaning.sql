-- Data Cleaning
# 1. Create new database by "create new schema in the connected server"
# 2. Import data. Had issues with all rows of .csv importing I suspect due to non-ASCII characters. Converted to .JSON and was able to complete import
# 3. Create staging table to work with

SELECT *
FROM worldwide_layoffs.layoffs;

-- Create staging table
DROP TABLE IF EXISTS worldwide_layoffs.layoffs_staging;
CREATE TABLE worldwide_layoffs.layoffs_staging
LIKE worldwide_layoffs.layoffs;

INSERT worldwide_layoffs.layoffs_staging
SELECT *
FROM worldwide_layoffs.layoffs;

SELECT *
FROM worldwide_layoffs.layoffs_staging;


-- 1. Remove Duplicates

-- Using CTE to view duplicates
WITH CTE_Duplicates AS
(
SELECT *,
ROW_NUMBER () OVER (
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM worldwide_layoffs.layoffs_staging
)
SELECT *
FROM CTE_Duplicates
WHERE row_num > 1;

-- CTEs are not updatable so duplicates cannot be deleted, create a copy of layoffs_staging to modify
-- right click on table > copy to clipboard > create statement
DROP TABLE IF EXISTS worldwide_layoffs.layoffs_staging2;
CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` text,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` text,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM worldwide_layoffs.layoffs_staging2;

INSERT worldwide_layoffs.layoffs_staging2
SELECT *,
ROW_NUMBER () OVER (
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM worldwide_layoffs.layoffs_staging;

DELETE
FROM worldwide_layoffs.layoffs_staging2
WHERE row_num > 1;

SELECT *
FROM worldwide_layoffs.layoffs_staging2
WHERE row_num > 1;


-- 2. Standardize the Data

-- trim all data
SELECT DISTINCT company, (TRIM(company))
FROM layoffs_staging2;
UPDATE layoffs_staging2
SET company = TRIM(company);

SELECT DISTINCT location
FROM layoffs_staging2
ORDER BY 1;
UPDATE layoffs_staging2
SET location = TRIM(location);

SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1;
UPDATE layoffs_staging2
SET industry = TRIM(industry);
UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';
UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = 'NULL'
OR industry ='';

SELECT DISTINCT stage
FROM layoffs_staging2
ORDER BY 1;
UPDATE layoffs_staging2
SET stage = TRIM(stage);
UPDATE layoffs_staging2
SET stage = NULL
WHERE stage = 'NULL';

SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1;
UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' from country);

-- convert 'NULL' to true NULL. Convert text to proper format
SELECT DISTINCT total_laid_off
FROM layoffs_staging2
WHERE total_laid_off = 'NULL'
OR percentage_laid_off ='';
UPDATE layoffs_staging2
SET total_laid_off = TRIM(total_laid_off);
UPDATE layoffs_staging2
SET total_laid_off = NULL
WHERE total_laid_off = 'NULL';

SELECT DISTINCT percentage_laid_off
FROM layoffs_staging2
WHERE percentage_laid_off = 'NULL'
OR percentage_laid_off ='';
UPDATE layoffs_staging2
SET percentage_laid_off = TRIM(percentage_laid_off);
UPDATE layoffs_staging2
SET percentage_laid_off = NULL
WHERE percentage_laid_off = 'NULL';

SELECT `date`
FROM layoffs_staging2
WHERE `date` = 'NULL'
OR `date` = '';
UPDATE layoffs_staging2
SET `date` = TRIM(`date`);
UPDATE layoffs_staging2
SET `date` = NULL
WHERE `date` = 'NULL';

-- convert `date` from text to date format
SELECT `date`,
STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_staging2;
UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');
ALTER TABLE datelayoffs_staging2
MODIFY COLUMN `date` DATE;

SELECT DISTINCT funds_raised_millions
FROM layoffs_staging2
WHERE funds_raised_millions = 'NULL';
UPDATE layoffs_staging2
SET funds_raised_millions = TRIM(funds_raised_millions);
UPDATE layoffs_staging2
SET funds_raised_millions = NULL
WHERE funds_raised_millions = 'NULL';


-- 3. Null Values or blank values
-- tuples/rows without total laid off and percentage laid off are not useful for EDA for layoffs, these can be deleted
SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;
DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT *
FROM layoffs_staging2
WHERE company = "Bally's Interactive";
SELECT *
FROM layoffs_staging2
WHERE industry IS NULL;

-- Self JOIN to identify industry associated w company
SELECT t1.company, t1.industry, t2.company, t2.industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
WHERE (t1.industry IS NULL)
AND t2.industry IS NOT NULL;

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE (t1.industry IS NULL)
AND t2.industry IS NOT NULL;

-- 4. Remove Any Columns. Do not remove any columns from raw data
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;