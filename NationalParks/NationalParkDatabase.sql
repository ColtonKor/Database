DROP DATABASE IF EXISTS NationalPark; 
CREATE DATABASE NationalPark;
USE NationalPark;

CREATE TABLE contact_information (
  contact_id INT NOT NULL PRIMARY KEY,
  phone_number VARCHAR(10),
  fax_number VARCHAR(10),
  email VARCHAR(64),
  park_ranger_number VARCHAR(10),
  TTY_number VARCHAR(10)
);

CREATE TABLE map (
  map_id INT NOT NULL PRIMARY KEY,
  size VARCHAR(64) NOT NULL,
  image BLOB,
  coordinates VARCHAR(64) NOT NULL
);

CREATE TABLE national_park (
  national_park_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(64),
  city VARCHAR(64),
  state VARCHAR(64),
  country VARCHAR(64),
  environment VARCHAR(64),
  contact_id INT NOT NULL,
  map_id INT NOT NULL,
  FOREIGN KEY (contact_id) REFERENCES contact_information(contact_id),
  FOREIGN KEY (map_id) REFERENCES map(map_id)
);

CREATE TABLE animal (
  animal_id INT NOT NULL AUTO_INCREMENT,
  national_park_id INT NOT NULL,
  species VARCHAR(64),
  population VARCHAR(8),
  occurences INT,
  PRIMARY KEY (animal_id, national_park_id),
  FOREIGN KEY (national_park_id) REFERENCES national_park(national_park_id)
);

CREATE TABLE amenity (
  amenity_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  type VARCHAR(64)
);

CREATE TABLE activity (
  activity_id INT NOT NULL AUTO_INCREMENT,
  national_park_id INT NOT NULL,
  type VARCHAR(64) NOT NULL,
  length VARCHAR(64),
  map_id INT NOT NULL,
  amenity_id INT,
  PRIMARY KEY (activity_id, national_park_id),
  FOREIGN KEY (national_park_id) REFERENCES national_park(national_park_id),
  FOREIGN KEY (map_id) REFERENCES map(map_id),
  FOREIGN KEY (amenity_id) REFERENCES amenity(amenity_id)
);

CREATE TABLE attraction (
  attraction_id INT NOT NULL AUTO_INCREMENT,
  national_park_id INT NOT NULL,
  type VARCHAR(64) NOT NULL,
  history VARCHAR(512),
  map_id INT NOT NULL,
  amenity_id INT,
  PRIMARY KEY (attraction_id, national_park_id),
  FOREIGN KEY (national_park_id) REFERENCES national_park(national_park_id),
  FOREIGN KEY (map_id) REFERENCES map(map_id),
  FOREIGN KEY (amenity_id) REFERENCES amenity(amenity_id)
);

CREATE TABLE visitor_center (
  visitor_center_id INT NOT NULL,
  national_park_id INT NOT NULL,
  contact_id INT NOT NULL,
  map_id INT NOT NULL,
  amenity_id INT,
  information VARCHAR(256),
  PRIMARY KEY (visitor_center_id, national_park_id),
  FOREIGN KEY (contact_id) REFERENCES contact_information(contact_id),
  FOREIGN KEY (national_park_id) REFERENCES national_park(national_park_id),
  FOREIGN KEY (map_id) REFERENCES map(map_id),
  FOREIGN KEY (amenity_id) REFERENCES amenity(amenity_id)
);

CREATE TABLE fee (
  fee_id INT NOT NULL AUTO_INCREMENT,
  national_park_id INT NOT NULL,
  type VARCHAR(64) NOT NULL,
  amount VARCHAR(64) NOT NULL,
  PRIMARY KEY (fee_id, national_park_id),
  FOREIGN KEY (national_park_id) REFERENCES national_park(national_park_id)
);

CREATE TABLE campground (
  campground_id INT NOT NULL AUTO_INCREMENT,
  national_park_id INT NOT NULL,
  name VARCHAR(64),
  campground_number VARCHAR(16),
  type VARCHAR(45),
  map_id INT NOT NULL,
  amenity_id INT,
  PRIMARY KEY (campground_id, national_park_id),
  FOREIGN KEY (map_id) REFERENCES map(map_id),
  FOREIGN KEY (national_park_id) REFERENCES national_park(national_park_id),
  FOREIGN KEY (amenity_id) REFERENCES amenity(amenity_id)
);

CREATE TABLE trail (
  trail_id INT NOT NULL AUTO_INCREMENT,
  national_park_id INT NOT NULL,
  name VARCHAR(64),
  difficulty VARCHAR(64),
  incline VARCHAR(64),
  type VARCHAR(64) NOT NULL,
  map_id INT NOT NULL,
  amenity_id INT,
  PRIMARY KEY (trail_id, national_park_id),
  FOREIGN KEY (map_id) REFERENCES map(map_id),
  FOREIGN KEY (national_park_id) REFERENCES national_park(national_park_id),
  FOREIGN KEY (amenity_id) REFERENCES amenity(amenity_id)
);

-- Insert data into contact_information
INSERT INTO contact_information (contact_id, phone_number, fax_number, email, park_ranger_number, TTY_number)
VALUES
(1, '5551234567', '5559876543', 'info@yellowstone.org', '5553456789', '5556789012'),
(2, '5552233445', '5556677889', 'info@grandcanyon.org', '5551122334', '5555566778'),
(3, '5553334444', '5554443333', 'info@zionpark.org', '5556667777', '5557778888'),
(4, '5558889999', '5559998888', 'info@rockymountains.org', '5550001111', '5551110000');

-- Insert data into map
INSERT INTO map (map_id, size, image, coordinates)
VALUES
(1, 'Large', NULL, '44.4280° N, 110.5885° W'),
(2, 'Medium', NULL, '36.0544° N, 112.1401° W'),
(3, 'Medium', NULL, '37.2982° N, 113.0263° W'),
(4, 'Large', NULL, '40.3428° N, 105.6836° W');

-- Insert data into national_park
INSERT INTO national_park (national_park_id, name, city, state, country, environment, contact_id, map_id)
VALUES
(1, 'Yellowstone', 'Yellowstone', 'Wyoming', 'USA', 'Forest', 1, 1),
(2, 'Grand Canyon', 'Grand Canyon Village', 'Arizona', 'USA', 'Desert', 2, 2),
(3, 'Zion National Park', 'Springdale', 'Utah', 'USA', 'Desert', 3, 3),
(4, 'Rocky Mountain National Park', 'Estes Park', 'Wyoming', 'USA', 'Mountain', 4, 4);

-- Insert data into animal
INSERT INTO animal (animal_id, national_park_id, species, population, occurences)
VALUES
(1, 1, 'Bison', '4000', 50),
(2, 1, 'Grizzly Bear', '500', 20),
(3, 2, 'Condor', '200', 15),
(4, 3, 'Desert Tortoise', '1000', 30),
(5, 3, 'Mountain Lion', '50', 10),
(6, 4, 'Elk', '3000', 40),
(7, 4, 'Black Bear', '150', 25);

-- Insert data into amenity
INSERT INTO amenity (amenity_id, type)
VALUES
(1, 'Restroom'),
(2, 'Picnic Area'),
(3, 'Campground'),
(4, 'Parking Lot'),
(5, 'Gift Shop');

-- Insert data into activity
INSERT INTO activity (activity_id, national_park_id, type, length, map_id, amenity_id)
VALUES
(1, 1, 'Hiking', '10 miles', 1, 2),
(2, 2, 'Rafting', '5 miles', 2, 3),
(3, 3, 'Rock Climbing', '2 miles', 3, 4),
(4, 4, 'Wildlife Watching', '1 mile', 4, 5),
(5, 4, 'Snowshoeing', '3 miles', 4, 5);

-- Insert data into attraction
INSERT INTO attraction (attraction_id, national_park_id, type, history, map_id, amenity_id)
VALUES
(1, 1, 'Old Faithful', 'Geyser that erupts regularly', 1, NULL),
(2, 2, 'Bright Angel Trail', 'Historic hiking trail', 2, NULL),
(3, 3, 'Angels Landing', 'Famous hiking trail with stunning views', 3, 4),
(4, 4, 'Trail Ridge Road', 'Scenic drive across the Continental Divide', 4, 5),
(5, 3, 'The Narrows', 'Slot canyon perfect for wading hikes', 3, 5);

-- Insert data into visitor_center
INSERT INTO visitor_center (visitor_center_id, national_park_id, contact_id, map_id, amenity_id, information)
VALUES
(1, 1, 1, 1, 1, 'Yellowstone Visitor Center'),
(2, 2, 2, 2, 2, 'Grand Canyon Visitor Center'),
(3, 3, 3, 3, 4, 'Zion Canyon Visitor Center'),
(4, 4, 4, 4, 4, 'Beaver Meadows Visitor Center');

-- Insert data into fee
INSERT INTO fee (fee_id, national_park_id, type, amount)
VALUES
(1, 1, 'Entrance Fee', '35.00'),
(2, 2, 'Camping Fee', '25.00'),
(3, 3, 'Shuttle Fee', '15.00'),
(4, 4, 'Entrance Fee', '25.00'),
(5, 4, 'Backcountry Permit', '10.00');

-- Insert data into campground
INSERT INTO campground (campground_id, national_park_id, name, campground_number, type, map_id, amenity_id)
VALUES
(1, 1, 'Madison Campground', 'C1', 'Tent', 1, 3),
(2, 2, 'Mather Campground', 'C2', 'RV', 2, 3),
(3, 3, 'Watchman Campground', 'C3', 'Tent', 3, 4),
(4, 4, 'Moraine Park Campground', 'C4', 'RV', 4, 5);

-- Insert data into trail
INSERT INTO trail (trail_id, national_park_id, name, difficulty, incline, type, map_id, amenity_id)
VALUES
(1, 1, 'Mountains Deep', 'Moderate', 'Steep', 'Loop', 1, 2),
(2, 2, 'River Abode', 'Easy', 'Flat', 'Out-and-Back', 2, 1),
(3, 3, 'Tango Rumble', 'Challenging', 'Steep', 'Out-and-Back', 3, 5),
(4, 4, 'The Movie Rango', 'Easy', 'Gentle', 'Loop', 4, 5);


-- Query #1
SELECT
	n.name, n.city, n.state, n.country, n.environment, an.species, an.population, an.occurences, a.type, a.history
FROM
	national_park AS n
	INNER JOIN animal AS an USING (national_park_id)
    LEFT JOIN attraction AS a ON (a.national_park_id = n.national_park_id)
ORDER BY
	n.name;
    
    
-- Query #2
SELECT 
    np.name, t.name AS trail_name, t.type AS trail_type, t.difficulty, t.incline, am.type AS trail_amenity, c.name AS campground_name, c.type AS campground_type, a.type AS campground_amenity
FROM 
    national_park AS np
	LEFT JOIN trail AS t USING (national_park_id)
	LEFT JOIN campground AS c USING (national_park_id)
    LEFT JOIN amenity AS a ON c.amenity_id = a.amenity_id
    LEFT JOIN amenity AS am ON t.amenity_id = am.amenity_id
WHERE 
    np.national_park_id IN 
    (SELECT 
		national_park_id 
	 FROM 
		national_park 
	 WHERE 
		state = 'Wyoming');
        
-- Query #3
SELECT
	*
FROM
	activity
WHERE
	length IS NOT NULL;
    
    
-- Query #4
SELECT
	np.name, np.environment, COUNT(DISTINCT ac.activity_id) AS Activities, COUNT(DISTINCT an.animal_id) AS Animals, COUNT(DISTINCT att.attraction_id) AS Attractions, COUNT(DISTINCT c.campground_id) AS Campgrounds, COUNT(DISTINCT t.trail_id) AS Trails
FROM
	national_park AS np
    LEFT JOIN activity AS ac USING (national_park_id)
    LEFT JOIN animal AS an USING (national_park_id)
    LEFT JOIN attraction AS att USING (national_park_id)
    LEFT JOIN campground AS c USING (national_park_id)
    LEFT JOIN trail AS t USING (national_park_id)
GROUP BY
	np.national_park_id
HAVING
    np.environment = 'Desert';
    
-- Query #5
SELECT
	np.name, animal.species, animal.population
FROM
	animal
	LEFT JOIN national_park AS np USING (national_park_id)
WHERE
	population BETWEEN 1000 AND 5000;
