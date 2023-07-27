CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    name VARCHAR(300),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL
);