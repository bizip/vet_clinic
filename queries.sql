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
ROLLBACK;

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


