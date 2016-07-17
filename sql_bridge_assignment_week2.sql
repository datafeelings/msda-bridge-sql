-- MSDA SQL Bridge Course 
-- Week 2 Assignment

/* 
1. Create one table to keep track of the videos. This table should include a unique ID, the title of the
video, the length in minutes, and the URL. Populate the table with at least three related videos from YouTube or
other publicly available resources.
*/

-- Create videos table

CREATE TABLE videos (
vid_id INT PRIMARY KEY,
length INT NOT NULL,
url TEXT(500)
);

-- Populate videos table

INSERT INTO videos
(vid_id, length, url)
VALUES
('1', '41', 'https://www.youtube.com/watch?v=yPu6qV5byu4'),
('2', '14', 'https://www.youtube.com/watch?v=mR7UA229uAQ'),
('3', '5', 'https://www.youtube.com/watch?v=G1OLrfjHDyw');

/* 
2. Create a second table that provides at least two user reviews for each of
at least two of the videos. These should be imaginary reviews that include columns for the user’s name
(“Asher”, “Cyd”, etc.), the rating (which could be NULL, or a number between 0 and 5), and a short text review
(“Loved it!”). There should be a column that links back to the ID column in the table of videos.
*/

-- Create reviews table

CREATE TABLE reviews (
user_id INT PRIMARY KEY,
username VARCHAR(45) NOT NULL,
rating ENUM ('0', '1', '2', '3', '4', '5'),
review TEXT(500),
vid_id INT NOT NULL
);

-- Populate reviews table

INSERT INTO reviews
(user_id, username, rating, review, vid_id)
VALUES
('1', 'Ash', '3', 'This video is OK', '1'),
('2', 'Boris', '5', 'Amazingly helpful!', '1'),
('3', 'Catherine', '4', 'Better than expected :)', '2'),
('4', 'Donnna', '1', 'Hated the voice', '2'),
('5', 'Ethan', '4', 'Good video', '3');

/* 
3. Report on Video Reviews. Write a JOIN statement that shows information from both tables.
*/

-- Join videos and reviews

SELECT * FROM videos v
JOIN reviews r
ON v.vid_id = r.vid_id;