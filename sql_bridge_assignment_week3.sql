-- Create the schema and tables

DROP SCHEMA IF EXISTS rooms;
CREATE SCHEMA `rooms`; 



CREATE TABLE rooms.groups (
  group_id int NOT NULL PRIMARY KEY,
  gname varchar(45) NOT NULL
);

CREATE TABLE rooms.users (
  user_id int NOT NULL PRIMARY KEY,
  uname varchar(45) NOT NULL,
  group_id int
);

CREATE TABLE rooms.rooms (
  room_id int NOT NULL PRIMARY KEY,
  rname varchar(45) NOT NULL
);

CREATE TABLE rooms.groupsRooms (
  group_id int NOT NULL REFERENCES groups(group_id),
  room_id int NOT NULL REFERENCES rooms(room_id),
  CONSTRAINT pk_group_room PRIMARY KEY (group_id, room_id)
);

-- Populate the tables according to the assignment

INSERT INTO rooms.groups
(group_id, gname)
VALUES
(1, 'I.T.'),
(2, 'Sales'),
(3, 'Administration'),
(4, 'Operations');

INSERT INTO rooms.users
(user_id, uname, group_id)
VALUES
(1, 'Christopher', 2),
(2, 'Cheong woo', 2),
(3, 'Saulat',3),
(4, 'Modesto', 1),
(5, 'Ayine', 1),
(6, 'Heidy',NULL);

INSERT INTO rooms.rooms
(room_id, rname)
VALUES
(1, '101'),
(2, '102'),
(3, 'Auditorium A'),
(4, 'Auditorium B');

INSERT INTO rooms.groupsRooms
(group_id, room_id)
VALUES
(1, 1),
(1, 2),
(2, 2),
(2, 3);

-- Run the queries from the assignment

-- All groups, and the users in each group. A group should appear even if there are no users assigned to the group.

SELECT groups.gname as 'Group', users.uname as 'User'
from rooms.groups groups
LEFT JOIN rooms.users users
ON groups.group_id = users.group_id;

-- All rooms, and the groups assigned to each room. The rooms should appear even if no groups have been
-- assigned to them

SELECT rooms.rname AS 'Room', groups.gname AS 'Group'
FROM rooms.rooms rooms
LEFT JOIN rooms.groupsrooms groupsrooms
ON rooms.room_id = groupsrooms.room_id
LEFT JOIN rooms.groups groups
ON groupsrooms.group_id = groups.group_id;

-- A list of users, the groups that they belong to, and the rooms to which they are assigned. This should be sorted
-- alphabetically by user, then by group, then by room.

SELECT u.uname AS 'User', g.gname AS 'Group', r.rname AS 'Room'
FROM rooms.users u
LEFT JOIN rooms.groups g
ON u.group_id = g.group_id
LEFT JOIN rooms.groupsrooms gr
ON g.group_id = gr.group_id
LEFT JOIN rooms.rooms r
ON gr.room_id = r.room_id

ORDER BY u.uname, g.gname, r.rname;