# Hospital Wait Time Analysis (SQL & Tableau)

## 📌 Project Overview

This project analyzes hospital patient wait times to identify departments, days, and time periods with prolonged delays. The primary focus is **data cleaning, transformation, and exploratory analysis using SQL**, followed by **visual storytelling in Tableau**.

The goal is to demonstrate strong SQL data‑wrangling skills and the ability to translate cleaned data into actionable operational insights.

---

## 🛠 Tools & Technologies

* **MySQL** – Data cleaning, transformation, and exploratory data analysis (EDA)
* **Tableau Public** – Interactive dashboard and visual analytics
* **GitHub** – Version control and project documentation

---

## 🧹 Data Cleaning Workflow (SQL)

The raw dataset contained duplicates, inconsistent formats, invalid values, and missing fields. A structured, step‑by‑step SQL pipeline was applied:

### 1️⃣ Data Copy

* Created a working table to preserve the raw dataset

### 2️⃣ Duplicate Removal

* Identified duplicate patient visits using `ROW_NUMBER()` window functions
* Removed redundant records while preserving first occurrences

### 3️⃣ Standardization

* Trimmed and normalized text fields
* Standardized gender, department, appointment type, and visit status values
* Converted mixed date formats into proper `DATE` fields
* Converted time‑related columns into `DATETIME`
* Replaced invalid ages and wait times with `NULL`

### 4️⃣ Handling NULLs & Blanks

* Identified missing values column‑by‑column
* Converted blank strings to `NULL`
* Replaced missing categorical values where appropriate

### 5️⃣ Exploratory Data Analysis (EDA)

* Patient distribution by department
* Average, minimum, and maximum wait times
* Wait‑time trends by month and visit day
* Patient volume by hour
* Gender and age‑group analysis

---

## 📊 Dashboard Highlights (Tableau)

The cleaned dataset was visualized in Tableau to support operational decision‑making:

* **KPIs**: Total patients, maximum and minimum wait times
* **Department analysis**: Total and average wait times by department
* **Time trends**: Monthly and daily wait‑time patterns
* **Interactive filters**: Gender and visit‑day slicing

📎 *A dashboard screenshot is included in this repository.*

---

## 📁 Repository Structure

```
Hospital-Wait-Time-Analysis/
│
├── README.md
├── sql/
│   ├── 01_data_copy.sql
│   ├── 02_remove_duplicates.sql
│   ├── 03_standardization.sql
│   ├── 04_null_handling.sql
│   └── 05_eda.sql
│
├── tableau/
│   └── dashboard_screenshot.png
```

---

## 🚀 Key Skills Demonstrated

* Advanced SQL data cleaning and validation
* Window functions for deduplication
* Date and time normalization
* Structured exploratory data analysis
* Dashboard‑driven storytelling

---

## 🔗 Links

* **Tableau Dashboard**: *https://public.tableau.com/app/profile/clement.nyamekye/viz/HospitalWaitTimesAnalysis/Dashboard1*

---

