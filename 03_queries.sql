-- ================================================
-- GYM FITNESS CENTER BUSINESS QUERIES
-- ================================================
-- Author: SQL Portfolio Project
-- Description: Analytical queries for gym membership insights
-- ================================================

USE gym_fitness;

-- ================================================
-- QUERY #1: Top 10 Most Engaged Members
-- ================================================
-- Business Question: Who are our most active members?
-- Purpose: Identify members for loyalty rewards and newsletter features
-- ================================================

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

-- ================================================
-- QUERY #2: Most Popular Classes
-- ================================================
-- Business Question: Which group classes have highest attendance?
-- Purpose: Optimize class schedules and instructor promotion
-- ================================================

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

-- ================================================
-- QUERY #3: Membership Renewal Rate by Plan Type
-- ================================================
-- Business Question: How well are we retaining members?
-- Purpose: Identify which membership plans need improvement
-- Logic: A renewal = when the same member purchases the same plan more than once
-- ================================================

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

-- ================================================
-- QUERY #4: Monthly Revenue by Membership Type
-- ================================================
-- Business Question: How are our revenues trending?
-- Purpose: Understand income streams and plan marketing budget
-- Period: Last 6 months of 2024 (July - December)
-- ================================================

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

-- ================================================
-- QUERY #5: Inactive Members at Risk
-- ================================================
-- Business Question: Which active members need re-engagement?
-- Purpose: Identify members for check-in calls or special promotions
-- Criteria: No visits in 30+ days but still have active subscription
-- ================================================

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

-- ================================================
-- END OF QUERIES
-- ================================================
