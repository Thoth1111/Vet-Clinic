/* Database schema to keep the structure of entire database. */

CREATE TABLE animals ( 
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100), 
    date_of_birth date, 
    escape_attempts INT, 
    neutered boolean, 
    weight_kg double precision, 
    PRIMARY KEY(id) 
);

/* Add species column to animals table in database. */
ALTER TABLE animals ADD COLUMN species varchar;

/* Additional tables. */
CREATE TABLE owners (
	id INT GENERATED ALWAYS AS IDENTITY,
	full_name VARCHAR(100),
	age INT,
    PRIMARY KEY(id) 
);

CREATE TABLE species (
	id INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(100),
    PRIMARY KEY(id) 
);

/* Drop species column from animals table */
ALTER TABLE animals DROP COLUMN species;

/* Add foreign key columns to animals table */
ALTER TABLE animals
ADD COLUMN species_id INT
REFERENCES species(id);

ALTER TABLE animals
ADD COLUMN owner_id INT
REFERENCES owners(id);

/* Create vets table */
CREATE TABLE vets (
	id INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(100),
	age INT,
	date_of_graduation date,
    PRIMARY KEY(id) 
);

/* Create specialization join table */
CREATE TABLE specializations (
  species_id INT REFERENCES species(id),
  vets_id INT REFERENCES vets(id),
  PRIMARY KEY (species_id, vets_id)
);

/* Create visits join table */
CREATE TABLE visits (
  animals_id INT REFERENCES animals(id),
  vets_id INT REFERENCES vets(id),
  visit_date date,
  PRIMARY KEY (animals_id, vets_id, visit_date)
);