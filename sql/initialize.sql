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
	source VARCHAR(500),
	approved BOOLEAN
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
	(1000, 'My Gallery', 'This is a sample gallery to try some stuff out.'),
	(1001, 'Best of Picasso', 'Contains the most significant works of Pablo Picasso.'),
	(1002, 'Art Deco', 'Bringing you back to the 20s'),
	(1003, 'Modern Art', 'Collection of the greatest pieces of our time.');

INSERT INTO Artworks VALUES
	-- (id, title, created, source),
	(1000, 'SQL is Art', '2022-03-30', 'https://www.lifewire.com/thmb/BEHQk8ko0QaYhxWslUcHj5mXK5I=/1187x782/filters:fill(auto,1)/info-database-schema-5c6c1494c9e77c000119fc1c.jpg', true),
	(1001, 'Guernica', '1937-06-04', 'https://upload.wikimedia.org/wikipedia/en/7/74/PicassoGuernica.jpg', true),
	(1002, 'The Weeping Woman', '1937-11-26', 'https://upload.wikimedia.org/wikipedia/en/1/14/Picasso_The_Weeping_Woman_Tate_identifier_T05010_10.jpg', true),
	(1003, 'Colony Hotel', '1935-07-14', 'https://blog.architizer.com/wp-content/uploads/colony-hotel-736-ocean-drive-miami-fl_9c5f5158-b4a3-4716-86f9-d6877667ae7a.jpeg', true),
	(1004, 'Cincinnati Union Terminal', '1933-03-31', 'https://67sgp1evrnz1qlsujt24kbps-wpengine.netdna-ssl.com/wp-content/uploads/2019/03/New_Image_2-1000px.jpg', true),
	(1005, 'Country Road in Province By Night', '1890-05-01', 'https://krollermuller.nl/media/cache/collection_item_detail_small/media/collectionitempage/tmsImage/landweg-in-de-provence-bij-nacht-vincent-van-gogh-44552-copyright-kroller-muller-museum.jpg', true),
	(1006, 'Courtesan', '1887-01-01', 'https://lh4.ggpht.com/2_qrfYPkO74k8GZFFLOQ_Ab4XQI2xN8GOw4ur4WA7TlO8P83oZESCd0vAj-VxA=s1200', true);

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
	(1000, 1000),
	(1000, 1002),
	(1001, 1000),
	(1001, 1001);

INSERT INTO FavoriteArtist VALUES
	-- (visitorId, artistId),
	(1000, 1002),
	(1000, 1003),
	(1001, 1000),
	(1001, 1002),
	(1001, 1003);

INSERT INTO FavoriteArtwork VALUES
	-- (visitorId, artworkId),
	(1000, 1001),
	(1000, 1003),
	(1001, 1000),
	(1001, 1002);

INSERT INTO PreferredMedium VALUES
	-- (visitorId, mediumType),
	(1000, 'oil paint'),
	(1000, 'ink and pen'),
	(1001, 'code'),
	(1001, 'watercolor');

INSERT INTO FeaturedArtwork VALUES
	-- (galleryId, artworkId),
	(1000, 1001),
	(1000, 1003),
	(1000, 1005),
	(1001, 1001),
	(1001, 1002),
	(1002, 1003),
	(1002, 1004),
	(1003, 1005),
	(1003, 1006);

INSERT INTO ManagesGallery VALUES
	-- (visitorId, galleryId),
	(1000, 1000),
	(1000, 1001),
	(1000, 1002),
	(1000, 1003);

INSERT INTO IsArtist VALUES
	-- (visitorId, artistId),
	(1000, 1000),
	(1000, 1003);

INSERT INTO CreatedBy VALUES
	-- (artworkId, artistId),
	(1000, 1001),
	(1001, 1002),
	(1002, 1002),
	(1003, 1000),
	(1004, 1000),
	(1005, 1005),
	(1006, 1005);

INSERT INTO IsMedium VALUES
	-- (artworkId, mediumType),
	(1000, 'jpg'),
	(1001, 'oil paint'),
	(1002, 'oil paint'),
	(1003, 'architecture'),
	(1004, 'architecture'),
	(1005, 'oil paint'),
	(1006, 'oil paint');
