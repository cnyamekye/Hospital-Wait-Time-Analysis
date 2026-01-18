Hospital Wait Time Analysis (SQL & Tableau)

📌 Project Overview
Hospital wait-time data is often messy, duplicated, and inconsistent, making it difficult to identify the true causes of long patient wait times.  
This project focuses on cleaning, wrangling, and analyzing raw hospital visit data using SQL, followed by building an interactive Tableau dashboard to uncover operational insights.

The emphasis of this project is data preparation and analysis, not just visualization.




🛠 Tools Used
- MySQL – data cleaning, wrangling, and exploratory data analysis (EDA)
- Tableau – interactive dashboard and data visualization

  

🧹 Data Cleaning & Preparation
Most of the work was performed in SQL to prepare the dataset for reliable analysis:

- Created a working copy of the raw dataset to preserve original data
- Removed duplicate patient visit records using `ROW_NUMBER()` window functions
- Standardized inconsistent categorical values:
  - Gender
  - Department names
  - Appointment type
  - Visit status
- Cleaned and converted mixed date formats into proper `DATE` fields
- Converted time-related fields into `DATETIME`
- Handled invalid values such as:
  - Negative or zero ages
  - Zero or negative wait times
- Identified, normalized, and handled missing or blank values across columns

  

 🔍 Exploratory Data Analysis (EDA)
After cleaning, exploratory analysis was conducted to understand hospital operations:

- Patient distribution by department
- Average, minimum, and maximum wait times
- Wait time comparison by visit day and department
- Monthly and hourly trends in patient arrivals
- Gender and age group distribution
- Appointment type and visit status analysis

These insights directly informed the dashboard design.




 📊 Dashboard & Insights
The cleaned data was visualized in Tableau using an interactive dashboard with cross-filtering enabled.

Key insights include:
- Certain departments contribute disproportionately to longer patient wait times
- Wait times are highest on specific days of the week
- Patient congestion increases during peak hours and mid-year months


