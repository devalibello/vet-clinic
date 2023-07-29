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
