-- Create database called clinic
CREATE DATABASE clinic;

-- table for patient
 CREATE TABLE patients ( 
        id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        name VARCHAR(200),
        date_of_birth DATE
    );

-- Table for medical histories

    CREATE TABLE medical_histories ( 
        id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        admitted_at TIMESTAMP,
        patient_id INTEGER,
        status VARCHAR(20),
        CONSTRAINT fk_patient_id 
            FOREIGN KEY (patient_id) 
            REFERENCES patients(id) 
            ON DELETE CASCADE
    );