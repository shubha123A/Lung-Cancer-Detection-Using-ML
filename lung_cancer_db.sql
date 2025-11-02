-- Create Database
CREATE DATABASE IF NOT EXISTS lung_cancer_detection_db;
USE lung_cancer_detection_db;

-- Users Table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255),
    phone VARCHAR(20),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Doctors Table
CREATE TABLE doctors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    qualification VARCHAR(255),
    experience VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(255),
    address TEXT,
    fees DECIMAL(10,2),
    rating DECIMAL(3,2),
    availability JSON,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Appointments Table
CREATE TABLE appointments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id VARCHAR(50) UNIQUE NOT NULL,
    user_id INT NOT NULL,
    doctor_id INT NOT NULL,
    patient_name VARCHAR(255) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(255),
    address TEXT NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    reason VARCHAR(255),
    symptoms TEXT,
    previous_diagnosis TEXT,
    status ENUM('Confirmed', 'Cancelled', 'Completed') DEFAULT 'Confirmed',
    booked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(id)
);

-- ML Predictions Table
CREATE TABLE ml_predictions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    age INT,
    gender INT,
    air_pollution DECIMAL(5,2),
    alcohol_use DECIMAL(5,2),
    balanced_diet DECIMAL(5,2),
    obesity DECIMAL(5,2),
    smoking DECIMAL(5,2),
    passive_smoker DECIMAL(5,2),
    fatigue DECIMAL(5,2),
    weight_loss DECIMAL(5,2),
    shortness_of_breath DECIMAL(5,2),
    wheezing DECIMAL(5,2),
    swallowing_difficulty DECIMAL(5,2),
    clubbing_of_finger_nails DECIMAL(5,2),
    frequent_cold DECIMAL(5,2),
    dry_cough DECIMAL(5,2),
    snoring DECIMAL(5,2),
    prediction_result VARCHAR(50),
    risk_level VARCHAR(20),
    confidence_score DECIMAL(5,4),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- CNN Predictions Table
CREATE TABLE cnn_predictions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    file_name VARCHAR(255),
    file_type VARCHAR(50),
    file_size VARCHAR(50),
    cancer_confidence DECIMAL(5,4),
    normal_confidence DECIMAL(5,4),
    final_prediction VARCHAR(100),
    risk_level VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Insert Sample Doctors
INSERT INTO doctors (name, specialization, qualification, experience, phone, email, address, fees, rating, availability) VALUES
('Dr. Sarah Chen', 'Pulmonologist', 'MD, FCCP', '15 years', '+1-555-0101', 'dr.chen@chestcare.com', '123 Chest Care Center, Medical District, NY 10001', 1500.00, 4.8, '["Monday", "Wednesday", "Friday"]'),
('Dr. Michael Rodriguez', 'Pulmonology & Critical Care', 'MD, MPH', '12 years', '+1-555-0102', 'dr.rodriguez@lunghealth.org', '456 Respiratory Institute, Health Plaza, NY 10002', 1800.00, 4.7, '["Tuesday", "Thursday", "Saturday"]'),
('Dr. James Wilson', 'Oncologist', 'MD, PhD', '20 years', '+1-555-0103', 'dr.wilson@cancercenter.com', '789 Cancer Care Center, Medical Complex, NY 10003', 2500.00, 4.9, '["Monday", "Tuesday", "Friday"]'),
('Dr. Emily Parker', 'Thoracic Oncology', 'MD, FACP', '18 years', '+1-555-0104', 'dr.parker@thoraciccare.org', '321 Thoracic Specialists, Health Tower, NY 10004', 2200.00, 4.8, '["Wednesday", "Thursday", "Saturday"]'),
('Dr. Robert Kim', 'Radiologist', 'MD, DABR', '14 years', '+1-555-0105', 'dr.kim@imagingcenter.com', '654 Advanced Imaging, Diagnostic Plaza, NY 10005', 1200.00, 4.6, '["Monday", "Wednesday", "Friday", "Saturday"]');

-- Insert Default Admin User
INSERT INTO users (username, password, first_name, last_name, email, phone, address) VALUES
('admin', 'admin', 'Admin', 'User', 'admin@lungcancer.com', '+1-555-0000', 'System Administrator');

-- Show final database status
SHOW TABLES;



