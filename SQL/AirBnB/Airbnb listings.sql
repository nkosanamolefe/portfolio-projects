USE airbnb;

SELECT * FROM airbnb..listings
SELECT * FROM airbnb..listings_top_30

-- cleaning price
SELECT TOP 30 id, listing_url, room_type, beds ,30 - availability_30 AS booked_out_30, price,
CAST(REPLACE(REPLACE(price, '$', ''), ',', '') AS FLOAT) AS price_clean,
CAST(REPLACE(REPLACE(price, '$', ''), ',', '') AS FLOAT) * (30 - availability_30) AS projected_revenue_30,
CAST(REPLACE(REPLACE(price, '$', ''), ',', '') AS FLOAT) * (60 - availability_60) AS projected_revenue_60,
CAST(REPLACE(REPLACE(price, '$', ''), ',', '') AS FLOAT) * (90 - availability_90) AS projected_revenue_90,
CAST(REPLACE(REPLACE(price, '$', ''), ',', '') AS FLOAT) * (365 - availability_365) AS projected_revenue_365
FROM airbnb..listings
ORDER BY projected_revenue_30 DESC;


-- Location Factors
-- Which neighborhoods or suburbs have the highest-earning Airbnb properties?
SELECT 
    neighbourhood_cleansed, COUNT (*) AS neigbourhood_total
FROM airbnb..listings_top_30
GROUP BY neighbourhood_cleansed
ORDER BY neigbourhood_total DESC;

--Is there a correlation between earnings and proximity to tourist attractions or beaches?


-- Property Characteristics
-- Is there a relationship between the number of bedrooms/bathrooms and revenue?

--Host Strategies
--Do top earners have higher occupancy rates? What makes their listings more appealing (photos, reviews, responsiveness)?