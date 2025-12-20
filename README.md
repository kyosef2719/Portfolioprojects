README.md

# COVID-19 Data Analysis Portfolio Project

## Project Overview
In this project, I used **SQL Server** to explore global COVID-19 data and **Tableau** to visualize the key insights. This project demonstrates my ability to clean data, perform complex SQL queries, and create interactive dashboards.

### 1. SQL Data Exploration
- **Files:** [View SQL Scripts](https://github.com/kyosef2719/Portfolioprojects)
- **Key Skills:** Joins, CTEs, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types.
- **Analysis:** Analyzed Total Cases vs Total Deaths, likelihood of dying if you contract covid in your country, and global infection rates.

### 2. Tableau Dashboard
I visualized the data to show the global impact of the pandemic.
- **View Dashboard:** [Click Here to View on Tableau Public](https://public.tableau.com/app/profile/kidus.wanegnaw/viz/CovidDashboardPortfolio_17661354898540/Dashboard1)

### Tools Used
- Microsoft SQL Server Management Studio (SSMS)
- Excel
- Tableau Public


---

## Project 2: Data Cleaning in SQL (Nashville Housing)

### Project Overview
In this project, I took raw housing data and transformed it in **SQL Server** to make it usable for analysis. I cleaned the data, populated missing values, and reorganized columns.

### Key Steps Taken
- **Standardized Date Formats:** Converted columns to Date format.
- **Populated Missing Data:** Used `SELF JOIN` to populate null Property Address data.
- **Breaking out Addresses:** Used `SUBSTRING` and `PARSENAME` to split long address strings into (Address, City, State).
- **Data Standardization:** Converted "Y" and "N" to "Yes" and "No" using `CASE` statements.
- **Removed Duplicates:** Used CTEs and Windows Functions (`ROW_NUMBER`) to identify and delete duplicate rows.

### 1. View The Code
- **SQL File:** [Click Here to View SQL Script](https://github.com/kyosef2719/Portfolioprojects/blob/main/Nashville_Housing_Data_Cleaning.sql)
