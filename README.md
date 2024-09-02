# Air Pollution Analysis

## Overview
This project focuses on analyzing global air pollution data, specifically PM2.5 levels, to identify and understand the air quality profiles of different countries. The analysis involves web scraping, data cleaning, exploratory data analysis (EDA), and clustering techniques to group countries based on their air quality.

## Research Question
Group countries based on their PM2.5 levels to identify clusters with similar air quality profiles. This approach helps in understanding regional air quality challenges and similarities, which can inform policy and environmental strategies.

## Project Structure
- **Web Scraping:** Extracting air pollution data from Wikipedia using BeautifulSoup.
- **Data Cleaning:** Handling missing data, converting data types, and preparing the dataset for analysis.
- **Exploratory Data Analysis (EDA):** Analyzing and visualizing the distribution of PM2.5 levels across different countries and over time.
- **Clustering:** Applying K-means clustering to group countries with similar air quality profiles.

## Key Skills Demonstrated
- **Web Scraping:** Efficiently extracted structured data from a Wikipedia table using Python libraries.
- **Data Cleaning:** Addressed data quality issues, such as handling missing values and correcting data types, to prepare for accurate analysis.
- **Exploratory Data Analysis (EDA):** Conducted comprehensive EDA to uncover trends and insights in the data, supported by visualizations.
- **Machine Learning (Clustering):** Implemented K-means clustering to identify patterns in air pollution levels, grouping countries into clusters based on PM2.5 concentrations.

## Project Workflow
1. **Data Collection:**
   - Web scraped the list of countries by air pollution data from Wikipedia.
   - Converted the HTML table into a Pandas DataFrame for analysis.

2. **Data Cleaning:**
   - Replaced missing values and non-numeric data with NaN.
   - Converted PM2.5 data from object types to numeric types for proper analysis.

3. **Exploratory Data Analysis (EDA):**
   - Visualized the top 20 most and least polluted countries by year.
   - Analyzed the relationship between population size and pollution levels.
   - Grouped countries by continent to compare average pollution levels.

4. **Clustering:**
   - Normalized the data and used the elbow method to determine the optimal number of clusters.
   - Applied K-means clustering to group countries and visualized the results.

5. **Visualization:**
   - Generated bar plots, scatter plots, and cluster distribution plots to present findings.
   - Analyzed trends and patterns within the clusters to draw meaningful conclusions.

## Results
The analysis revealed significant differences in air quality across regions, with Asia and Africa having the highest average PM2.5 levels. The clustering identified two main groups of countries: those with relatively low pollution levels and those with dangerously high levels. This clustering helps highlight regions that may need more stringent environmental regulations and interventions.

## Prerequisites
- **Python 3.x**
- **Required Libraries:** 
  - `requests`
  - `BeautifulSoup4`
  - `pandas`
  - `numpy`
  - `matplotlib`
  - `seaborn`
  - `scikit-learn`
