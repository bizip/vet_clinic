/* Populate database with sample data. */

INSERT INTO animals (name) VALUES ('Luna');
INSERT INTO animals (name) VALUES ('Daisy');
INSERT INTO animals (name) VALUES ('Charlie');
CREATE DATABASE vet_clinic;
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) values ( 'Agumon','2020-02-03',0,true,10.23);
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) values ( 'Gabumon','2018-11-15',2,true,8);
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) values ( 'Pikachu','2021-01-07',1,false,15.04);
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) values ( 'Devimon','2017-05-12',5,true,11);
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) values ('Charmander', '2020-2-8', 0, false, -11.0);
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) values ( 'Plantmon','2020-11-15',2,true,-5.7);
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) values ( 'Squirtle','1993-02-04',2,true,-5.7);
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) values ( 'Angemon','1998-06-12',1,true,-45);
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) values ( 'Boarmon','2005-07-05',7,true,20.4);
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) values ( 'Blossom','1998-13-10',3,true,17);
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) values ( 'Angemon','2022-05-14',4,true,22);

-- insert data in owners table
INSERT INTO owners (full_name,age) values ('Sam Smith',34),('Jennifer Orwell',19),('Bob',45),
('Melody Pond',77),('Dean Winchester',14),('Jodie Whittaker',38);

-- add species id in animals table

ALTER TABLE animals set 
UPDATE animals set species_id=(SELECT id FROM species where name='Digimon') WHERE name LIKE '%mon';
UPDATE animals set species_id=(SELECT id FROM species where name='Pokemon') WHERE species_id IS NULL;
UPDATE animals set owners_id = (SELECT id FROM owners where  full_name = 'Sam Smith') where name = 'Agumon';
UPDATE animals set owners_id = (SELECT id FROM owners where  full_name = 'Jennifer Orwell') where name = 'Gabumon' OR name = 'Pikachu';
UPDATE animals set owners_id = (SELECT id FROM owners where  full_name = 'Bob') where name = 'Devimon' OR name = 'Plantmon';
UPDATE animals set owners_id = (SELECT id FROM owners where  full_name = 'Melody Pond') where name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';
UPDATE animals set owners_id = (SELECT id FROM owners where  full_name = 'Dean Winchester') where name = 'Angemon' OR name ='Boarmon';

-- Insert the following data for vets:

INSERT INTO vets (name, age,date_of_graduation)
VALUES ('Vet William Tatcher',45,'2000-04-23'),
('Vet Maisy Smith',26,'2019-01-17'),
('Vet Stephanie Mendez',61,'1982-03-04'),
('Vet Jack Harkness',23,'2008-6-08');

 INSERT INTO specializations (vets_id,species_id) VALUES 
 ((SELECT id from vets where name='Vet William Tatcher'),
 (SELECT id FROM species WHERE name='Pokemon'));

INSERT INTO specializations (vets_id,species_id) VALUES 
((SELECT id from vets where name='Vet Stephanie Mendez'),
(SELECT id FROM species WHERE name='Pokemon'));

INSERT INTO specializations (vets_id,species_id) VALUES 
((SELECT id from vets where name='Vet Stephanie Mendez'),
(SELECT id FROM species WHERE name='Digimon'));

INSERT INTO specializations (vets_id,species_id) VALUES 
((SELECT id from vets where name='Vet Jack Harkness'),
(SELECT id FROM species WHERE name='Digimon'));
