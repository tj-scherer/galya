-- Create Database

DROP DATABASE IF EXISTS galya;
CREATE DATABASE IF NOT EXISTS galya;
USE galya;

-- Create Tables (Entity Sets)

CREATE TABLE Galleries(
	id INT PRIMARY KEY,
	title VARCHAR(100),
	description VARCHAR(500)
);

CREATE TABLE Artworks(
	id INT PRIMARY KEY,
	title VARCHAR(100),
	created DATE,
	source VARCHAR(500)
);

CREATE TABLE Visitors(
	id INT PRIMARY KEY,
	name VARCHAR(50)
);

CREATE TABLE Artists(
	id INT PRIMARY KEY,
	name VARCHAR(50)
);

CREATE TABLE Mediums(
	type VARCHAR(100) PRIMARY KEY,
	digital BOOLEAN
);

-- Create Tables (Entity Relationships)

CREATE TABLE FavoriteGallery(
	visitorId INT,
	galleryId INT,
	PRIMARY KEY(visitorId, galleryId)
);

CREATE TABLE FavoriteArtist(
	visitorId INT,
	artistId INT,
	PRIMARY KEY(visitorId, artistId)
);

CREATE TABLE FavoriteArtwork(
	visitorId INT,
	artworkId INT,
	PRIMARY KEY(visitorId, artworkId)
);

CREATE TABLE PreferredMedium(
	visitorId INT,
	mediumType VARCHAR(100),
	PRIMARY KEY(visitorId, mediumType)
);

CREATE TABLE FeaturedArtwork(
	galleryId INT,
	artworkId INT,
	PRIMARY KEY(galleryId, artworkId)
);

CREATE TABLE ManagesGallery(
	visitorId INT,
	galleryId INT,
	PRIMARY KEY(visitorId, galleryId)
);

CREATE TABLE IsArtist(
	visitorId INT,
	artistId INT,
	PRIMARY KEY(visitorId, artistId)
);

CREATE TABLE CreatedBy(
	artworkId INT,
	artistId INT,
	PRIMARY KEY(artworkId, artistId)
);

CREATE TABLE IsMedium(
	artworkId INT,
	mediumType VARCHAR(100),
	PRIMARY KEY(artworkId, mediumType)
);

-- Insert Sample Data (Entity Sets)

INSERT INTO Galleries VALUES
	-- (id, title, description),
	(0, 'My Gallery', 'This is a sample gallery to try some stuff out.'),
	(1, 'Best of Picasso', 'Contains the most significant works of Pablo Picasso.'),
	(2, 'Art Deco', 'Bringing you back to the 20s'),
	(3, 'Modern Art', 'Collection of the greatest pieces of our time.');

INSERT INTO Artworks VALUES
	-- (id, title, created, source),
	(0, 'SQL is Art', '2022-03-30', 'https://www.lifewire.com/thmb/BEHQk8ko0QaYhxWslUcHj5mXK5I=/1187x782/filters:fill(auto,1)/info-database-schema-5c6c1494c9e77c000119fc1c.jpg'),
	(1, 'Guernica', '1937-06-04', 'https://en.wikipedia.org/wiki/File:PicassoGuernica.jpg#/media/File:PicassoGuernica.jpg'),
	(2, 'The Weeping Woman', '1937-11-26', 'https://en.wikipedia.org/wiki/File:Picasso_The_Weeping_Woman_Tate_identifier_T05010_10.jpg#/media/File:Picasso_The_Weeping_Woman_Tate_identifier_T05010_10.jpg'),
	(3, 'Colony Hotel', '1935-07-14', 'https://blog.architizer.com/wp-content/uploads/colony-hotel-736-ocean-drive-miami-fl_9c5f5158-b4a3-4716-86f9-d6877667ae7a.jpeg'),
	(4, 'Cincinnati Union Terminal', '1933-03-31', 'https://67sgp1evrnz1qlsujt24kbps-wpengine.netdna-ssl.com/wp-content/uploads/2019/03/New_Image_2-1000px.jpg'),
	(5, 'Country Road in Province By Night', '1890-05-01', 'https://commons.wikimedia.org/wiki/File:Vincent_van_Gogh_-_Road_with_Cypress_and_Star_-_c._12-15_May_1890.jpg#/media/File:Vincent_van_Gogh_-_Road_with_Cypress_and_Star_-_c._12-15_May_1890.jpg'),
	(6, 'Courtesan', '1887-01-01', 'https://commons.wikimedia.org/wiki/File:Van_Gogh_-_la_courtisane.jpg#/media/File:Van_Gogh_-_la_courtisane.jpg');

INSERT INTO Visitors VALUES
	-- (id, name),
	(1000, 'TJ Scherer'),
	(1001, 'Richard Stansbury'),
	(1002, 'John Doe'),
	(1003, 'username');

INSERT INTO Artists VALUES
	-- (id, name),
	(0, 'unknown'),
	(1, 'anonymous'),
	(1000, 'TJ Scherer'),
	(1001, 'Pablo Picasso'),
	(1002, 'Salvador Dali'),
	(1003, 'Shakespeare'),
	(1004, 'Vincent Van Gogh');

INSERT INTO Mediums VALUES
	-- (type, digital),
	('tempera', false),
	('oil paint', false),
	('acrylic paint', false),
	('watercolor', false),
	('pastel', false),
	('chalk', false),
	('graphite pencil', false),
	('color pencil', false),
	('ink and pen', false),
	('architecture', false),
	('png', true),
	('jpg', true),
	('mp3', true),
	('mp4', true),
	('code', true);

-- Insert Sample Data (Entity Relationships)

INSERT INTO FavoriteGallery VALUES
	-- (visitorId, galleryId),
	(0, 0),
	(0, 2),
	(1, 0),
	(1, 1);

INSERT INTO FavoriteArtist VALUES
	-- (visitorId, artistId),
	(0, 2),
	(0, 3),
	(1, 0),
	(1, 2),
	(1, 3);

INSERT INTO FavoriteArtwork VALUES
	-- (visitorId, artworkId),
	(0, 1),
	(0, 3),
	(1, 0),
	(1, 2);

INSERT INTO PreferredMedium VALUES
	-- (visitorId, mediumType),
	(0, 'oil paint'),
	(0, 'ink and pen'),
	(1, 'code'),
	(1, 'watercolor');

INSERT INTO FeaturedArtwork VALUES
	-- (galleryId, artworkId),
	(0, 1),
	(0, 3),
	(0, 5),
	(1, 1),
	(1, 2),
	(2, 3),
	(2, 4),
	(3, 5),
	(3, 6);

INSERT INTO ManagesGallery VALUES
	-- (visitorId, galleryId),
	(0, 0),
	(0, 1),
	(0, 2),
	(0, 3);

INSERT INTO IsArtist VALUES
	-- (visitorId, artistId),
	(0, 1),
	(0, 4);

INSERT INTO CreatedBy VALUES
	-- (artworkId, artistId),
	(0, 1),
	(1, 2),
	(2, 2),
	(3, 0),
	(4, 0),
	(5, 5),
	(6, 5);

INSERT INTO IsMedium VALUES
	-- (artworkId, mediumType),
	(0, 'jpg'),
	(1, 'oil paint'),
	(2, 'oil paint'),
	(3, 'architecture'),
	(4, 'architecture'),
	(5, 'oil paint'),
	(6, 'oil paint');
