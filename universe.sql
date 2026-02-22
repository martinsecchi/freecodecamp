-- Crear tabla galaxy
CREATE TABLE galaxy (
  galaxy_id SERIAL PRIMARY KEY,
  name VARCHAR NOT NULL UNIQUE,
  type VARCHAR NOT NULL,
  num_stars INT,
  has_life BOOLEAN,
  description TEXT
);

-- Crear tabla star
CREATE TABLE star (
  star_id SERIAL PRIMARY KEY,
  galaxy_id INT NOT NULL,
  name VARCHAR NOT NULL UNIQUE,
  type VARCHAR,
  distance_ly NUMERIC NOT NULL,
  is_main_sequence BOOLEAN,
  FOREIGN KEY(galaxy_id) REFERENCES galaxy(galaxy_id)
);

-- Crear tabla planet
CREATE TABLE planet (
  planet_id SERIAL PRIMARY KEY,
  star_id INT NOT NULL,
  name VARCHAR NOT NULL UNIQUE,
  type VARCHAR,
  diameter_km INT,
  has_water BOOLEAN,
  FOREIGN KEY(star_id) REFERENCES star(star_id)
);

-- Crear tabla moon
CREATE TABLE moon (
  moon_id SERIAL PRIMARY KEY,
  planet_id INT NOT NULL,
  name VARCHAR NOT NULL UNIQUE,
  diameter_km INT,
  has_atmosphere BOOLEAN,
  FOREIGN KEY(planet_id) REFERENCES planet(planet_id)
);

-- Tabla adicional (5ta tabla)
CREATE TABLE comet (
  comet_id SERIAL PRIMARY KEY,
  name VARCHAR NOT NULL UNIQUE,
  orbital_period INT,
  last_seen NUMERIC,
  is_periodic BOOLEAN
);

-- Insertar datos de galaxy (6+ filas)
INSERT INTO galaxy (name, type, num_stars, has_life, description) VALUES ('Milky Way', 'Spiral', 400000000, true, 'Our home galaxy with billions of stars');
INSERT INTO galaxy (name, type, num_stars, has_life, description) VALUES ('Andromeda', 'Spiral', 1000000000, false, 'Nearest major galaxy to the Milky Way');
INSERT INTO galaxy (name, type, num_stars, has_life, description) VALUES ('Triangulum', 'Spiral', 40000000, false, 'Small spiral galaxy in the Local Group');
INSERT INTO galaxy (name, type, num_stars, has_life, description) VALUES ('Centaurus A', 'Elliptical', 100000000, false, 'Active galaxy with a supermassive black hole');
INSERT INTO galaxy (name, type, num_stars, has_life, description) VALUES ('Whirlpool', 'Spiral', 50000000, false, 'Beautiful spiral galaxy with prominent arms');
INSERT INTO galaxy (name, type, num_stars, has_life, description) VALUES ('Sombrero', 'Spiral', 800000000, false, 'Galaxy with a prominent dust lane');

-- Insertar datos en star (6+ filas)
INSERT INTO star (galaxy_id, name, type, distance_ly, is_main_sequence) VALUES (1, 'Sun', 'G-type', 0.0, true);
INSERT INTO star (galaxy_id, name, type, distance_ly, is_main_sequence) VALUES (1, 'Proxima Centauri', 'M-type', 4.24, true);
INSERT INTO star (galaxy_id, name, type, distance_ly, is_main_sequence) VALUES (1, 'Sirius', 'A-type', 8.6, false);
INSERT INTO star (galaxy_id, name, type, distance_ly, is_main_sequence) VALUES (2, 'Alpheratz', 'B-type', 97, false);
INSERT INTO star (galaxy_id, name, type, distance_ly, is_main_sequence) VALUES (2, 'Mirach', 'M-type', 199, true);
INSERT INTO star (galaxy_id, name, type, distance_ly, is_main_sequence) VALUES (3, 'HIP 4813', 'F-type', 198, false);

-- Insertar datos en planet (12+ filas)
INSERT INTO planet (star_id, name, type, diameter_km, has_water) VALUES (1, 'Earth', 'Terrestrial', 12742, true);
INSERT INTO planet (star_id, name, type, diameter_km, has_water) VALUES (1, 'Mars', 'Terrestrial', 6779, false);
INSERT INTO planet (star_id, name, type, diameter_km, has_water) VALUES (1, 'Venus', 'Terrestrial', 12104, false);
INSERT INTO planet (star_id, name, type, diameter_km, has_water) VALUES (2, 'Proxima b', 'Terrestrial', 11000, true);
INSERT INTO planet (star_id, name, type, diameter_km, has_water) VALUES (2, 'Proxima Centauri c', 'Terrestrial', 20000, false);
INSERT INTO planet (star_id, name, type, diameter_km, has_water) VALUES (3, 'Sirius Aa', 'Terrestrial', 15000, false);
INSERT INTO planet (star_id, name, type, diameter_km, has_water) VALUES (4, 'Andromeda 1', 'Terrestrial', 13000, true);
INSERT INTO planet (star_id, name, type, diameter_km, has_water) VALUES (4, 'Andromeda 2', 'Gas Giant', 70000, false);
INSERT INTO planet (star_id, name, type, diameter_km, has_water) VALUES (5, 'Mirach b', 'Terrestrial', 12000, true);
INSERT INTO planet (star_id, name, type, diameter_km, has_water) VALUES (5, 'Mirach c', 'Terrestrial', 14000, false);
INSERT INTO planet (star_id, name, type, diameter_km, has_water) VALUES (6, 'Triangulum 1', 'Terrestrial', 11500, true);
INSERT INTO planet (star_id, name, type, diameter_km, has_water) VALUES (6, 'Triangulum 2', 'Terrestrial', 12500, false);

-- Insertar datos en moon (20+ filas)
INSERT INTO moon (planet_id, name, diameter_km, has_atmosphere) VALUES (1, 'Moon', 3474, false);
INSERT INTO moon (planet_id, name, diameter_km, has_atmosphere) VALUES (2, 'Phobos', 22, false);
INSERT INTO moon (planet_id, name, diameter_km, has_atmosphere) VALUES (2, 'Deimos', 12, false);
INSERT INTO moon (planet_id, name, diameter_km, has_atmosphere) VALUES (3, 'Moon of Venus 1', 1000, false);
INSERT INTO moon (planet_id, name, diameter_km, has_atmosphere) VALUES (3, 'Moon of Venus 2', 800, false);
INSERT INTO moon (planet_id, name, diameter_km, has_atmosphere) VALUES (4, 'Proxima b I', 2000, true);
INSERT INTO moon (planet_id, name, diameter_km, has_atmosphere) VALUES (4, 'Proxima b II', 1500, false);
INSERT INTO moon (planet_id, name, diameter_km, has_atmosphere) VALUES (5, 'Proxima c I', 3000, true);
INSERT INTO moon (planet_id, name, diameter_km, has_atmosphere) VALUES (6, 'Sirius Moon 1', 1200, false);
INSERT INTO moon (planet_id, name, diameter_km, has_atmosphere) VALUES (7, 'Andromeda Moon 1', 2500, true);
INSERT INTO moon (planet_id, name, diameter_km, has_atmosphere) VALUES (7, 'Andromeda Moon 2', 1800, false);
INSERT INTO moon (planet_id, name, diameter_km, has_atmosphere) VALUES (8, 'Andromeda Moon 3', 5000, false);
INSERT INTO moon (planet_id, name, diameter_km, has_atmosphere) VALUES (9, 'Mirach Moon 1', 1500, true);
INSERT INTO moon (planet_id, name, diameter_km, has_atmosphere) VALUES (9, 'Mirach Moon 2', 1200, false);
INSERT INTO moon (planet_id, name, diameter_km, has_atmosphere) VALUES (10, 'Mirach Moon 3', 2000, true);
INSERT INTO moon (planet_id, name, diameter_km, has_atmosphere) VALUES (10, 'Mirach Moon 4', 1800, false);
INSERT INTO moon (planet_id, name, diameter_km, has_atmosphere) VALUES (11, 'Triangulum Moon 1', 2200, true);
INSERT INTO moon (planet_id, name, diameter_km, has_atmosphere) VALUES (11, 'Triangulum Moon 2', 1900, false);
INSERT INTO moon (planet_id, name, diameter_km, has_atmosphere) VALUES (12, 'Triangulum Moon 3', 2400, true);
INSERT INTO moon (planet_id, name, diameter_km, has_atmosphere) VALUES (12, 'Triangulum Moon 4', 2100, false);

-- Insertar datos en comet (3+ filas)
INSERT INTO comet (name, orbital_period, last_seen, is_periodic) VALUES ('Halley', 75, 2061, true);
INSERT INTO comet (name, orbital_period, last_seen, is_periodic) VALUES ('Hale-Bopp', 2533, 4385, true);
INSERT INTO comet (name, orbital_period, last_seen, is_periodic) VALUES ('Hyakutake', 17000, 2019, false);
