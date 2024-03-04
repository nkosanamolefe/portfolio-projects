Select *
FROM PortfolioProject..cars;

--Data Overview

--How many unique values are there in each column?
SELECT 
    COUNT(DISTINCT make) AS unique_make_values,
    COUNT(DISTINCT model) AS unique_model_values,
    COUNT(DISTINCT fuel) AS unique_fuel_values,
    COUNT(DISTINCT gear) AS unique_gear_values,
    COUNT(DISTINCT offerType) AS unique_offer_type_values,
    COUNT(DISTINCT year) AS unique_year_values
FROM 
    PortfolioProject..cars;

--What is the data type of each column?
SELECT 
    COLUMN_NAME,
    DATA_TYPE
FROM 
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_NAME = 'cars';

--Are there any missing values in the dataset?
SELECT 
    SUM(CASE WHEN mileage IS NULL THEN 1 ELSE 0 END) AS missing_mileage_count,
    SUM(CASE WHEN make IS NULL THEN 1 ELSE 0 END) AS missing_make_count,
    SUM(CASE WHEN model IS NULL THEN 1 ELSE 0 END) AS missing_model_count,
    SUM(CASE WHEN fuel IS NULL THEN 1 ELSE 0 END) AS missing_fuel_count,
    SUM(CASE WHEN gear IS NULL THEN 1 ELSE 0 END) AS missing_gear_count,
    SUM(CASE WHEN offerType IS NULL THEN 1 ELSE 0 END) AS missing_offer_type_count,
    SUM(CASE WHEN [price($)] IS NULL THEN 1 ELSE 0 END) AS missing_price_count,
    SUM(CASE WHEN hp IS NULL THEN 1 ELSE 0 END) AS missing_horsepower_count,
    SUM(CASE WHEN year IS NULL THEN 1 ELSE 0 END) AS missing_year_count
FROM 
    PortfolioProject..cars;


--Data Cleaning

--Replacing missing values with the mean of horsepower
UPDATE PortfolioProject..cars
SET hp = (
    SELECT AVG(hp) 
    FROM PortfolioProject..cars 
    WHERE hp IS NOT NULL
)
WHERE hp IS NULL;

--Replacing missing gear values with the mode (most common gear type)the most gear type
UPDATE PortfolioProject..cars
SET gear = (
    SELECT TOP 1 WITH TIES gear
    FROM PortfolioProject..cars
    WHERE gear IS NOT NULL
    GROUP BY gear
    ORDER BY COUNT(*) DESC
)
WHERE gear IS NULL;

--Delete the missing data
DELETE FROM PortfolioProject..cars
WHERE model IS NULL;

--Data Exploration 

--1. What are the most common car makes and models in the dataset?
--For the most common car makes:
SELECT TOP 15 make, COUNT(*) AS make_count
FROM PortfolioProject..cars
GROUP BY make
ORDER BY make_count	DESC

--For the most common car models:
SELECT TOP 15 model, COUNT(*) AS model_count
FROM PortfolioProject..cars
GROUP BY model
ORDER BY model_count DESC;

--2. What is the average mileage of the cars in the dataset?
SELECT AVG(mileage) as average_mileage
from PortfolioProject..cars;

--3. What is the distribution of fuel types?
SELECT fuel, COUNT(*) AS fuel_count
FROM PortfolioProject..cars
GROUP BY fuel
ORDER BY fuel_count DESC;

--4. What is the distribution of fuel gear types?
SELECT gear, COUNT(*) AS gear_count
FROM PortfolioProject..cars
GROUP BY gear
ORDER BY gear_count DESC;

--5. How does the distribution of prices look like?
SELECT
    AVG([price($)]) AS mean_price,
    MIN([price($)]) AS min_price,
    MAX([price($)]) AS max_price
FROM PortfolioProject..cars;

--6. How does price vary with mileage?


--7. Is there any correlation between horsepower and price?


--8. Are there any patterns or trends in the data when grouped by year?
