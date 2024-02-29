use airbnb;

select * from airbnb..listings

select top 30 id, listing_url, room_type, beds ,30 - availability_30 AS booked_out_30, price,
CAST(REPLACE(REPLACE(price, '$', ''), ',', '') as float) AS price_clean,
CAST(REPLACE(REPLACE(price, '$', ''), ',', '') as float) * (30 - availability_30) AS projected_revenue_30,
CAST(REPLACE(REPLACE(price, '$', ''), ',', '') as float) * (30 - availability_60) AS projected_revenue_60,
CAST(REPLACE(REPLACE(price, '$', ''), ',', '') as float) * (30 - availability_90) AS projected_revenue_90,
CAST(REPLACE(REPLACE(price, '$', ''), ',', '') as float) * (30 - availability_365) AS projected_revenue_365
FROM airbnb..listings
ORDER BY projected_revenue_30 DESC;

-- cleaning price

