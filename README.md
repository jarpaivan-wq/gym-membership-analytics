# 🏋️ Gym Membership Analytics - SQL Project

A comprehensive SQL analysis project for a fitness center, focusing on member engagement, class popularity, retention rates, revenue tracking, and member reactivation strategies.

## 📊 Business Context

FitZone Gym Management needed insights from their membership data to:
- Identify most engaged members for loyalty rewards
- Optimize class schedules based on popularity
- Understand membership retention patterns
- Track revenue streams by membership type
- Proactively re-engage inactive members

## 🎯 Key Business Questions Answered

1. **Member Engagement**: Who are our top 10 most active members?
2. **Class Performance**: Which group classes have the highest attendance?
3. **Retention Analysis**: What's our renewal rate by membership type?
4. **Revenue Tracking**: How are monthly revenues trending by membership plan?
5. **Risk Identification**: Which active members haven't visited in over 30 days?

## 🗄️ Database Schema

The database consists of 7 interconnected tables:

- **miembros** (15 members) - Member information
- **membresias** (4 plans) - Membership plan types
- **suscripciones** (30 records) - Subscription history
- **pagos** (29 records) - Payment transactions
- **clases** (7 classes) - Group class offerings
- **horarios_clases** (12 schedules) - Class schedule times
- **asistencias** (45 records) - Member check-ins (gym + classes)

## 📁 Project Structure

```
gym-sql-analysis/
│
├── README.md
├── sql/
│   ├── 01_schema.sql          # Database schema
│   ├── 02_data.sql             # Sample data
│   └── 03_queries.sql          # Business queries
│
├── docs/
│   └── business_questions.md   # Detailed query documentation
│
├── .gitignore
└── LICENSE
```

## 🚀 Getting Started

### Prerequisites
- MySQL 8.0 or higher
- Any SQL client (MySQL Workbench, DBeaver, etc.)

### Setup Instructions

1. **Create Database**
```sql
CREATE DATABASE gym_fitness;
USE gym_fitness;
```

2. **Execute Schema**
```bash
Run sql/01_schema.sql
```

3. **Load Sample Data**
```bash
Run sql/02_data.sql
```

4. **Run Queries**
```bash
Execute queries from sql/03_queries.sql
```

## 💡 Key Insights

- **Member Engagement**: Top members show 8-10 total visits combining gym and classes
- **Class Popularity**: Yoga and HIIT classes lead in attendance
- **Retention**: Monthly plans show strong renewal patterns
- **Revenue**: Consistent monthly income across membership tiers
- **Risk Alerts**: Several active members identified for re-engagement campaigns

## 🛠️ Technologies Used

- **MySQL** - Database management
- **SQL** - Query language
- **DBeaver** - Database client

## 📚 SQL Concepts Demonstrated

- Complex JOINs (INNER JOIN across multiple tables)
- Aggregate Functions (COUNT, SUM, MAX)
- Date Functions (DATE_FORMAT, DATEDIFF, CURDATE)
- Conditional Logic (CASE statements)
- Common Table Expressions (CTEs)
- GROUP BY with HAVING clauses
- Subqueries and derived tables

## 📈 Future Enhancements

- Add member demographic analysis
- Create revenue forecasting queries
- Implement churn prediction logic
- Build attendance trend analysis
- Add payment method preferences

## 📧 Contact

Created for portfolio demonstration - SQL analytics for fitness industry

---

⭐ If you found this project useful, please consider giving it a star!
