-- ============================================================
-- QUERY 12: Membership Revenue Analysis with Percentage
-- ============================================================
-- Database: gym_fitness
-- Author: Ivan Jarpa
-- Date: February 2026
-- Complexity Level: ⭐⭐⭐⭐ Advanced
-- ============================================================

-- BUSINESS QUESTION:
-- What is the revenue contribution of each membership plan?
-- Include active member count, total revenue, ranking, and 
-- percentage of total revenue.

-- KEY CONCEPTS:
-- ✓ Multiple CTEs (3 levels)
-- ✓ Window function SUM() OVER() for global totals
-- ✓ Percentage calculations
-- ✓ DENSE_RANK for ranking
-- ✓ LEFT JOINs with COALESCE for null handling

-- ============================================================
-- SOLUTION
-- ============================================================

USE gym_fitness;

WITH cte1_miembros_activos AS (
    -- CTE1: Count active members per plan
    SELECT
        membresia_id,
        COUNT(miembro_id) AS miembros_activos
    FROM suscripciones
    WHERE estado = 'activa'
    GROUP BY membresia_id
),
cte2_ingreso_total AS (
    -- CTE2: Calculate total revenue per plan
    SELECT
        mem.membresia_id,
        cte1.miembros_activos * mem.precio AS ingreso_total
    FROM membresias mem
    INNER JOIN cte1_miembros_activos cte1
        ON mem.membresia_id = cte1.membresia_id
)
-- Final query: Revenue analysis with ranking and percentages
SELECT
    mem.nombre_plan,
    COALESCE(cte1.miembros_activos, 0) AS miembros_activos,
    mem.precio AS precio_plan,
    COALESCE(cte2.ingreso_total, 0) AS ingreso_total,
    DENSE_RANK() OVER(
        ORDER BY COALESCE(cte2.ingreso_total, 0) DESC
    ) AS ranking_ingreso_total,
    (COALESCE(cte2.ingreso_total, 0) / 
     NULLIF(SUM(cte2.ingreso_total) OVER(), 0)) * 100 AS porcentaje_del_total
FROM membresias mem
LEFT JOIN cte1_miembros_activos cte1
    ON mem.membresia_id = cte1.membresia_id
LEFT JOIN cte2_ingreso_total cte2
    ON mem.membresia_id = cte2.membresia_id
ORDER BY ingreso_total DESC;

-- ============================================================
-- EXPECTED OUTPUT COLUMNS:
-- ============================================================
-- nombre_plan: Membership plan name
-- miembros_activos: Number of active members
-- precio_plan: Plan monthly price
-- ingreso_total: Total monthly revenue (members × price)
-- ranking_ingreso_total: Revenue ranking (1 = highest)
-- porcentaje_del_total: Percentage of total gym revenue

-- ============================================================
-- BUSINESS VALUE:
-- ============================================================
-- Provides complete revenue breakdown by membership tier:
-- - Identifies most profitable plans
-- - Shows revenue concentration
-- - Helps prioritize marketing efforts
-- - Supports pricing strategy decisions
-- - Enables revenue forecasting
