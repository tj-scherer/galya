-- 2.3.1
-- Users shall query the database to explore new works of art or search for works which meet the criteria set by the user. The result will be a list of all works of art, artists, or galleries requested by the user, displayed in the user interface with a preview of each work of art.
SELECT *
FROM Artworks, CreatedBy, Artists
WHERE Artworks.id = CreatedBy.artworkId
	AND CreatedBy.artistId = Artists.id
	AND INSTR(Artworks.title, 'Guernica') > 0
	AND INSTR(Artists.name, 'Dali') > 0;
;
-- 2.3.2
-- Artists shall create an identity for themselves which allows users to view their works of art.
INSERT INTO Artists
VALUES (2000, 'New Artist Name');

SELECT *
FROM Artists;

-- 2.3.3
-- Artists shall enter information about their work of art to be shared with all users. The result will be an addition to the list of all available works of art.
INSERT INTO Artworks
VALUES (2000, 'Artist Artwork Title', '2022-04-18', 'https://www.website.com/image.png', false);

SELECT *
FROM Artworks;

INSERT INTO CreatedBy
VALUES (2000, 2000);

SELECT *
FROM CreatedBy;

-- 2.3.4
-- Historians shall perform the same duty as artists by proxy, detailing historical artists and uploading their works of art. The result will be an addition to the list of all available works of art.
INSERT INTO Artworks
VALUES (2001, 'Historian Artwork Title', '2022-04-18', 'https://www.website.com/image.png', false);

SELECT *
FROM Artworks;

INSERT INTO CreatedBy
VALUES (2001, 1000);

SELECT *
FROM CreatedBy;

-- 2.3.5
-- Gallery owners shall create galleries, real or virtual, which are curated to their liking, and may be updated as the contents of the gallery change. Once a gallery is created and approved, it will be searchable and viewable from the user interface.
INSERT INTO Galleries
VALUES (2000, 'New Gallery Title', 'New Gallery Description');

SELECT *
FROM Galleries;

INSERT INTO FeaturedArtwork
VALUES (2000, 1001), (2000, 1003), (2000, 1005);

SELECT *
FROM FeaturedArtwork
WHERE galleryId = 2000;

-- 2.3.6
-- Moderators shall enforce the rules and prevent unauthorized content from being visible to the end user. There will be an approval process, where the moderator may view a submission and must then approve or deny it. Approvals are published to the public database, whereas denials are temporarily held for corrections by the artist or historian.
INSERT INTO Artworks
VALUES (3000, 'Moderator Artwork Title', '2022-04-18', 'https://www.website.com/image.png', false);

SELECT *
FROM Artworks
WHERE approved;

UPDATE Artworks
SET approved = true
WHERE id = 3000;

SELECT *
FROM Artworks
WHERE approved;