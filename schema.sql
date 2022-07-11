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

