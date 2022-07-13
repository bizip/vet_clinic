/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name = 'Luna';

select name from animals where name like '%mon';
select name from animals where date_of_birth between '2016-01-01' and  '2019-01-01';
select name from animals where neutered=true and escape_attempts<=3;
select date_of_birth from animals where name='Agumon' OR name='Pikachu';
select name,  escape_attempts from animals where weight_kg>=10;
select * from animals where neutered=true;
select * from animals where name != 'Gabumon';
select * from animals where weight_kg >=10.4 and weight_kg <=17.3;

-- Query and update animals table
BEGIN;
UPDATE animals set species='digimon' where name like '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT species from animals;
COMMIT;
SELECT species from animals;
-- altering animals table by adding species to unspecified to unspecified 
BEGIN;
UPDATE animals SET species = 'unspecified';
select * from animals;
ROLLBACK;
select * from animals;

-- Delete all records in the animals table, then roll back the transaction
BEGIN;
drop table animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- Working with delete

BEGIN;
DELETE FROM animals where date_of-birth > '2022-01-01';
SAVEPOINT before_update;
update animals set weight_kg=weight_kg*-1;
ROLLBACK TO before_update;
UPDATE animals set weight_kg=weight_kg*-1 where weight_kg < 0;
COMMIT;

-- Querries that answer the following questions
-- 1.How many animals are there?
SELECT COUNT(*) FROM animals;
-- 2.How many animals have never tried to escape?
SELECT COUNT(*) from animals WHERE  escape_attempts = 0;
-- 3.What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;
-- 4.Who escapes the most, neutered or not neutered animals?
SELECT COUNT(escape_attempts) AS tope_scape,neutered from animals GROUP BY neutered;
-- 5.What is the minimum and maximum weight of each type of animal?
 SELECT MIN(weight_kg) as minimum_weight, MAX(weight_kg) as maximum_weight FROM animals;
-- 6.What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;



-- Vet clinic database: query multiple tables
INSERT INTO owners (full_name,age) values ('Sam Smith',34),('Jennifer Orwell',19),('Bob',45),
('Melody Pond',77),('Dean Winchester',14),('Jodie Whittaker',38);

-- The queries (using JOIN) to answer the following questions
-- What animals belong to Melody Pond?
SELECT  name   FROM animals   INNER JOIN owners   ON animals.owners_id = owners.id where full_name='Melody Pond';
-- List of all animals that are pokemon (their type is Pokemon).
SELECT * FROM animals INNER JOIN species ON animals.species_id = species.id where species.name='Pokemon';
-- List all owners and their animals, remember to include those that don't own any animal.
SELECT full_name As owners_name, name As Animal_name FROM animals INNER JOIN owners ON animals.owners_id = owners.id;
-- How many animals are there per species?
SELECT species.name As Name, COUNT(*) As Animals FROM animals INNER JOIN species ON animals.species_id=species.id GROUP BY (species.name);
-- List all Digimon owned by Jennifer Orwell.
 SELECT owners.full_name AS Owner, animals.name AS Name from animals INNER JOIN owners ON animals.owners_id= owners.id INNER JOIN species ON animals.species_id=species.id where owners.full_name='Jennifer Orwell' AND species.name='Digimon';
-- List all animals owned by Dean Winchester that haven't tried to escape.
 SELECT animals.name from animals INNER JOIN owners ON animals.owners_id=owners.id where owners.full_name='Dean Winchester' AND animals.escape_attempts IS NULL;
-- Who owns the most animals?
SELECT COUNT(animals.name), owners.full_name FROM animals INNER JOIN owners ON animals.owners_id = owners.id GROUP BY owners.full_name  ORDER BY count DESC LIMIT 1;


