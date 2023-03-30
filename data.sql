/* Populate database with sample data. */
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Agumon', '2020-02-03', 0, true, 10.23);
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Gabumon', '2018-11-15', 1, true, 8);
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Pikachu', '2021-1-7', 2, false, 15.04);
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Devimon', '2017-5-12', 5, true, 11);

/*Insert additional data to animals. */
INSERT INTO animals (
	name,date_of_birth,escape_attempts,neutered,weight_kg
)
VALUES (
    'Charmander', '2020-02-08', 0, false, -11 
);

INSERT INTO animals (
	name,date_of_birth,escape_attempts,neutered,weight_kg
)
VALUES (
    'Plantmon', '2021-11-15', 2, true, -5.7 
);

INSERT INTO animals (
	name,date_of_birth,escape_attempts,neutered,weight_kg
)
VALUES (
    'Squirtle', '1993-04-02', 3, false, -12.13 
);

INSERT INTO animals (
	name,date_of_birth,escape_attempts,neutered,weight_kg
)
VALUES (
    'Angemon', '2005-06-12', 1, true, -45 
);

INSERT INTO animals (
	name,date_of_birth,escape_attempts,neutered,weight_kg
)
VALUES (
    'Boarmon', '2005-06-07', 7, true, 20.4 
);

INSERT INTO animals (
	name,date_of_birth,escape_attempts,neutered,weight_kg
)
VALUES (
    'Blossom', '1998-10-13', 3, true, 17 
);

INSERT INTO animals (
	name,date_of_birth,escape_attempts,neutered,weight_kg
)
VALUES (
    'Ditto', '2022-05-14', 4, true, 22 
);

/* Inserts to owners table */
INSERT INTO owners (
	full_name,age
)
VALUES (
	'Sam Smith', 34
);

INSERT INTO owners (
	full_name,age
)
VALUES (
	'Jennifer Orwell', 19
);

INSERT INTO owners (
	full_name,age
)
VALUES (
	'Bob', 45
);

INSERT INTO owners (
	full_name,age
)
VALUES (
	'Melody Pond', 77
);

INSERT INTO owners (
	full_name,age
)
VALUES (
	'Dean Winchester', 14
);

INSERT INTO owners (
	full_name,age
)
VALUES (
	'Jodie Whittaker', 38
);

/* Inserts to species table */
INSERT INTO species (
	name
)
VALUES (
	'Pokemon'
);

INSERT INTO species (
	name
)
VALUES (
	'Digimon'
);

/* Add species id where animnal name ends in 'mon'*/
UPDATE animals 
SET species_id = (SELECT id FROM species WHERE name = 'Digimon')
WHERE name LIKE '%mon';

/* Add species id where animnal name doesn't end in 'mon'*/
UPDATE animals 
SET species_id = (SELECT id FROM species WHERE name = 'Pokemon')
WHERE name NOT LIKE '%mon';

/* Add owner id data */
UPDATE animals 
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')
WHERE animals.name LIKE 'Agumon';

UPDATE animals 
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
WHERE animals.name IN ('Gabumon', 'Pikachu');

UPDATE animals 
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob')
WHERE animals.name IN ('Devimon', 'Plantmon');

UPDATE animals 
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')
WHERE animals.name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals 
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
WHERE animals.name IN ('Angemon', 'Boarmon');
