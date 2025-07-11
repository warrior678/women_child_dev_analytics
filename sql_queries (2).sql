
# 📊 Women & Child Development Analytics Dashboard

A Streamlit-powered analytics dashboard based on the PRS Legislative Research report: **Demand for Grants 2024–25 – Ministry of Women and Child Development**.

This project visualizes critical data on undernutrition, girl child education, fund utilization, and immunisation coverage through interactive charts and SQL-backed insights.

---

## 📁 Repository Structure

| File | Description |
|------|-------------|
| `app.py` | Streamlit app interface |
| `combined_output.csv` | Cleaned dataset used for visualization |
| `budget_data.xlsx` | Excel data (if preferred) |
| `sql_queries.sql` | SQL schema + queries (backup) |
| `README.md` | Project documentation |
| `requirements.txt` | Python libraries used |

---

## 🚀 Getting Started

```bash
git clone https://github.com/your-username/women-child-dev-analytics.git
cd women-child-dev-analytics
pip install -r requirements.txt
pip install openpyxl
streamlit run app.py
```

---

## 📊 Features

- 📂 Upload **CSV or Excel files**
- 🔍 Interactive preview of the dataset
- 📈 Bar charts and data summaries
- 🧠 SQL queries categorized by difficulty
- 🧮 Focus on women and child-centric policy indicators

---

## 🧠 SQL Schema & Queries

```sql
USE Women_child_development;

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

-- Easy Queries
SELECT * FROM undernutrition_data;
SELECT state_ut FROM immunisation_coverage;
SELECT COUNT(*) FROM nirbhaya_fund_utilisation;
SELECT AVG(underweight) FROM undernutrition_data;
SELECT * FROM immunisation_coverage WHERE state_ut = 'Kerala';
SELECT state_ut FROM gross_enrolment_ratio WHERE upper_primary > 95;
SELECT TOP 1 * FROM nirbhaya_fund_utilisation ORDER BY total_allocated_cr DESC;
SELECT * FROM gross_enrolment_ratio WHERE state_ut = 'Bihar';
SELECT state_ut FROM undernutrition_data WHERE underweight > 30;

-- Medium & Hard Queries (including window functions)
SELECT u.state_ut, u.underweight, i.percentage_point_increase
FROM undernutrition_data u
JOIN immunisation_coverage i ON u.state_ut = i.state_ut;

SELECT SUM(total_utilised_cr) AS total_utilised FROM nirbhaya_fund_utilisation;

SELECT state_ut, full_immunisation_nfhs5 - full_immunisation_nfhs4 AS increase
FROM immunisation_coverage;

SELECT state_ut FROM undernutrition_data WHERE wasted > stunted;

SELECT state_ut FROM gross_enrolment_ratio WHERE secondary < upper_primary;

SELECT COUNT(*) FROM immunisation_coverage WHERE full_immunisation_nfhs5 > 75;

SELECT ministry,
       (total_utilised_cr / total_allocated_cr) * 100 AS utilisation_percent
FROM nirbhaya_fund_utilisation;

SELECT MAX(underweight) AS max_underweight, MIN(underweight) AS min_underweight
FROM undernutrition_data;

SELECT state_ut, full_immunisation_nfhs5,
       RANK() OVER (ORDER BY full_immunisation_nfhs5 DESC) AS rank_nfhs5
FROM immunisation_coverage;

SELECT ministry,
       RANK() OVER (ORDER BY (total_utilised_cr / NULLIF(total_allocated_cr, 0)) DESC) AS utilisation_rank
FROM nirbhaya_fund_utilisation;

SELECT state_ut,
       SUM(percentage_point_increase) OVER (ORDER BY percentage_point_increase DESC) AS running_total
FROM immunisation_coverage;

SELECT state_ut, stunted,
       AVG(stunted) OVER () AS avg_stunted
FROM undernutrition_data;

SELECT state_ut,
       CASE
           WHEN percentage_point_increase >= 20 THEN 'High'
           WHEN percentage_point_increase >= 10 THEN 'Medium'
           ELSE 'Low'
       END AS immunisation_performance
FROM immunisation_coverage;

SELECT state_ut, upper_primary,
       DENSE_RANK() OVER (ORDER BY upper_primary DESC) AS rank_primary
FROM gross_enrolment_ratio;

SELECT ministry, total_utilised_cr,
       LAG(total_utilised_cr) OVER (ORDER BY total_utilised_cr DESC) AS previous,
       LEAD(total_utilised_cr) OVER (ORDER BY total_utilised_cr DESC) AS next
FROM nirbhaya_fund_utilisation;

SELECT state_ut, stunted,
       SUM(stunted) OVER (ORDER BY stunted DESC) AS cumulative_stunted
FROM undernutrition_data;
```

---

## 👨‍💻 Author

**Gautam Kumar**  
[LinkedIn](https://www.linkedin.com/in/gautam-kumar-2935bb178/)

---

## 📌 License

This project is for educational and professional portfolio purposes based on public data from PRSIndia.org.
