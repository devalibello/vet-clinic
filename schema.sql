CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    name VARCHAR(300),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL,
    species_id INT,
    owner_id INT
);


CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(300),
    age INT
);

CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name VARCHAR(300)
);

ALTER TABLE animals
ADD CONSTRAINT fk_species
FOREIGN KEY (species_id) REFERENCES species(id);

ALTER TABLE animals
ADD COLUMN owner_id INT REFERENCES owners(id);

INSERT INTO owners (
    full_name,
    age
)
VALUES ('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38)
;

INSERT INTO species (
    name
)
VALUES ('Pokemon'),
('Digimon')
;

UPDATE animals
SET species_id = 2
WHERE name ILIKE '%mon';

UPDATE animals
SET species_id = 1
WHERE species_id is null;