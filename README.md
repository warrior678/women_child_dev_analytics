
Women & Child Development Analytics Dashboard

A Streamlit-powered analytics dashboard based on the PRS Legislative Research report: **Demand for Grants 2024–25 – Ministry of Women and Child Development**.

This project visualizes critical data on undernutrition, girl child education, fund utilization, and immunisation coverage through interactive charts and SQL-backed insights.

---

##  Repository Structure

| File | Description |
|------|-------------|
| `app.py` | Streamlit app interface |
| `combined_output.csv` | Cleaned dataset used for visualization |
| `budget_data.xlsx` | Excel data (if preferred) |
| `sql_queries.sql` | 25 categorized SQL questions (Easy, Medium, Hard) |
| `README.md` | Project documentation |
| `requirements.txt` | Python libraries used |
| `screenshots/` | Folder for preview images of app |

---

##  Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/women-child-dev-analytics.git
cd women-child-dev-analytics
```

### 2. Install Requirements

```bash
pip install -r requirements.txt
```

Make sure to also install Excel support:

```bash
pip install openpyxl
```

### 3. Run the Streamlit App

```bash
streamlit run app.py
```
https://onedrive.live.com/personal/3ee64ada73406c9d/_layouts/15/doc2.aspx?resid=a8a1d69f-c773-46fa-8129-fdfe11052818&cid=3ee64ada73406c9d&ct=1752247781595&wdOrigin=OFFICECOM-HWA.START.EDGEWORTH&wdPreviousSessionSrc=HarmonyDesktop&wdPreviousSession=5f8faeae-4e84-6141-895d-514bd8b7c836
---http://localhost:8503/ Streamlit

##  Features

-  Upload **CSV or Excel files**
-  Interactive preview of the dataset
-  Bar charts and data summaries
-  SQL queries categorized by difficulty (great for practice)
-  Focus on women and child-centric policy indicators

---

##  SQL Question Categories

 
View basics like totals, filters, and direct lookups.


Group-by, joins, ranking, and calculations 
Window functions, cumulative sums, and conditional logic.

 
SELECT GETDATE()
USE Women_child_development
CREATE TABLE undernutrition_data (
    state_ut VARCHAR(100) PRIMARY KEY,
    stunted FLOAT,
    wasted FLOAT,
    underweight FLOAT
); 
INSERT INTO undernutrition_data VALUES
('Andhra Pradesh', 31.2, 17.0, 29.4),
('Arunachal Pradesh', 23.7, 11.0, 17.2),
('Assam', 35.3, 21.7, 32.8),
('Bihar', 42.9, 22.9, 41.0),
('Chhattisgarh', 35.0, 18.8, 32.1),
('Goa', 23.7, 21.9, 24.5),
('Gujarat', 39.0, 25.1, 39.7),
('Kerala', 23.4, 15.7, 22.4),
('Uttar Pradesh', 39.7, 19.7, 32.1),
('India', 35.5, 19.3, 32.1); 

CREATE TABLE gross_enrolment_ratio (
    state_ut VARCHAR(100) PRIMARY KEY,
    upper_primary FLOAT,
    secondary FLOAT
); 
INSERT INTO gross_enrolment_ratio VALUES
('Andhra Pradesh', 91.6, 88.3),
('Arunachal Pradesh', 99.6, 95.4),
('Assam', 97.4, 89.5),
('Bihar', 80.0, 72.2),
('Chhattisgarh', 99.4, 94.6),
('Goa', 98.1, 93.7),
('Gujarat', 97.6, 90.9),
('Kerala', 101.6, 100.0),
('Uttar Pradesh', 95.3, 82.3),
('India', 98.7, 91.4); 

CREATE TABLE nirbhaya_fund_utilisation (
    ministry VARCHAR(150) PRIMARY KEY,
    total_allocated_cr FLOAT,
    total_released_cr FLOAT,
    total_utilised_cr FLOAT
);
INSERT INTO nirbhaya_fund_utilisation VALUES
('Ministry of Women and Child Development', 2647.0, 2646.5, 2181.3),
('Ministry of Home Affairs', 3868.1, 3122.5, 1229.2),
('Ministry of Road Transport and Highways', 147.2, 125.2, 125.2),
('Ministry of Railways', 500.0, 500.0, 498.0),
('Ministry of Electronics and IT', 99.5, 99.5, 0.0); 
CREATE TABLE immunisation_coverage (
    state_ut VARCHAR(100) PRIMARY KEY,
    full_immunisation_nfhs4 FLOAT,
    full_immunisation_nfhs5 FLOAT,
    percentage_point_increase FLOAT
); 
INSERT INTO immunisation_coverage VALUES
('Andhra Pradesh', 65.3, 75.4, 10.1),
('Arunachal Pradesh', 47.1, 70.6, 23.5),
('Assam', 47.1, 66.9, 19.8),
('Bihar', 61.7, 62.2, 0.5),
('Chhattisgarh', 75.3, 83.0, 7.7),
('Goa', 89.4, 93.0, 3.6),
('Gujarat', 50.0, 76.6, 26.6),
('Kerala', 82.1, 93.4, 11.3),
('Uttar Pradesh', 51.1, 66.7, 15.6),
('India', 62.0, 76.4, 14.4); 

-- Write a sql query to view all records from undernutrition_data
SELECT * FROM undernutrition_data; 
--Write a sql query to view all states from immunisation_coverage
SELECT state_ut FROM immunisation_coverage; 
--Write a sql query to find the number of ministries that were tracked in the Nirbhaya Fund
SELECT COUNT(*) FROM nirbhaya_fund_utilisation; 
--Write a sql query to find underweight% in India 
SELECT AVG(underweight) FROM undernutrition_data 
-- Find a sql query to show increase in immunisation of Kerala 
SELECT * FROM immunisation_coverage WHERE state_ut = 'Kerala'
-- List states with upper primary enrolment > 95
SELECT state_ut FROM gross_enrolment_ratio WHERE upper_primary > 95; 
--Write a SQL query to find ministry with highest allocated Fund 
SELECT TOP 1* FROM nirbhaya_fund_utilisation ORDER BY total_allocated_cr DESC; 
--Write a SQL query to show enrolment ratios for Bihar 
SELECT * FROM gross_enrolment_ratio WHERE state_ut = 'Bihar' 
--Write SQL query list all states where underweight % > 30 
SELECT state_ut FROM undernutrition_data WHERE underweight > 30 
--Write a query to join undernutrition with immunisation
SELECT u.state_ut, u.underweight, i.percentage_point_increase
FROM undernutrition_data u
JOIN immunisation_coverage i ON u.state_ut = i.state_ut; 
-- Write a query to display total fund utilized by all ministeries 
SELECT SUM(total_utilised_cr) AS total_utilised FROM nirbhaya_fund_utilisation; 
--Write a SQL query to state difference between NFHS5 and NFHS4 immunisation 
SELECT state_ut, full_immunisation_nfhs5 - full_immunisation_nfhs4 AS increase
FROM immunisation_coverage; 
--List states with wasted rate > stunted rate
SELECT state_ut FROM undernutrition_data WHERE wasted > stunted; 
--Write sql query to showcase states with secondary GER less than upper primary 
SELECT state_ut FROM gross_enrolment_ratio WHERE secondary < upper_primary;
--Write a sql query to find number of states where full immunisation NFHS5 > 75% 
SELECT COUNT(*) FROM immunisation_coverage WHERE full_immunisation_nfhs5>75; 
--Write a query to display % utilisation allocation of funds by ministry 
SELECT ministry,
       (total_utilised_cr / total_allocated_cr) * 100 AS utilisation_percent
FROM nirbhaya_fund_utilisation; 
--Find max and min underweight % 
SELECT MAX(underweight) AS max_underweight, MIN(underweight) AS min_underweight
FROM undernutrition_data; 

--Rank states by NFHS5 immunisation
SELECT state_ut, full_immunisation_nfhs5,
       RANK() OVER (ORDER BY full_immunisation_nfhs5 DESC) AS rank_nfhs5
FROM immunisation_coverage; 
--Rank ministries by fund utilisation percentage
SELECT ministry,
       RANK() OVER (ORDER BY (total_utilised_cr / NULLIF(total_allocated_cr, 0)) DESC) AS utilisation_rank
FROM nirbhaya_fund_utilisation;

-- 2. Running total of immunisation increase across states
SELECT state_ut,
       SUM(percentage_point_increase) OVER (ORDER BY percentage_point_increase DESC) AS running_total
FROM immunisation_coverage;

-- 3. Calculate avg stunted % using a window function
SELECT state_ut, stunted,
       AVG(stunted) OVER () AS avg_stunted
FROM undernutrition_data;

-- 4. Use CASE to classify immunisation performance
SELECT state_ut,
       CASE
           WHEN percentage_point_increase >= 20 THEN 'High'
           WHEN percentage_point_increase >= 10 THEN 'Medium'
           ELSE 'Low'
       END AS immunisation_performance
FROM immunisation_coverage;

-- 5. Dense rank states by upper_primary GER
SELECT state_ut, upper_primary,
       DENSE_RANK() OVER (ORDER BY upper_primary DESC) AS rank_primary
FROM gross_enrolment_ratio;

-- 6. Lead and lag fund utilisation comparison
SELECT ministry, total_utilised_cr,
       LAG(total_utilised_cr) OVER (ORDER BY total_utilised_cr DESC) AS previous,
       LEAD(total_utilised_cr) OVER (ORDER BY total_utilised_cr DESC) AS next
FROM nirbhaya_fund_utilisation;

-- 7. Cumulative sum of stunted %
SELECT state_ut, stunted,
       SUM(stunted) OVER (ORDER BY stunted DESC) AS cumulative_stunted
FROM undernutrition_data; # Women & Child Development Analytics 🇮🇳 
This is the reflection of the work of my analytics, which I have done in this project.
 1. What is the trend in maternal mortality across Indian states?
     Using the data, we observed that states like Bihar and Jharkhand have significantly higher maternal mortality rates compared to Kerala and Goa. This suggests disparities in healthcare access and maternal support systems.
 2. How has child malnutrition changed between 2015–16 and 2019–21?
     From, All-India malnutrition rates dropped from 36% to 32%. Urban areas improved from 29% to 26%, and rural areas from 38% to 33%, indicating modest progress but persistent rural gaps.  
    


This project analyzes publicly available datasets from the Ministry of Women & Child Development (MoWCD), focusing on health, education, and budget indicators across Indian states. It aims to uncover trends, disparities, and underutilization of schemes to inform data-driven policy decisions. 


---

## 🔍 Objectives
- Explore malnutrition, maternal/child mortality, and education enrollment trends
- Assess budget allocation vs. scheme utilization
- Identify states with critical gaps in health and education outcomes

---

## 📂 Datasets Used
- Anaemia prevalence among women and children
- Malnutrition by state and year
- Maternal & infant mortality rates (global and national)
- Education gross enrollment ratios
- Budget allocation and scheme underutilization
- Anganwadi honorarium and state-wise enrollment

---

## 🛠️ Tools & Techniques
- Python (Pandas, Matplotlib, Seaborn)
- Data cleaning and transformation
- Exploratory Data Analysis (EDA)
- Correlation and trend analysis

---

## 📊 Key Insights
- States with high malnutrition often show low scheme utilization
- Budget allocation does not always correlate with improved outcomes
- Education enrollment disparities persist across regions

---

## 📁 Output Files
- `cleaned_combined_output.csv`: Unified dataset for analysis
- Visualizations (to be added)
- Summary report (in progress)

---

## 🚀 Next Steps
- Build an interactive dashboard (Power BI / Tableau)
- Integrate prompt-powered insights for policy simulation
- Document findings for public health stakeholders

---

## 🤝 Contributions
Open to collaboration on dashboarding, policy modeling, and regional deep-dives.

---

📌 *This project is part of a portfolio focused on real-world analytics with social impact. Built and maintained by Gautam.* 
Added README to the ai_studio_prompt folder to summarize project goals, datasets, insights, and next steps
Linked the AI Studio folder in the README for recruiter visibility 
What is the summary of this project 
Of course. Here is a summary of the data analytics project on Women and Child Development in India:

### **Project Summary**

This project is a **data-driven analysis of the state of women and children in India**, using publicly available government data to uncover critical trends, regional disparities, and policy failures.

The core objective was to move beyond high-level numbers and identify the specific reasons behind slow progress in key areas. This was achieved by cleaning and analyzing semi-structured data from reports like the Ministry of Women & Child Development's budget analysis and the National Family Health Survey. The analysis used **Python (Pandas, Matplotlib, Seaborn)** to process the data and create insightful visualizations.

**Key Findings:**

The analysis uncovered several critical and often interconnected issues:

1.  **Severe Malnutrition & Worsening Anaemia:** One-third of children in India are stunted, with "hotspots" in states like Bihar and Meghalaya where rates exceed 40%. More alarmingly, the anaemia crisis is getting worse, now affecting **67% of young children** and **57% of women**.

2.  **Girls' Education "Leaky Pipeline":** There is a dramatic drop-off in school enrollment for girls, which falls from nearly universal in elementary school to just **58% in higher secondary school**, severely limiting their future economic opportunities.

3.  **Critical Policy and Funding Gaps:** The project revealed that poor outcomes are strongly linked to administrative failures.
    *   **Under-Utilized Schemes:** Key welfare schemes like **Mission SHAKTI** (women's safety) are chronically under-spent by as much as 30%.
    *   **Infrastructural Deficits:** The effectiveness of the national nutrition program is undermined by the fact that over **35% of its Anganwadi centers lack basic facilities** like functional toilets and clean water.

In conclusion, the project successfully translates complex government data into a clear narrative, providing actionable insights. It demonstrates that the challenges in women and child development are often rooted not in a lack of allocated funds, but in **systemic inefficiencies, infrastructural gaps, and a failure to translate policy into on-the-ground impact.**
what is the statistical outcome of this project 
Of course. The statistical outcome of this project is a set of specific, quantifiable metrics that reveal the critical state of women and child development in India and pinpoint the underlying systemic failures.

Here are the key statistical outcomes, broken down by focus area:

### **1. Health and Nutrition Outcomes**

*   **Chronic Malnutrition is Stagnant:** **36% of children under five are stunted** (low height-for-age), and **32% are underweight**. This indicates that approximately one-third of India's children are not receiving adequate nutrition for healthy growth.
*   **Anaemia is a Worsening Epidemic:** The prevalence of anaemia has **increased** across the board between 2015-16 and 2019-21.
    *   Among children (6-59 months), it rose from 58% to **67%**.
    *   Among non-pregnant women (15-49 years), it rose from 53% to **57%**.
*   **Extreme Regional Disparity in Mortality:** While the national Maternal Mortality Ratio (MMR) is **97 deaths per 100,000 live births**, there is a massive statistical variance. States like Assam have an MMR of **195**, more than double the national average, while Kerala's is just **19**. This highlights severe inequality in healthcare access and quality.

### **2. Education Outcomes**

*   **A 42% "Dropout" Rate for Girls in Higher Secondary School:** The Gross Enrolment Ratio (GER) for girls shows a steep decline, quantifying the "leaky pipeline" of education:
    *   Elementary Level: **101%**
    *   Secondary Level: **79%**
    *   Higher Secondary Level: **58%**
    This reveals a critical failure to retain girls in the education system past the age of 15-16.

### **3. Economic Participation Outcomes**

*   **Women's Labour Force Participation is Less Than Half of Men's:** The Labour Force Participation Rate (LFPR) for females is just **37%**, compared to **79% for males**.
*   **The Urban Gender Gap is Even Wider:** In urban areas, the female LFPR drops to a mere **25%**, compared to 75% for men, statistically demonstrating that urbanization is not equally benefiting women in terms of economic opportunity.

### **4. Governance and Scheme Implementation Outcomes**

These statistics provide the "why" behind the poor health and education outcomes.

*   **Systemic Under-spending of Allocated Funds:** Key welfare schemes show a significant gap between budget and actual expenditure.
    *   **Mission SHAKTI** (women's empowerment and safety) was under-spent by an average of **30%** between 2021-23.
    *   **Mission VATSALYA** (child protection) was under-spent by **19%** in the same period.
*   **Failure of Core Infrastructure:** The foundation of the national nutrition program is statistically weak.
    *   **35% of Anganwadi Centres lack functional toilets**.
    *   **36% of Anganwadi Centres lack drinking water facilities**.
*   **Increasing Crime Rate:** The crime rate against women has statistically worsened, increasing from **42 per 100,000** female population in 2012 to **66 in 2022**.
*   Here is the statistical analysis that I have done in this project.
*   1.Maternal & Infant Mortality( Global Maternal infant mortality.csv)
*   Statistical Observations.
*   Highest maternal mortality: Bihar (63), Jharkhand (59), Chhattisgarh (61)
*   Lowest maternal mortality: Kerala (19), Goa (24)
*   Infant mortality also follows a similar pattern, with Bihar and Assam exceeding 40 per 1000 live births.
Outcome: States with poor maternal health infrastructure consistently show elevated infant mortality, suggesting a strong correlation between maternal care and child survival.
2. Malnutrition Trends( Malnutrition_by_year.csv)
Statistical Observations.
*  All-India underweight prevalence dropped from 36% (2015–16) to 32% (2019–21)
*  Urban: 29% → 26%; Rural: 38% → 33%
*  Change: Rural areas saw the largest improvement (-5%)
Outcome: While malnutrition is declining, rural India still lags behind urban regions, indicating the need for targeted nutritional interventions.
3. Anaemia Prevalence (Anaemia_women_children.csv)
Statistical Observations.
* Over 50% of women and children in several states are anaemic.
* Anaemia rates remain high despite national supplementation programs.
Outcome: Nutritional programs may be underperforming or poorly targeted. There's a need for better awareness and monitoring mechanisms.     

### **Overall Statistical Conclusion**

The primary statistical outcome of this project is the **quantification of a major disconnect between policy allocation and real-world impact**. The data proves that significant financial budgets are not translating into better outcomes due to quantifiable failures in scheme implementation, administrative bottlenecks (chronic under-spending), and a severe deficit in foundational infrastructure. 





## Author

**Gautam Kumar**  
 [LinkedIn](https://www.linkedin.com/in/gautam-kumar-2935bb178/) 
##  License

This project is for educational and professional portfolio purposes based on public data from PRSIndia.org. 




