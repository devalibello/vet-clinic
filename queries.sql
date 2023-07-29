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

-- Query 1
SELECT animals.name
FROM animals
INNER JOIN visits ON animals.id = visits.animal_id
INNER JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.visit_date DESC
LIMIT 1;

-- Query 2
SELECT COUNT(DISTINCT visits.animal_id)
FROM visits
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez';

-- Query 3
SELECT vets.name, species.name
FROM vets
LEFT JOIN specializations ON vets.id = specializations.vet_id
LEFT JOIN species ON specializations.species_id = species.id;

-- Query 4
SELECT animals.name, vets.name, visits.visit_date
FROM animals
INNER JOIN visits ON animals.id = visits.animal_id
INNER JOIN vets ON visits.vet_id = vets.id
INNER JOIN specializations ON animals.species_id = specializations.species_id AND specializations.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez' AND visits.visit_date BETWEEN '2020-04-01' AND '2020-08-30'
ORDER BY visits.visit_date;

-- Query 5
SELECT animals.name, COUNT(*)
FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON visits.vet_id = vets.id
GROUP BY animals.id
ORDER BY COUNT(*) DESC
LIMIT 1;

-- Query 6
SELECT animals.name, visits.visit_date
FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Maisy Smith'
AND visits.visit_date = (SELECT MIN(visit_date) FROM visits WHERE vet_id = vets.id);

-- Query 7
SELECT animals.name, vets.name, visits.visit_date
FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
WHERE visits.visit_date = (SELECT MAX(visit_date) FROM visits);

-- Query 8
SELECT COUNT(*)
FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN specializations ON animals.species_id = specializations.species_id
JOIN vets ON visits.vet_id = vets.id
JOIN specializations ON vets.id = specializations.vet_id
WHERE specializations.species_id != animals.species_id;

-- Query 9
SELECT species.name, COUNT(*)
FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN species ON animals.species_id = species.id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY COUNT(*) DESC
LIMIT 1;
