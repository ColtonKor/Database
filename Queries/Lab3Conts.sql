drop database IF EXISTS actordb;
create database IF NOT EXISTS actordb;
use actordb;

-- Lab 3
-- Create a table actor, with fields
-- ID integer primary key
-- name varchar(30)
-- birthyear int with check constraint that year must be greater than 1900
CREATE TABLE IF NOT EXISTS actor
(
	ID int,
    name varchar(30),
    birthyear int CHECK( birthyear > 1900),
    PRIMARY KEY (ID)
);

-- 1. Try to insert actor Simon Pegg (born 1970) twice. Use an ID value of 1 both times.
INSERT INTO actor
	(ID, name, birthyear)
VALUES
	(1, 'Simon Pegg', 1970),
    (1, 'Simon Pegg', 1970);
-- What constraint is violated?
-- ID primary key is being violated.
--
-- 2. Try to insert an actor into the actor table with ID 3, name 'Neil Old', and birthyear 1754.
insert into actor
	(ID, name, birthyear)
values
	(3, 'Neil Old', 1754);
-- What constraint is violated?
-- The year of the movie is way to old it can't fit into the Check
-- 3. Create another table 'movie', with fields
-- title varchar(30)
-- yearMovie integer check that yearMovie is greater than 1880
-- director varchar(30)
-- Define the primary key to be the attributes title and yearMovie.
CREATE TABLE IF NOT EXISTS movie
(
	title varchar(30),
    yearMovie int check(yearMovie > 1880),
    director varchar(30),
    PRIMARY KEY (title, yearMovie)
);
-- 4. Insert a movie into the movie table, with title 'Paul', year 2011, and director 'Greg Mottola’.
insert into movie
	(title, yearMovie, director)
values
	('Paul', 2011, 'Greg Mottola');
-- What constraint is violated?
-- Movie > 1880 constraint is being violated
-- 5. Create another table 'appears’ with fields
-- actor_ID integer
-- title varchar(30)
-- yearMovie integer
-- Add two constraints so that the actor_ID is the ID of an actor in the actor
-- and title, yearMovie identify a movie in the movie table.
-- The primary key should be the attributes actor_ID, title, yearMovie.
CREATE TABLE IF NOT EXISTS appears
(
	actor_ID integer,
    title varchar(30),
    yearMovie integer,
    FOREIGN KEY (actor_ID) REFERENCES actor(actor_ID),
    FOREIGN KEY (title, yearMovie) REFERENCES movie(title, yearMovie),
    PRIMARY KEY (actor_ID, title, yearMovie)
);
-- 6. Insert a row into the 'appears' table with actor_ID = 1, title = 'Paul', and year = 2010 (NOT 2011).
insert into appears
	(actor_ID, title, yearMovie)
values
	(1, 'Paul', 2010);

-- What constraint is violated?
-- In Movie there is already a movie called Paul so it can't work.
