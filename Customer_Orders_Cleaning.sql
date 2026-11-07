--FINAL TABLE AFTER CLEANING
WITH cleaned_data AS (
    SELECT
        order_id,
        --Clean Customer-Name Field
        dbo.InitCap(COALESCE(NULLIF(TRIM(customer_name), 'NULL'), 'unknown_customer')) AS customer_Name_Cleaned,
        email,
        --Standardize the order_status column
        dbo.InitCap(TRIM(order_status)) AS order_status_cleaned,
        --standardize the product-Name column
        CASE
            WHEN LOWER(product_name) LIKE '%apple watch%' THEN 'Apple Watch'
            WHEN LOWER(product_name) LIKE '%samsung galaxy s22%' THEN 'Samsung Galaxy S22'
            WHEN LOWER(product_name) LIKE '%macbook pro%' THEN 'MacBook Pro'
            WHEN LOWER(product_name) LIKE '%google pixel%' THEN 'Google Pixel'
            WHEN LOWER(product_name) LIKE '%iphone 14%' THEN 'iPhone 14'
            ELSE 'Others'
        END AS product_name_cleaned ,
        --Clean Quantity Field
        CASE
          WHEN CAST (quantity AS VARCHAR )= 'two' THEN 2
          WHEN quantity IS NULL THEN 0
          ELSE CAST(quantity AS INT)
       END AS clean_quantity ,
       --Standardize country_Name
       CASE
         WHEN LOWER(country) LIKE '%usa%' THEN 'USA'
         WHEN LOWER(country) LIKE '%uk%' THEN 'UK'
         WHEN LOWER(country) LIKE '%us%' THEN'US'
         ELSE dbo.InitCap(country)
      END AS country_cleasned
    FROM [customer_orders - Sheet1]
), 
duplicated_data AS (
--Remove Duplicates Rows
    SELECT 
        *,
        ROW_NUMBER() OVER(
            PARTITION BY LOWER(email), LOWER(product_name_cleaned), LOWER(customer_Name_Cleaned)
            ORDER BY order_id
        ) AS row_num
    FROM cleaned_data
)
SELECT *
FROM duplicated_data
WHERE row_num = 1;
