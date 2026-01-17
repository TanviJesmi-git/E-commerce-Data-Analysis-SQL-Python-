# 🛒 E-Commerce Data Analysis Project (SQL + Python)

## 📌 Problem Statement

This is a **student-led exploratory data analysis project** using a real-world e-commerce dataset.

Since no business questions were provided by stakeholders, the objective was to:

* Understand **overall business performance**
* Analyze **product and category behavior**
* Study **customer purchasing patterns**
* Identify **churn and retention risks**
* Practice **industry-relevant SQL analytics**

To achieve this, a **structured set of case-study based questions** was designed to simulate real business analytics scenarios.

---

## 📂 Dataset Used

* **Dataset:** Brazilian E-Commerce Dataset (Olist)
* **Source:** Kaggle
* **Type:** Historical transactional data

### Tables Used

* `customers`
* `orders`
* `order_items`
* `products`
* `order_payments`
* `order_reviews`

---

## 🧹 Data Preprocessing (Python)

Before loading data into MySQL, basic preprocessing was done using **Python**:

* Removed duplicates
* Checked missing values
* Converted date columns to proper datetime format
* Verified table relationships
* Exported cleaned data for SQL usage

This ensured accurate and consistent SQL analysis.

---

## 🗂️ Project Folder Structure

```
ecommerce-sql-analysis/
│
├── data/
│   ├── raw/                  # Original Kaggle CSV files
│   └── processed/            # Cleaned datasets after Python preprocessing
│
├── python_preprocessing/
│   └── data_cleaning.ipynb   # Python notebook for data cleaning
│
├── sql_queries/
│   ├── 01_business_performance/
│   │   └── business_performance.sql
│   │
│   ├── 02_product_analysis/
│   │   └── product_analysis.sql
│   │
│   ├── 03_customer_analysis/
│   │   └── customer_analysis.sql
│   │
│   └── 04_churn_analysis/
│       └── churn_analysis.sql
│
└── README.md
```

---

## 🧠 Why These Analytical Questions?

Since this is a student project, the questions were designed to cover **core business analytics needs**, such as:

* Revenue growth tracking
* Product performance comparison
* Customer lifetime value analysis
* Churn and retention risk identification

These questions reflect what **business, marketing, and product teams** typically ask in real companies.

---

## 🧮 SQL Analysis Approach

* Used **JOINs** to connect multiple tables
* Applied **GROUP BY, HAVING, CASE** for aggregations
* Used **window functions** (`RANK`, `LAG`) for advanced analysis
* Calculated revenue, growth rates, averages, and percentages
* Converted query outputs into clear business insights

---

## 📊 Key Insights

### 1️⃣ Business Performance

* **Total Revenue:** ₹3,117,382.43
* **Revenue Trend:** Strong growth across 2017 with seasonal dips
* **Monthly Orders:** Consistent increase over time
* **Average Order Value (AOV):** ₹159
* **Cancelled/Unavailable Orders:** Only **0.61%**

---

### 2️⃣ Product Analysis

* Revenue is **concentrated in a few categories**
* Top categories:
  `beleza_saude`, `relogios_presentes`, `cama_mesa_banho`
* Some products show **high order volume but low revenue**
* **Top 5 categories contribute 38.34%** of total revenue
* Electronics and appliances have **highest average prices**

---

### 3️⃣ Customer Analysis

* **Unique Customers:** 99,441
* **Avg Orders per Customer:** 1.00
  → Majority are one-time buyers
* **Top 10 customers** contribute significantly to revenue
* **Top 10% customers generate 37.99%** of total revenue
* **Average Customer LTV:** ₹160.60

---

### 4️⃣ Churn & Retention Analysis

* **Inactive Customers (90+ days):** 86,524
* **Repeat Customers at Churn Risk:** 2,651
* **Avg Time Between Purchases:** ~78 days
* **Highest Churn Risk States:**
  SP, RJ, MG, RS, PR

---

## 🎯 Conclusion

This project demonstrates how **Python + SQL** can be used together to:

* Clean and prepare raw data
* Design meaningful analytical questions
* Perform real-world SQL analysis
* Extract actionable business insights

It reflects a **practical analytics workflow**, making it suitable for **internship applications and interviews**.

---

## 🛠️ Tools & Technologies

* **Python** (Data preprocessing)
* **MySQL** (Data analysis)
* **Google Colab**
* **GitHub**

---
