-- LIMPIA Y RECREA LA BASE (opcional pero recomendado durante desarrollo)
DROP DATABASE IF EXISTS salon;
CREATE DATABASE salon;

\c salon

-- TABLAS
CREATE TABLE IF NOT EXISTS customers (
  customer_id SERIAL PRIMARY KEY,
  phone VARCHAR NOT NULL UNIQUE,
  name  VARCHAR NOT NULL
);

CREATE TABLE IF NOT EXISTS services (
  service_id SERIAL PRIMARY KEY,
  name       VARCHAR NOT NULL
);

CREATE TABLE IF NOT EXISTS appointments (
  appointment_id SERIAL PRIMARY KEY,
  customer_id    INT NOT NULL REFERENCES customers(customer_id),
  service_id     INT NOT NULL REFERENCES services(service_id),
  time           VARCHAR NOT NULL
);

-- SEMILLA DE SERVICIOS (mínimo 3; el primero queda con service_id=1)
TRUNCATE services RESTART IDENTITY;
INSERT INTO services(name) VALUES
  ('cut'),
  ('color'),
  ('perm');
-- podés agregar más si querés:
-- INSERT INTO services(name) VALUES ('style'), ('trim');