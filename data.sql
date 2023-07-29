INSERT INTO animals (
        name,
        date_of_birth,
        escape_attempts,
        neutered,
        weight_kg species,
        species_id,
        owner_id
    )
VALUES (
        'Agumon',
        '2020-02-03',
        0,
        TRUE,
        10.23,
        2,
        1
    ),
    (
        'Gabumon',
        '2018-11-15',
        2,
        TRUE,
        8,
        2,
        2
    ),
    (
        'Pikachu',
        '2021-01-07',
        1,
        FALSE,
        15.04,
        1,
        2
    ),
    (
        'Devimon',
        '2017-05-12',
        5,
        TRUE,
        11,
        2,
        3
    ),
    (
        'Charmander',
        '2020-02-08',
        0,
        FALSE,
        11,
        1,
        4
    ),
    (
        'Plantmon',
        '2021-11-15',
        2,
        TRUE,
        5.7,
        2,
        3
    ),
    (
        'Squirtle',
        '1993-04-02',
        3,
        FALSE,
        12.13,
        1,
        4
    ),
    (
        'Angemon',
        '2005-04-2',
        1,
        TRUE,
        45,
        2,
        5
    ),
    (
        'Boarmon',
        '2005-06-07',
        7,
        TRUE,
        20.4,
        2,
        5
    ),
    (
        'Ditto',
        '2022-05-14',
        4,
        TRUE,
        22
    ),
    (
        'Blossom',
        '1998-10-13',
        3,
        TRUE,
        17,
        1,
        2
    );

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

INSERT INTO animals
SET owners_id = 5
WHERE name = 'Boarmon' OR name = 'Angemon';

INSERT INTO animals
SET owners_id = 2
WHERE name = 'Gabumon' OR name = 'Pikachu';

INSERT INTO animals
SET owners_id = 1
WHERE name = 'Agumon';

INSERT INTO animals
SET owners_id = 3
WHERE name = 'Devimon' OR name = 'Plantmon';

INSERT INTO animals
SET owners_id = 4
WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';

INSERT INTO vets (name, age, date_of_graduation) VALUES ('William Tatcher', 45, '2000-04-23');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Maisy Smith', 26, '2019-01-17');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Stephanie Mendez', 64, '1981-05-04');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Jack Harkness', 38, '2008-06-08');

INSERT INTO specializations (vet_id, species_id) SELECT vets.id, species.id FROM vets, species WHERE vets.name = 'William Tatcher' AND species.name = 'Pokemon';
INSERT INTO specializations (vet_id, species_id) SELECT vets.id, species.id FROM vets, species WHERE vets.name = 'Stephanie Mendez' AND species.name IN ('Digimon', 'Pokemon');
INSERT INTO specializations (vet_id, species_id) SELECT vets.id, species.id FROM vets, species WHERE vets.name = 'Jack Harkness' AND species.name = 'Digimon';

INSERT INTO visits (animal_id, vet_id, visit_date)
SELECT a.id, v.id, visit_date
FROM animals a
JOIN vets v ON a.name = v.name
WHERE a.name IN ('Agumon', 'Gabumon', 'Pikachu', 'Devimon', 'Charmander', 'Plantmon', 'Squirtle', 'Angemon', 'Boarmon', 'Blossom')
AND v.name IN ('William Tatcher', 'Stephanie Mendez', 'Jack Harkness', 'Maisy Smith')
AND (a.name, v.name, visit_date) NOT IN (
    SELECT animals.name, vets.name, visit_date
    FROM visits
    JOIN animals ON visits.animal_id = animals.id
    JOIN vets ON visits.vet_id = vets.id
);

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
