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

-- The statement adds a foreign key reference to the species_id column

ALTER TABLE animals
ADD CONSTRAINT fk_species
FOREIGN KEY (species_id) REFERENCES species(id);

-- The statement creates an owners_id column and adds a foreign key reference to it

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


CREATE TABLE vets (id SERIAL PRIMARY KEY, name VARCHAR(250), age INTEGER, date_of_graduation DATE);
CREATE TABLE specializations (id SERIAL PRIMARY KEY, vet_id INTEGER REFERENCES vets(id), species_id INTEGER REFERENCES species(id));
CREATE TABLE visits (id SERIAL PRIMARY KEY, animal_id INTEGER REFERENCES animals(id), vet_id INTEGER REFERENCES vets(id), visit_date DATE);