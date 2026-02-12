-- ================================================
-- GYM FITNESS CENTER DATABASE SCHEMA
-- ================================================
-- Author: SQL Portfolio Project
-- Description: Database schema for gym membership and attendance tracking
-- ================================================

-- Create database
CREATE DATABASE IF NOT EXISTS gym_fitness;
USE gym_fitness;

-- ================================================
-- TABLE: miembros (Members)
-- Stores member information
-- ================================================
CREATE TABLE miembros (
    miembro_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    fecha_registro DATE NOT NULL,
    fecha_nacimiento DATE
);

-- ================================================
-- TABLE: membresias (Membership Plans)
-- Defines available membership types and pricing
-- ================================================
CREATE TABLE membresias (
    membresia_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_plan VARCHAR(50) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    duracion_dias INT NOT NULL,
    descripcion TEXT
);

-- ================================================
-- TABLE: suscripciones (Subscriptions)
-- Tracks member subscription history
-- ================================================
CREATE TABLE suscripciones (
    suscripcion_id INT PRIMARY KEY AUTO_INCREMENT,
    miembro_id INT NOT NULL,
    membresia_id INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    estado ENUM('activa', 'vencida', 'cancelada') NOT NULL,
    FOREIGN KEY (miembro_id) REFERENCES miembros(miembro_id),
    FOREIGN KEY (membresia_id) REFERENCES membresias(membresia_id)
);

-- ================================================
-- TABLE: pagos (Payments)
-- Records payment transactions
-- ================================================
CREATE TABLE pagos (
    pago_id INT PRIMARY KEY AUTO_INCREMENT,
    suscripcion_id INT NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    fecha_pago DATE NOT NULL,
    metodo_pago ENUM('efectivo', 'tarjeta', 'transferencia') NOT NULL,
    FOREIGN KEY (suscripcion_id) REFERENCES suscripciones(suscripcion_id)
);

-- ================================================
-- TABLE: clases (Classes)
-- Defines available group fitness classes
-- ================================================
CREATE TABLE clases (
    clase_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_clase VARCHAR(100) NOT NULL,
    instructor VARCHAR(100) NOT NULL,
    capacidad_maxima INT NOT NULL,
    descripcion TEXT
);

-- ================================================
-- TABLE: horarios_clases (Class Schedules)
-- Stores class schedule information
-- ================================================
CREATE TABLE horarios_clases (
    horario_id INT PRIMARY KEY AUTO_INCREMENT,
    clase_id INT NOT NULL,
    dia_semana ENUM('lunes', 'martes', 'miércoles', 'jueves', 'viernes', 'sábado', 'domingo') NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    FOREIGN KEY (clase_id) REFERENCES clases(clase_id)
);

-- ================================================
-- TABLE: asistencias (Attendance)
-- Tracks member check-ins for gym and classes
-- ================================================
CREATE TABLE asistencias (
    asistencia_id INT PRIMARY KEY AUTO_INCREMENT,
    miembro_id INT NOT NULL,
    fecha_asistencia DATE NOT NULL,
    hora_entrada TIME NOT NULL,
    tipo ENUM('gym', 'clase') NOT NULL,
    clase_id INT,
    FOREIGN KEY (miembro_id) REFERENCES miembros(miembro_id),
    FOREIGN KEY (clase_id) REFERENCES clases(clase_id)
);

-- ================================================
-- INDEXES for performance optimization
-- ================================================
CREATE INDEX idx_miembro_email ON miembros(email);
CREATE INDEX idx_suscripcion_estado ON suscripciones(estado);
CREATE INDEX idx_asistencia_fecha ON asistencias(fecha_asistencia);
CREATE INDEX idx_pago_fecha ON pagos(fecha_pago);
