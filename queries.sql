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
