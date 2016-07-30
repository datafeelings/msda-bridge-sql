-- Create the schema and tables

DROP SCHEMA IF EXISTS employees;

CREATE SCHEMA `employees`; 

-- "hr" is the table for holding employee names and role descriptions:
-- If only employee supervisor name changes, this table
-- does not have to be updated. 

-- DROP TABLE IF EXISTS employees.hr;

CREATE TABLE employees.hr (
  emp_id int AUTO_INCREMENT PRIMARY KEY NOT NULL,
  emp_name varchar(30) NOT NULL,
  role varchar(30) NULL
);

-- Populate the hr table

INSERT INTO employees.hr
(emp_name,role)
VALUES
('Nima Živković', 'CEO'),
('Emerald Olsson', 'VP'),
('Ahmad Wruck', "VP"),
('Ieremias Piontek', 'Manager'),
('Abduweli Stawski', 'Manager'),
('Pavla Stigsson', 'Assistant');


-- "org" is the table for holding hierarchy relationships:
-- To avoid duplicate data and update/delete anomalies, 
-- only employee id and manager id will be stored here.
-- In this way, if employee role or name changes without the impact on 
-- the supervisor, this table does not have to be updated.

-- DROP TABLE IF EXISTS employees.org;
CREATE TABLE employees.org (
  ID int AUTO_INCREMENT PRIMARY KEY,
  emp_id int NOT NULL,
  manager_id int NULL
);

-- Populate the org table

INSERT INTO employees.org
(emp_id,manager_id)
VALUES
(1, NULL),
(2, 1),
(3, 1),
(4, 2),
(4, 3),
(5, 2),
(5, 3),
(6, 1);

-- Query the names and relationships

SELECT all1.emp_name AS 'Employee', all1.role AS 'Role', all2.emp_name AS 'Manager'
FROM
	(SELECT org.emp_id, org.manager_id, hr.emp_name, hr.role
	FROM employees.org org
	LEFT JOIN employees.hr hr
	ON org.emp_id = hr.emp_id) all1 -- table with names and relationships
LEFT JOIN
	(SELECT org.emp_id, org.manager_id, hr.emp_name, hr.role
	FROM employees.org org
	LEFT JOIN employees.hr hr
	ON org.emp_id = hr.emp_id) all2 -- same table as all1 used to look up manager names
ON all1.manager_id = all2.emp_id;