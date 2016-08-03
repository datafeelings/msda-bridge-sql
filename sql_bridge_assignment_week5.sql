-- Create the schema and the table

DROP SCHEMA IF EXISTS BuildingEnergy;

CREATE SCHEMA `BuildingEnergy`; 

-- Create and populate the table for energy categories

CREATE TABLE BuildingEnergy.EnergyCategories (
  category_id int AUTO_INCREMENT PRIMARY KEY NOT NULL,
  energycategory varchar(30) NOT NULL
);

INSERT INTO BuildingEnergy.EnergyCategories
(energycategory)
VALUES
('Fossil'),
('Renewable');

-- Create and populate the table for energy types

CREATE TABLE BuildingEnergy.EnergyTypes (
  type_id int AUTO_INCREMENT PRIMARY KEY NOT NULL,
  energytype varchar(30) NOT NULL,
  category_id INT,
  FOREIGN KEY (category_id) REFERENCES BuildingEnergy.EnergyCategories(category_id)
);

INSERT INTO BuildingEnergy.EnergyTypes
(energytype, category_id)
VALUES
('Electricity', 1),
('Fuel Oil', 1),
('Gas', 1),
('Solar', 2),
('Steam', 1),
('Wind', 2);

-- Join the tables to test the matching of categories to the types

SELECT ec.energycategory, et.energytype
FROM buildingenergy.energytypes et
LEFT JOIN buildingenergy.energycategories ec
ON et.category_id = ec.category_id
ORDER BY et.type_id;

-- Create and populate the buildings table

CREATE TABLE BuildingEnergy.Buildings(
  build_id int AUTO_INCREMENT PRIMARY KEY NOT NULL,
  build_name varchar(60) NOT NULL
);

INSERT INTO BuildingEnergy.Buildings
(build_name)
VALUES
('Empire State Building'),
('Chrysler Building'),
('Borough of Manhattan Community College');


-- Create & populate the table to track many-to-many relationships between buildings and types

CREATE TABLE BuildingEnergy.BuildingsEnergyTypes (
  build_id int NOT NULL REFERENCES BuildingEnergy.buildings(build_id),
  type_id int NOT NULL REFERENCES BuildingEnergy.energytypes(type_id),
  CONSTRAINT pk_build_type PRIMARY KEY (build_id, type_id)
);

INSERT INTO BuildingEnergy.BuildingsEnergyTypes
(build_id, type_id)
VALUES
(1, 1),
(1, 3),
(1, 5),
(2, 1),
(2, 5),
(3, 1),
(3, 4),
(3, 5);

-- Write a JOIN statement that shows the buildings and associated energy types for each building.

SELECT b.build_name, e.energytype
FROM buildingenergy.buildings b
JOIN buildingenergy.buildingsenergytypes be
ON b.build_id = be.build_id
JOIN buildingenergy.energytypes e
ON be.type_id = e.type_id
ORDER BY b.build_name;

-- Update the BuildingEnergy database with the data for new buildings and energy types

-- Insert buildings

INSERT INTO BuildingEnergy.Buildings
(build_name)
VALUES
('Bronx Lion House'),
('Brooklyn Childrens Museum');	

-- Insert energy types

INSERT INTO BuildingEnergy.EnergyTypes
(energytype, category_id)
VALUES
('Geothermal', 2);

-- Insert new relationships

INSERT INTO BuildingEnergy.BuildingsEnergyTypes
(build_id, type_id)
VALUES
(4, 7),
(5, 1),
(5, 7);

-- Write a SQL query that displays all of the buildings that use Renewable Energies

SELECT b.build_name, e.energytype, c.energycategory
FROM buildingenergy.buildings b
JOIN buildingenergy.buildingsenergytypes be
ON b.build_id = be.build_id
JOIN buildingenergy.energytypes e
ON be.type_id = e.type_id
JOIN  buildingenergy.energycategories c
ON e.category_id = c.category_id
WHERE c.category_id = 2
ORDER BY b.build_name;

--  Write a SQL query that shows the frequency with which energy types are used in various buildings

SELECT e.energytype, count(be.type_id) AS 'count'
FROM buildingenergy.buildingsenergytypes be
JOIN buildingenergy.energytypes e
ON be.type_id = e.type_id
GROUP BY e.energytype
ORDER BY count(be.type_id) DESC;