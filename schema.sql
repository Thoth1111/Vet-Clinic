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

/*Add species column to animals table in database. */
ALTER TABLE animals ADD COLUMN species varchar;

/* Additional tables. */
CREATE TABLE owners (
	id SERIAL PRIMARY KEY,
	full_name VARCHAR(100),
	age INT
);

CREATE TABLE species (
	id SERIAL PRIMARY KEY,
	name VARCHAR(100)
);
