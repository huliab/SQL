-- Data Cleaning 
SELECT *
FROM layoffs;

-- 1. REMOVE DUPLICATES
-- 2. STANDARDIZE THE DATA 
-- 3.NULL VALUES OR BLANK VALUES 
-- 4. REMOVE ANY COLUMNS OR ROWS

CREATE TABLE layoffs_staging 
LIKE layoffs ;
SELECT *
FROM layoffs_staging ;
INSERT layoffs_staging 
SELECT *
FROM layoffs;

SELECT *,
ROW_NUMBER () OVER (PARTITION BY company,location,industry,total_laid_off,
percentage_laid_off, `date`,stage,country,funds_raised_millions) AS row_num
FROM layoffs_staging;


WITH duplicate_cte  AS
(
SELECT *,
ROW_NUMBER () OVER (PARTITION BY company,location,industry,total_laid_off,
percentage_laid_off, `date`,stage,country,funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE  row_num > 1;

SELECT *
FROM layoffs_staging
WHERE company = 'Casper';
WITH duplicate_cte  AS
(
SELECT *,
ROW_NUMBER () OVER (PARTITION BY company,location,industry,total_laid_off,
percentage_laid_off, `date`,stage,country,funds_raised_millions) AS row_num
FROM layoffs_staging
)
DELETE
FROM duplicate_cte
WHERE  row_num > 1;


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
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs_staging2
WHERE row_num >1;

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER () OVER (PARTITION BY company,location,industry,total_laid_off,
percentage_laid_off, `date`,stage,country,funds_raised_millions) AS row_num
FROM layoffs_staging;

delete
FROM layoffs_staging2
WHERE row_num >1;



SELECT *
FROM layoffs_staging2
WHERE row_num >1;


-- STANDARDIZING DATA 

SELECT company, TRIM(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);

SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT DISTINCT industry
FROM layoffs_staging2;

SELECT DISTINCT location 
FROM layoffs_staging2
ORDER BY 1;

SELECT DISTINCT country 
FROM layoffs_staging2
WHERE country LIKE 'United States%'
ORDER BY 1;


SELECT DISTINCT country , TRIM(TRAILING '.' FROM country)
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';


SELECT *
FROM layoffs_staging2;

SELECT `date`,
STR_TO_DATE (`date` , '%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE (`date` , '%m/%d/%Y');

ALTER TABLE layoffs_staging2 ADD COLUMN new_date DATE ;
UPDATE layoffs_staging2 
SET new_date = str_to_date(`date` , '%m/%d/%Y');

ALTER TABLE layoffs_staging2 DROP COLUMN `date`;
ALTER TABLE layoffs_staging2 CHANGE new_date `date` DATE ;

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL 
AND percentage_laid_off IS NULL ;

UPDATE layoffs_staging2
SET industry = null 
WHERE industry = '';


SELECT *
FROM layoffs_staging2
WHERE industry IS NULL;



select t1.industry, t2.industry
from layoffs_staging2 t1
JOIN layoffs_staging2 t2
  ON t1.company = t2.company 
WHERE (t1.industry IS NULL ) AND t2.industry is not null;

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
  ON t1.company = t2.company 
SET t1.industry = t2. industry
WHERE (t1.industry IS NULL ) 
AND t2.industry is not null;


SELECT *
FROM layoffs_staging2;

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL 
AND percentage_laid_off IS NULL ;

DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL 
AND percentage_laid_off IS NULL ;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;