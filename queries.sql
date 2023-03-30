/*Queries that provide answers to the questions from all projects.*/
SELECT * FROM animals WHERE name LIKE '%mon';
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT * FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name NOT IN ('Gabumon');
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

/*Transactions*/
BEGIN;
UPDATE animals
SET species = 'unspecified';
ROLLBACK;

BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';
UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;
COMMIT;

BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;

BEGIN;
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';
SAVEPOINT del_2022;
UPDATE animals
SET weight_kg = weight_kg * -1;
ROLLBACK TO del_2022;

UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
COMMIT;

/* Queries */
SELECT COUNT(*) FROM animals;

SELECT
COUNT(escape_attempts)
FROM
animals
GROUP BY escape_attempts
HAVING (escape_attempts) = 0; 

SELECT AVG(weight_kg) FROM animals;

SELECT name, escape_attempts
FROM animals
INNER JOIN (
  SELECT MAX(escape_attempts) AS max_escapes
  FROM animals
) AS max_animals
ON escape_attempts = max_escapes;

SELECT 
species, MIN(weight_kg), MAX(weight_kg)
FROM
animals
GROUP BY species;

SELECT 
species, AVG(escape_attempts)
FROM
animals
WHERE date_of_birth >= '1990-01-01' AND date_of_birth < '2001-01-01'
GROUP BY species;

/* Multiple table queries using JOIN */
SELECT name
FROM animals
JOIN owners ON animals.owner_id = (
SELECT owners.id WHERE full_name = 'Melody Pond');

SELECT animals.name
FROM animals
JOIN species ON animals.species_id = (
SELECT species.id WHERE species.name = 'Pokemon');

SELECT animals.name, owners.full_name
FROM animals
RIGHT JOIN owners ON animals.owner_id = owners.id;

SELECT species.name, COUNT(animals.name)
FROM animals
JOIN species ON animals.species_id = species.id
GROUP BY species.name;

SELECT animals.name
FROM animals
JOIN owners ON animals.owner_id = (
SELECT owners.id WHERE full_name = 'Jennifer Orwell')
JOIN species ON animals.species_id = (
SELECT species.id WHERE species.name = 'Digimon');

SELECT animals.name
FROM animals
JOIN owners ON animals.owner_id = (
SELECT owners.id WHERE full_name = 'Dean Winchester')
AND animals.escape_attempts = 0;

SELECT owners.full_name
FROM owners
JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.full_name
ORDER BY COUNT(*) DESC
LIMIT 1;

/* many-to-many queries */
SELECT animals.name
FROM animals
JOIN visits ON animals.id = visits.animals_id
JOIN vets ON visits.vets_id = vets.id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.visit_date DESC
LIMIT 1;

SELECT COUNT(DISTINCT animals.name)
FROM animals
JOIN visits ON animals.id = visits.animals_id
JOIN vets ON visits.vets_id = vets.id
WHERE vets.name = 'Stephanie Mendez';

SELECT vets.name, species.name
FROM vets
LEFT JOIN specializations ON vets.id = vets_id
LEFT JOIN species ON species.id = species_id;

SELECT animals.name
FROM animals
JOIN visits ON animals.id = animals_id AND visit_date >= '2020-04-01' AND visit_date <= '2020-08-30'
JOIN vets ON visits.vets_id = vets.id
WHERE vets.name = 'Stephanie Mendez';

SELECT animals.name
FROM animals
JOIN visits ON animals.id = animals_id
GROUP BY animals.name
ORDER BY COUNT(*) DESC
LIMIT 1;

SELECT animals.name
FROM animals
JOIN visits ON animals.id = visits.animals_id
JOIN vets ON visits.vets_id = vets.id
WHERE vets.name = 'Maisy Smith'
ORDER BY visits.visit_date ASC
LIMIT 1;

SELECT animals.name, species.name, vets.name, visits.visit_date
FROM visits
JOIN animals ON animals.id = visits.animals_id
JOIN vets ON vets.id = visits.vets_id
JOIN species ON species.id = animals.species_id
WHERE visits.visit_date = (
  SELECT MAX(visit_date)
  FROM visits
);

SELECT COUNT(visit_date)
FROM visits
JOIN animals ON animals.id = visits.animals_id
WHERE vets_id NOT IN (
  SELECT vets_id
  FROM specializations
  WHERE species_id = animals.species_id
);

SELECT species.name
FROM visits
JOIN vets ON visits.vets_id = (
	SELECT vets_id FROM vets WHERE vets.name = 'Maisy Smith')
JOIN animals ON animals.id = visits.animals_id
JOIN species ON species.id = animals.species_id
GROUP BY species.name
ORDER BY COUNT(*) DESC
LIMIT 1;


