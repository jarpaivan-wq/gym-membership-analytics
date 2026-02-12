-- ================================================
-- GYM FITNESS CENTER SAMPLE DATA
-- ================================================
-- Author: SQL Portfolio Project
-- Description: Sample data for gym membership database
-- ================================================

USE gym_fitness;

-- ================================================
-- INSERT: miembros (Members)
-- ================================================
INSERT INTO miembros (nombre, email, telefono, fecha_registro, fecha_nacimiento) VALUES
('Juan Pérez', 'juan.perez@email.com', '555-0101', '2024-01-15', '1990-03-20'),
('María García', 'maria.garcia@email.com', '555-0102', '2024-02-01', '1985-07-12'),
('Carlos López', 'carlos.lopez@email.com', '555-0103', '2024-02-10', '1992-11-05'),
('Ana Martínez', 'ana.martinez@email.com', '555-0104', '2024-03-05', '1988-09-18'),
('Pedro Rodríguez', 'pedro.rodriguez@email.com', '555-0105', '2024-03-20', '1995-01-30'),
('Laura Hernández', 'laura.hernandez@email.com', '555-0106', '2024-04-01', '1991-06-25'),
('Diego Fernández', 'diego.fernandez@email.com', '555-0107', '2024-04-15', '1987-12-08'),
('Sofia González', 'sofia.gonzalez@email.com', '555-0108', '2024-05-01', '1993-04-22'),
('Miguel Torres', 'miguel.torres@email.com', '555-0109', '2024-05-10', '1989-08-14'),
('Carmen Ruiz', 'carmen.ruiz@email.com', '555-0110', '2024-06-01', '1994-02-17'),
('Roberto Jiménez', 'roberto.jimenez@email.com', '555-0111', '2024-06-15', '1986-10-09'),
('Isabel Moreno', 'isabel.moreno@email.com', '555-0112', '2024-07-01', '1992-05-03'),
('Fernando Álvarez', 'fernando.alvarez@email.com', '555-0113', '2024-07-20', '1990-11-27'),
('Patricia Romero', 'patricia.romero@email.com', '555-0114', '2024-08-01', '1988-03-15'),
('Ricardo Navarro', 'ricardo.navarro@email.com', '555-0115', '2024-08-15', '1991-07-21');

-- ================================================
-- INSERT: membresias (Membership Plans)
-- ================================================
INSERT INTO membresias (nombre_plan, precio, duracion_dias, descripcion) VALUES
('Mensual', 50.00, 30, 'Acceso completo al gimnasio por 30 días'),
('Trimestral', 135.00, 90, 'Acceso completo al gimnasio por 90 días (10% descuento)'),
('Semestral', 255.00, 180, 'Acceso completo al gimnasio por 180 días (15% descuento)'),
('Anual', 480.00, 365, 'Acceso completo al gimnasio por 365 días (20% descuento)');

-- ================================================
-- INSERT: suscripciones (Subscriptions)
-- ================================================
INSERT INTO suscripciones (miembro_id, membresia_id, fecha_inicio, fecha_fin, estado) VALUES
(1, 1, '2024-01-15', '2024-02-14', 'vencida'),
(1, 1, '2024-02-15', '2024-03-16', 'vencida'),
(1, 1, '2024-03-17', '2024-04-16', 'vencida'),
(1, 1, '2024-04-17', '2024-05-17', 'vencida'),
(1, 1, '2024-05-18', '2024-06-17', 'vencida'),
(1, 1, '2024-06-18', '2024-07-18', 'vencida'),
(1, 1, '2024-07-19', '2024-08-18', 'vencida'),
(1, 1, '2024-08-19', '2024-09-18', 'vencida'),
(1, 1, '2024-09-19', '2024-10-19', 'activa'),
(2, 2, '2024-02-01', '2024-05-01', 'vencida'),
(2, 2, '2024-05-02', '2024-08-01', 'vencida'),
(2, 2, '2024-08-02', '2024-11-01', 'activa'),
(3, 1, '2024-02-10', '2024-03-12', 'vencida'),
(3, 1, '2024-03-13', '2024-04-12', 'vencida'),
(3, 3, '2024-04-13', '2024-10-10', 'activa'),
(4, 4, '2024-03-05', '2025-03-05', 'activa'),
(5, 1, '2024-03-20', '2024-04-19', 'vencida'),
(5, 1, '2024-04-20', '2024-05-20', 'vencida'),
(5, 2, '2024-05-21', '2024-08-20', 'vencida'),
(5, 2, '2024-08-21', '2024-11-20', 'activa'),
(6, 3, '2024-04-01', '2024-09-28', 'activa'),
(7, 1, '2024-04-15', '2024-05-15', 'vencida'),
(7, 2, '2024-05-16', '2024-08-15', 'vencida'),
(7, 2, '2024-08-16', '2024-11-15', 'activa'),
(8, 1, '2024-05-01', '2024-05-31', 'vencida'),
(8, 1, '2024-06-01', '2024-07-01', 'vencida'),
(8, 1, '2024-07-02', '2024-08-01', 'vencida'),
(9, 4, '2024-05-10', '2025-05-10', 'activa'),
(10, 1, '2024-06-01', '2024-07-01', 'vencida'),
(11, 2, '2024-06-15', '2024-09-14', 'activa');

-- ================================================
-- INSERT: pagos (Payments)
-- ================================================
INSERT INTO pagos (suscripcion_id, monto, fecha_pago, metodo_pago) VALUES
(1, 50.00, '2024-01-15', 'tarjeta'),
(2, 50.00, '2024-02-15', 'tarjeta'),
(3, 50.00, '2024-03-17', 'tarjeta'),
(4, 50.00, '2024-04-17', 'efectivo'),
(5, 50.00, '2024-05-18', 'tarjeta'),
(6, 50.00, '2024-06-18', 'tarjeta'),
(7, 50.00, '2024-07-19', 'transferencia'),
(8, 50.00, '2024-08-19', 'tarjeta'),
(9, 50.00, '2024-09-19', 'tarjeta'),
(10, 135.00, '2024-02-01', 'tarjeta'),
(11, 135.00, '2024-05-02', 'tarjeta'),
(12, 135.00, '2024-08-02', 'transferencia'),
(13, 50.00, '2024-02-10', 'efectivo'),
(14, 50.00, '2024-03-13', 'efectivo'),
(15, 255.00, '2024-04-13', 'tarjeta'),
(16, 480.00, '2024-03-05', 'transferencia'),
(17, 50.00, '2024-03-20', 'tarjeta'),
(18, 50.00, '2024-04-20', 'tarjeta'),
(19, 135.00, '2024-05-21', 'tarjeta'),
(20, 135.00, '2024-08-21', 'tarjeta'),
(21, 255.00, '2024-04-01', 'transferencia'),
(22, 50.00, '2024-04-15', 'efectivo'),
(23, 135.00, '2024-05-16', 'tarjeta'),
(24, 135.00, '2024-08-16', 'tarjeta'),
(25, 50.00, '2024-05-01', 'tarjeta'),
(26, 50.00, '2024-06-01', 'efectivo'),
(27, 50.00, '2024-07-02', 'tarjeta'),
(28, 480.00, '2024-05-10', 'transferencia');

-- ================================================
-- INSERT: clases (Classes)
-- ================================================
INSERT INTO clases (nombre_clase, instructor, capacidad_maxima, descripcion) VALUES
('Yoga', 'Ana Wellness', 15, 'Clase de yoga para todos los niveles'),
('Spinning', 'Carlos Cardio', 20, 'Entrenamiento cardiovascular intenso'),
('CrossFit', 'Miguel Strong', 12, 'Entrenamiento funcional de alta intensidad'),
('Pilates', 'Laura Balance', 15, 'Fortalecimiento del core y flexibilidad'),
('Zumba', 'Sofia Dance', 25, 'Baile fitness con ritmos latinos'),
('HIIT', 'Roberto Power', 18, 'Entrenamiento de intervalos de alta intensidad'),
('Boxeo', 'Diego Fight', 10, 'Técnicas de boxeo y acondicionamiento');

-- ================================================
-- INSERT: horarios_clases (Class Schedules)
-- ================================================
INSERT INTO horarios_clases (clase_id, dia_semana, hora_inicio, hora_fin) VALUES
(1, 'lunes', '07:00:00', '08:00:00'),
(1, 'miércoles', '07:00:00', '08:00:00'),
(2, 'martes', '18:00:00', '19:00:00'),
(2, 'jueves', '18:00:00', '19:00:00'),
(3, 'lunes', '19:00:00', '20:00:00'),
(3, 'viernes', '19:00:00', '20:00:00'),
(4, 'martes', '10:00:00', '11:00:00'),
(5, 'sábado', '10:00:00', '11:00:00'),
(6, 'miércoles', '18:30:00', '19:30:00'),
(6, 'viernes', '18:30:00', '19:30:00'),
(7, 'jueves', '19:00:00', '20:00:00'),
(7, 'sábado', '11:00:00', '12:00:00');

-- ================================================
-- INSERT: asistencias (Attendance)
-- ================================================
INSERT INTO asistencias (miembro_id, fecha_asistencia, hora_entrada, tipo, clase_id) VALUES
(1, '2024-09-01', '08:00:00', 'gym', NULL),
(1, '2024-09-03', '18:00:00', 'clase', 2),
(1, '2024-09-05', '19:00:00', 'clase', 3),
(1, '2024-09-08', '09:00:00', 'gym', NULL),
(1, '2024-09-10', '18:30:00', 'clase', 6),
(1, '2024-09-12', '08:00:00', 'gym', NULL),
(1, '2024-09-15', '19:00:00', 'clase', 5),
(1, '2024-09-18', '18:00:00', 'clase', 2),
(2, '2024-09-02', '10:00:00', 'gym', NULL),
(2, '2024-09-04', '10:00:00', 'clase', 4),
(2, '2024-09-07', '09:00:00', 'gym', NULL),
(2, '2024-09-09', '10:00:00', 'clase', 4),
(2, '2024-09-11', '11:00:00', 'gym', NULL),
(2, '2024-09-14', '10:00:00', 'clase', 5),
(2, '2024-09-16', '10:00:00', 'gym', NULL),
(3, '2024-09-01', '07:00:00', 'clase', 1),
(3, '2024-09-03', '07:00:00', 'clase', 1),
(3, '2024-09-06', '19:00:00', 'clase', 3),
(3, '2024-09-08', '07:00:00', 'clase', 1),
(3, '2024-09-10', '07:00:00', 'clase', 1),
(3, '2024-09-13', '19:00:00', 'clase', 3),
(4, '2024-09-05', '18:30:00', 'clase', 6),
(4, '2024-09-07', '18:30:00', 'clase', 6),
(4, '2024-09-12', '18:30:00', 'clase', 6),
(4, '2024-09-14', '18:30:00', 'clase', 6),
(4, '2024-09-19', '18:30:00', 'clase', 6),
(5, '2024-09-02', '18:00:00', 'clase', 2),
(5, '2024-09-04', '18:00:00', 'clase', 2),
(5, '2024-09-09', '18:00:00', 'clase', 2),
(5, '2024-09-11', '18:00:00', 'clase', 2),
(6, '2024-09-03', '19:00:00', 'clase', 7),
(6, '2024-09-06', '11:00:00', 'clase', 7),
(6, '2024-09-10', '19:00:00', 'clase', 7),
(6, '2024-09-13', '11:00:00', 'clase', 7),
(7, '2024-09-01', '16:00:00', 'gym', NULL),
(7, '2024-09-05', '17:00:00', 'gym', NULL),
(7, '2024-09-10', '16:30:00', 'gym', NULL),
(8, '2024-06-15', '14:00:00', 'gym', NULL),
(9, '2024-09-02', '15:00:00', 'gym', NULL),
(9, '2024-09-09', '15:30:00', 'gym', NULL),
(10, '2024-06-20', '12:00:00', 'gym', NULL),
(11, '2024-09-01', '10:00:00', 'gym', NULL),
(11, '2024-09-08', '10:30:00', 'gym', NULL),
(12, '2024-07-15', '13:00:00', 'gym', NULL),
(13, '2024-08-05', '14:30:00', 'gym', NULL);
