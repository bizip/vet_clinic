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



SELECT vets.name AS vet_name, animals.name AS animal_name, date_of_visit
FROM visits
JOIN vets ON vets.id = visits.vets_id AND vets.name = 'Maisy Smith'
JOIN animals ON animals.id = visits.animal_id
ORDER BY date_of_visit ASC
LIMIT 1;

-- Who was the last animal seen by William Tatcher?

select animals.name from animals inner join visits ON visits.animals_id=animals.id where
visits.vets_id=(select id from vets where name='Vet William Tatcher') 
ORDER BY date_of_visit ASC limit 1;

-- How many different animals did Stephanie Mendez see?
select COUNT(*) from animals inner join visits on animals.id=visits.animals_id where visits.vets_id=(select id from vets where name='Vet Stephanie Mendez');

-- List all vets and their specialties, including vets with no specialties
SELECT vets.name, species.name FROM vets
FULL JOIN specializations ON specializations.vets_id = vets.id
FULL JOIN species ON species.id = specializations.species_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.

SELECT animals.name, visits.date_of_visit FROM animals
 JOIN visits ON visits.animals_id = animals.id
 JOIN vets ON vets.id = visits.vets_id
 WHERE vets.name = 'Stephanie Mendez' AND
 (visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30');

--  What animal has the most visits to vets?
 select animals.name, count(*) from visits inner join animals on animals.id = visits.animals_id group by animals.name order  by count  desc limit 1;

-- Who was Maisy Smith's first visit?
select animals.name as name_of_animal,date_of_visit as First_date_of_visit, vets.name as Vet_name from vets inner join visits on visits.vets_id=vets.id inner join animals on animals.id=visits.animals_id where vets.name='Vet Maisy Smith' order by date_of_visit asc limit 1;

-- Details for most recent visit: animal information, vet information, and date of visit
SELECT animals.*, vets.*,visits.date_of_visit FROM animals
JOIN visits ON visits.animals_id = animals.id
JOIN vets ON vets.id = visits.vets_id
ORDER BY visits.date_of_visit ASC;

-- How many visits were with a vet that did not specialize in that animal's species?

SELECT vets.name AS non_specialized_vet, COUNT(vets.name) AS number_of_visit FROM vets
FULL JOIN specializations ON specializations.vets_id = vets.id
FULL JOIN visits ON visits.vets_id = vets.id
WHERE specializations.vets_id IS NULL
GROUP BY vets.name;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.

SELECT species.name as visited_the_most, COUNT(*) FROM animals
JOIN visits ON visits.animals_id = animals.id
JOIN vets ON vets.id = visits.vets_id
JOIN species ON species.id = animals.species_id
WHERE vets.name = 'Vet Maisy Smith'
GROUP BY species.name 
ORDER BY count DESC LIMIT 1;

explain analyze SELECT COUNT(*) FROM visits where animals_id = 4



