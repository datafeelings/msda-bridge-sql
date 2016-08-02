-- Create the schema and the table

DROP SCHEMA IF EXISTS employees;

CREATE SCHEMA `employees`; 

-- "hr" is the table for holding employee names, role descriptions,
-- and supervisors.
-- As the table only holds a direct subordinate-manager relationship 
-- for each employee, this structure can support any number of hierarchy
-- levels.


CREATE TABLE employees.hr (
  id int AUTO_INCREMENT PRIMARY KEY NOT NULL,
  emp_id int NOT NULL,
  emp_name varchar(30) NOT NULL,
  role varchar(30) NULL,
  manager_id int NULL
);

-- Populate the hr table.
-- It becomes obvious that this table structure introduces
-- unnecessary data duplication as soon as an employee has multiple
-- managers.

INSERT INTO employees.hr
(emp_id, emp_name, role, manager_id)
VALUES
(1,'Nima Živković','CEO', NULL),
(2,'Emerald Olsson','VP',1),
(3,'Ahmad Wruck','VP',1),
(4,'Ieremias Piontek','Manager',2),
(4,'Ieremias Piontek','Manager',3),
(5,'Abduweli Stawski','Manager',2),
(5,'Abduweli Stawski','Manager',3),
(6,'Pavla Stigsson','Assistant',1);


-- Query the names and employee relationships using a self join.
-- The resulting table shows a company hierarchy where the CEO
-- reports to nobody, two VPs report to the CEO, two managers 
-- report to both VPs, and the assistant reports to the CEO.


SELECT hr1.emp_name AS 'Employee', hr1.role AS 'Role', hr2.emp_name AS 'Manager'
FROM employees.hr hr1
LEFT JOIN
employees.hr hr2 -- self join the same table on manager id
ON hr1.manager_id = hr2.emp_id
ORDER BY hr1.emp_id;