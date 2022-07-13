/* Database schema to keep the structure of entire database. */
-- animal table
CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    date_of_birth date,
    escape_attempts int,
    neutered boolean,
    weight_kg FLOAT(5),
    PRIMARY KEY(id)
);

ALTER TABLE animals ADD species varchar(255);

-- Vet clinic database: query multiple tables
CREATE TABLE owners(
id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
full_name VARCHAR(250),
age VARCHAR(250)
);

CREATE TABLE species(
id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
name VARCHAR(250)
);

