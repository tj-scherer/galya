-- INSERT INTO <table>
-- VALUES (val_1, val_2, ... , val_n);
INSERT INTO Visitors
VALUES (1337, 'INSERT User');

-- SELECT <columns>
-- FROM <table>
-- WHERE <condition>
SELECT *
FROM Visitors
WHERE id > 1000;

-- UPDATE <table>
-- SET <column> = val_1, <column> = val_2, ... , <column> = val_n
-- WHERE <condition>
UPDATE Visitors
SET name = 'UPDATE User'
WHERE id = 1337;

-- DELETE FROM <table>
-- WHERE <condition>
DELETE FROM Visitors
WHERE id = 1337;
