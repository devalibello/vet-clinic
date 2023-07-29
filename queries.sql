SELECT * FROM animals
WHERE name ILIKE '%mon';

SELECT name FROM animals
WHERE EXTRACT(YEAR FROM date_of_birth) BETWEEN 2016 AND 2019;

SELECT name FROM animals
WHERE neutered = TRUE AND escape_attempts < 3;

SELECT date_of_birth FROM animals
WHERE name = 'Agumon' OR name = 'Pikachu';

SELECT name, escape_attempts FROM animals
WHERE weight_kg > 10.5;

SELECT * FROM animals
WHERE neutered = TRUE;

SELECT * FROM animals
WHERE name != 'Gabumon';

SELECT * FROM animals
WHERE weight_kg BETWEEN 10.4 AND 17.3;

ALTER TABLE animals
ADD COLUMN species VARCHAR(20);

INSERT INTO animals (
        name,
        date_of_birth,
        escape_attempts,
        neutered,
        weight_kg
    )
VALUES (
        'Charmander',
        '2020-02-08',
        0,
        FALSE,
        -11
    ),
    (
        'Plantmon',
        '2021-11-15',
        2,
        TRUE,
        -5.7
    ),
    (
        'Squirtle',
        '1993-04-02',
        3,
        FALSE,
        -12.13
    ),
    (
        'Angemon',
        '2005-04-2',
        1,
        TRUE,
        -45
    ),
     (
        'Boarmon',
        '2005-06-07',
        7,
        TRUE,
        20.4
    ),
     (
        'Angemon',
        '2005-04-2',
        1,
        TRUE,
        -45
    ),
     (
        'Ditto',
        '2022-05-14',
        4,
        TRUE,
        22
    );

DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

 update animals set weight_kg = weight_kg * -1 where weight_kg < 0;

 update animals set weight_kg = weight_kg * -1;

 update animals set species = 'pokemon' where species is null;

 update animals set species = 'digimon' where name ILIKE '%mon';

SELECT COUNT(*) FROM animals;

 select count(id) from animals;

 select count(escape_attempts) from animals group by escape_attempts having escape_attempts = 0;

 select avg(weight_kg) from animals;

select neutered, sum(escape_attempts) from animals group by neutered;

 select species, min(weight_kg), max(weight_kg) from animals group by species;

select species, avg(escape_attempts) from animals where date_of_birth >= '1990-01-01' and date_of_birth <= '2000-12-31' group by species;

SELECT animals.name
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

SELECT animals.name FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

SELECT owners.full_name AS owners_name, animals.name AS animal_name FROM owners
LEFT JOIN animals ON animals.owner_id = owners.id;

SELECT species.name AS specie_name, COUNT(animals.species_id) AS num_of_animals
FROM animals
JOIN species ON animals.species_id = species.id
GROUP BY species.name;


SELECT animals.name AS animal_name, owners.full_name AS owner_name, species.name AS specie_name
FROM animals
JOIN owners ON animals.owner_id = owners.id
JOIN species ON animals.species_id = species.id
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

SELECT animals.name AS animal_name, animals.escape_attempts AS escape_attempts FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owner_id = 5;


SELECT owners.id AS owner_id, owners.full_name AS owner_name, COUNT(animals.owner_id) AS num_of_animals
FROM animals
JOIN owners ON animals.owner_id = owners.id
GROUP BY owners.id, owners.full_name
ORDER BY num_of_animals DESC
LIMIT 1;
