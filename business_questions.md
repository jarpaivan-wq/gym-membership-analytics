# 📊 Business Questions Documentation

## Overview
This document provides detailed explanations of each business query developed for FitZone Gym Management, including the business context, SQL logic, and actionable insights.

---

## Query #1: Top 10 Most Engaged Members

### Business Context
FitZone wants to recognize and reward their most dedicated members. These top performers will be featured in the monthly newsletter and may receive special loyalty perks or referral incentives.

### Business Question
**"Who are our most engaged members based on total gym and class attendance?"**

### SQL Approach
```sql
SELECT
    m.nombre AS nombre_completo,
    m.email,
    COUNT(a.asistencia_id) AS total_asistencias
FROM miembros m
INNER JOIN asistencias a
    ON m.miembro_id = a.miembro_id
GROUP BY nombre_completo, m.email
ORDER BY total_asistencias DESC
LIMIT 10;
```

### Key SQL Concepts
- **INNER JOIN**: Connects members with their attendance records
- **COUNT()**: Aggregates total visits (both gym and classes)
- **GROUP BY**: Groups results by individual member
- **ORDER BY DESC**: Ranks members from highest to lowest attendance
- **LIMIT 10**: Returns only the top 10 members

### Business Insights
- Identifies most committed members for recognition programs
- Helps target members for testimonials and referral programs
- Provides benchmark for what "high engagement" looks like
- Can inform member retention strategies

### Actionable Outcomes
- Feature top members in monthly newsletter
- Offer exclusive loyalty rewards or discounts
- Request testimonials from highly engaged members
- Create ambassador program for top performers

---

## Query #2: Most Popular Classes

### Business Context
Understanding which classes generate the most attendance helps FitZone optimize their schedule, allocate resources efficiently, and make instructor promotion decisions.

### Business Question
**"Which group fitness classes have the highest attendance?"**

### SQL Approach
```sql
SELECT
    c.nombre_clase,
    c.instructor,
    COUNT(a.asistencia_id) AS total_asistencias
FROM clases c
INNER JOIN asistencias a
    ON c.clase_id = a.clase_id
WHERE a.tipo = 'clase'
GROUP BY c.nombre_clase, c.instructor
ORDER BY total_asistencias DESC;
```

### Key SQL Concepts
- **WHERE clause**: Filters to only count class attendance (excludes general gym visits)
- **INNER JOIN**: Links classes with attendance records
- **COUNT()**: Totals attendance per class
- **GROUP BY**: Aggregates by class and instructor combination

### Business Insights
- Identifies which class formats are most popular
- Shows which instructors drive highest attendance
- Helps justify staffing and resource allocation
- Reveals potential capacity issues for popular classes

### Actionable Outcomes
- Add more time slots for high-demand classes
- Consider increasing class capacity or room size
- Promote successful instructors for raise/recognition
- Phase out or redesign low-attendance classes
- Use popular class formats as model for new offerings

---

## Query #3: Membership Renewal Rate by Plan Type

### Business Context
Retention is critical for gym profitability. Understanding which membership types have higher renewal rates helps FitZone identify which plans provide better value and which may need improvement.

### Business Question
**"What percentage of members renew their memberships for each plan type?"**

### SQL Approach
```sql
WITH compra_plan AS (
    SELECT
        miembro_id,
        membresia_id,
        COUNT(*) AS veces_comprado
    FROM suscripciones
    GROUP BY miembro_id, membresia_id
)
SELECT
    m.nombre_plan AS nombre_del_plan,
    SUM(cp.veces_comprado) AS total_suscripciones,
    SUM(CASE
            WHEN cp.veces_comprado > 1 THEN cp.veces_comprado - 1
            ELSE 0
        END) AS renovaciones,
    ROUND(SUM(CASE
                WHEN cp.veces_comprado > 1 THEN cp.veces_comprado - 1
                ELSE 0
            END) / SUM(cp.veces_comprado) * 100, 2) AS tasa_renovacion
FROM membresias m
INNER JOIN compra_plan cp
    ON m.membresia_id = cp.membresia_id
GROUP BY nombre_del_plan;
```

### Key SQL Concepts
- **CTE (Common Table Expression)**: Creates temporary result set counting purchases per member/plan
- **CASE statement**: Conditional logic to identify renewals (purchases > 1)
- **Nested aggregations**: SUM() with CASE for complex calculations
- **Percentage calculation**: (renewals / total) * 100

### Renewal Logic
- If a member purchases the same plan 3 times = 2 renewals (first purchase doesn't count as renewal)
- If a member purchases once = 0 renewals
- Formula: `veces_comprado - 1` when `veces_comprado > 1`

### Business Insights
- Reveals which membership types generate strongest loyalty
- Identifies plans that may need pricing or benefit adjustments
- Shows member commitment levels by plan duration
- Helps forecast future revenue based on retention patterns

### Actionable Outcomes
- Focus marketing on high-renewal plans
- Investigate why certain plans have low renewal rates
- Adjust pricing or benefits for underperforming plans
- Create incentives to encourage renewals for specific tiers
- Use renewal data to predict monthly recurring revenue

---

## Query #4: Monthly Revenue by Membership Type

### Business Context
FitZone needs to track revenue trends over time to understand their income streams, identify seasonal patterns, and make informed budgeting decisions.

### Business Question
**"How much revenue is each membership type generating monthly over the last 6 months?"**

### SQL Approach
```sql
SELECT
    DATE_FORMAT(p.fecha_pago, '%Y-%m') AS `Mes/año`,
    m.nombre_plan,
    SUM(p.monto) AS total_ingresado
FROM pagos p
INNER JOIN suscripciones s
    ON p.suscripcion_id = s.suscripcion_id
INNER JOIN membresias m
    ON s.membresia_id = m.membresia_id
WHERE YEAR(p.fecha_pago) = 2024
    AND MONTH(p.fecha_pago) >= 7
GROUP BY `Mes/año`, m.nombre_plan
ORDER BY `Mes/año` ASC;
```

### Key SQL Concepts
- **DATE_FORMAT()**: Converts dates to 'YYYY-MM' format for monthly grouping
- **Multiple JOINs**: Connects payments → subscriptions → membership plans
- **Date filtering**: YEAR() and MONTH() functions to filter specific time period
- **Backticks**: Used for column aliases with special characters
- **Chronological ordering**: ASC order shows progression over time

### Business Insights
- Tracks revenue contribution by each membership tier
- Reveals seasonal or monthly fluctuations in income
- Shows which plans drive the most revenue
- Helps identify cash flow patterns

### Actionable Outcomes
- Allocate marketing budget based on revenue contribution
- Plan for seasonal variations in cash flow
- Focus sales efforts on high-revenue membership types
- Identify months needing promotional campaigns
- Set realistic revenue targets for upcoming months

---

## Query #5: Inactive Members at Risk

### Business Context
Members who stop attending despite having active subscriptions are at high risk of cancellation. Proactive outreach can re-engage these members before they churn.

### Business Question
**"Which members have active subscriptions but haven't visited in over 30 days?"**

### SQL Approach
```sql
SELECT
    m.nombre AS nombre_completo,
    m.email,
    MAX(a.fecha_asistencia) AS fecha_ultima_asistencia,
    DATEDIFF(CURDATE(), MAX(a.fecha_asistencia)) AS dias_sin_asistir
FROM miembros m
INNER JOIN suscripciones s
    ON m.miembro_id = s.miembro_id
INNER JOIN asistencias a
    ON s.miembro_id = a.miembro_id
WHERE s.estado = 'activa'
GROUP BY m.nombre, m.email
HAVING DATEDIFF(CURDATE(), MAX(a.fecha_asistencia)) > 30
ORDER BY dias_sin_asistir DESC;
```

### Key SQL Concepts
- **MAX()**: Finds the most recent attendance date for each member
- **DATEDIFF()**: Calculates days between current date and last visit
- **CURDATE()**: Returns today's date
- **HAVING clause**: Filters aggregated results (members with >30 days absence)
- **WHERE vs HAVING**: WHERE filters before grouping, HAVING filters after

### Business Insights
- Identifies at-risk members before they cancel
- Prioritizes outreach by showing who's been absent longest
- Helps prevent revenue loss from cancellations
- Shows effectiveness of member engagement strategies

### Actionable Outcomes
- Contact members with personalized check-in calls
- Send targeted email campaigns with special offers
- Offer free personal training sessions to re-engage
- Investigate common reasons for declining attendance
- Create automated alerts for members approaching 30-day threshold
- Implement early intervention programs

---

## Summary of Business Impact

### Operational Efficiency
- **Resource Allocation**: Optimize class schedules and instructor assignments
- **Capacity Planning**: Expand popular classes, reduce underperforming ones
- **Revenue Forecasting**: Predict income based on renewal and payment patterns

### Member Retention
- **Proactive Outreach**: Identify at-risk members before they cancel
- **Loyalty Programs**: Reward most engaged members
- **Service Improvements**: Address pain points causing low renewals

### Strategic Planning
- **Marketing Focus**: Invest in high-performing membership types
- **Pricing Strategy**: Adjust plans based on renewal data
- **Growth Opportunities**: Expand successful class formats

---

## Technical Notes

### Performance Considerations
- All queries use appropriate indexes on foreign keys
- Date filtering uses indexed columns for efficiency
- GROUP BY operations are optimized with proper column selection

### Data Quality Requirements
- Regular validation of attendance records
- Consistent timestamp recording for accurate calculations
- Active subscription status must be maintained accurately

### Future Enhancements
- Add year-over-year comparison queries
- Implement cohort analysis for member retention
- Create predictive models for churn risk
- Build automated reporting dashboards
- Add demographic segmentation analysis

---

*Documentation prepared for FitZone Gym Management SQL Analytics Project*
