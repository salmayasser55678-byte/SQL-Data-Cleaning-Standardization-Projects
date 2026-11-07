# SQL-Data-Cleaning-Standardization-Projects🧹📊
Welcome to my SQL Data Cleaning Portfolio! This repository demonstrates my ability to take messy, raw datasets and transform them into structured, reliable, and analysis-ready formats using Microsoft SQL Server (T-SQL).

🎯 Repository Overview

Real-world data is rarely perfect. It often contains duplicates, inconsistent formatting, invalid data types, and logical errors. In this repository, I tackle these common data quality issues using advanced SQL techniques to ensure data integrity before reporting or building data models (e.g., in Power BI or Tableau).

📂 Projects Included

1. Logistics & Shipments Data Cleaning (dirty_shipments)

Objective: Clean a logistics dataset to ensure accurate tracking of shipping weights, transit times, and delivery statuses.
Key Transformations:

Deduplication: Removed exact duplicate rows using Window Functions (ROW_NUMBER()) combined with Common Table Expressions (CTEs).

Text Standardization: Standardized casing for origin warehouses, destination cities, and carriers using UPPER(), TRIM(), and a custom INITCAP function.

Handling Anomalies: Converted negative weight values to positive using ABS() and handled zeros.

Date Logic Validation: Validated shipping logic by comparing ship_date and delivery_date, flagging invalid records (e.g., delivery before shipping) and calculating Transit_days.

NULL Handling: Replaced text-based 'NULL' strings with actual database NULLs and used COALESCE to handle missing values.

2. E-commerce Customer Orders (customer_orders)

Objective: Standardize an e-commerce sales dataset to prepare it for revenue analysis and customer segmentation.
Key Transformations:

Product Categorization: Used CASE WHEN and LIKE operators to group messy, inconsistent product entries (e.g., 'samsung galaxy S22') into clean, standard categories.

Data Type Casting: Cleaned a mixed-type quantity column (converting text like 'two' to numeric 2) and safely cast the column to integers.

Advanced NULL Handling: Mastered the combination of COALESCE, NULLIF, and TRIM to clean customer names that were incorrectly logged as string 'NULL's.

Geographic Standardization: Standardized country names using LOWER() and pattern matching to group various formats (e.g., 'Usa', 'uk', 'us') into standard abbreviations (USA, UK).

Complex Deduplication: Implemented partitioned row numbering across multiple logic columns (Email, Product, Customer Name) to safely identify and remove duplicate orders without losing valid recurring transactions.

🛠️ SQL Skills & Functions Demonstrated

Window Functions: ROW_NUMBER(), PARTITION BY, ORDER BY

Control Flow: CASE WHEN ... THEN ... ELSE

Handling NULLs: COALESCE(), NULLIF()

String Manipulation: TRIM(), LOWER(), UPPER(), LIKE, Substrings/InitCap logic

Date Functions: DATEDIFF()

Math Functions: ABS(), ROUND()

Structure: Common Table Expressions (CTEs) for readable, modular code.

🚀 How to Use

Each .sql file in this repository represents the complete cleaning script for a specific dataset. The scripts are organized logically, culminating in a FINAL TABLE AFTER CLEANING query that executes all transformations efficiently in a single pass.

Review the .csv files to see the raw state of the data.

Open the corresponding .sql script to review the cleaning logic.

Created by Salma - Always eager to turn messy data into actionable insights!
