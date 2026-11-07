--FINAL TABLE AFTER CLEANING
WITH ranked AS (
--REMOVE EXACT DUPLICATES ROWS
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY origin_warehouse, destination_city, carrier, ship_date, weight_kg , freight_cost  
            ORDER BY shipment_id
        ) AS Row_Num
    FROM dirty_shipments
)
SELECT 
    shipment_id,
    ship_date,
    --Standrize text casing.
    dbo.INITCAP(TRIM(origin_warehouse)) AS origin_warehouse,
    UPPER(TRIM(destination_state))AS destination_state,
    dbo.INITCAP(TRIM(carrier)) AS carrier,
    --FIX QUALITY COLUMN
    CASE 
        WHEN damage_reported = 1 THEN 'Yes'
        WHEN damage_reported = 0 THEN 'No'
        ELSE 'NULL'
    END AS damage_status,

    --Replace String "NULL" & Handle True NULLS.
   dbo.INITCAP(COALESCE(destination_city, 'UnKnown'))AS destination_city_cleaned,
   COALESCE(CAST(delivery_date AS VARCHAR(50)),'Not Yet Delivered') AS delivery_date,
    --FIX NEGATIVE & SUSPICIOUS NUMERIC VALUES
    CASE 
        WHEN weight_kg < 0 THEN ROUND(ABS(weight_kg),1)
        WHEN weight_kg = 0 THEN NULL
        ELSE  ROUND (weight_kg,1)
    END AS weight_kg_cleaned,
    --validate date logic (delivery after ship date)
    DATEDIFF(DAY, ship_date, delivery_date) AS Transit_days,
    
    CASE 
        WHEN delivery_date < ship_date THEN 'InValid'
        WHEN delivery_date = ship_date THEN 'SAME DAY DELIVERY'
        ELSE 'Valid'
    END AS Quality_Flag

FROM ranked
WHERE Row_Num = 1; 
