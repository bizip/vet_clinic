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


-- Vet clinic database: query multiple tables

ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id INT REFERENCES species(id) ON DELETE CASCADE;
ALTER TABLE animals ADD COLUMN owners_id INT REFERENCES owners(id) ON DELETE CASCADE;


-- Vet clinic database: add "join table" for visits
CREATE TABLE vets(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, name VARCHAR(200),
    age INT,
    date_of_graduation DATE
);


CREATE TABLE specializations (
    vets_id INT REFERENCES species(id) ON DELETE CASCADE,
    species_id INT REFERENCES species(id) ON DELETE CASCADE
);

CREATE TABLE visits (
    vets_id INT REFERENCES vets(id) ON DELETE CASCADE,
    animals_id INT REFERENCES animals(id)
);