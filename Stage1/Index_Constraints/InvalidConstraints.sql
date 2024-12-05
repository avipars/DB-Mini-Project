-- TODO CHANGE THIS (OLD) -- add UPDATE AND DELEETES

-- Test input of invalid constraints which should cause an error

-- Negative book quantity
INSERT INTO Location (Quantity, Floor, Shelf, Location_ID, Condition, ID) VALUES (-1, 'History Section', 85, 70000, 'New', 62819);
-- Negative shelf number
INSERT INTO Location (Quantity, Floor, Shelf, Location_ID, Condition, ID) VALUES (27, 'Adult Section', -52, 70001, 'New', 43003);
-- Negative page count
INSERT INTO Book (Title, ID, Release_Date, Page_Count, Format, Description, ISBN) VALUES('Police ', 5000010, '1884-05-21', -39, 'Magazine', 'Market', 322397558);
-- Duplicate ISBN
INSERT INTO Book (Title, ID, Release_Date, Page_Count, Format, Description, ISBN) VALUES('Police ', 5000010, '1884-05-21', 39, 'Magazine', 'Market', 322397088);
-- Future release date
INSERT INTO Book (Title, ID, Release_Date, Page_Count, Format, Description, ISBN) VALUES('Police ', 5000011, '2025-05-21', 39, 'Magazine', 'Market', 322398088);
-- Non-existent publisher
INSERT INTO Published_By (ID, Publisher_ID) VALUES (66925, 38816);
-- Future DOB
INSERT INTO Author (First_Name,Last_Name,Date_of_Birth, Author_ID, Biography) VALUES ('J.R.R.', ' Tolkien', '2037-01-03', 123456789, 'Best author ever');
-- Non-existent author
INSERT INTO Written_By (ID, Author_ID) VALUES (1, 818352457);


-- These test should not work
-- Update invalid constraints
-- Negative book quantity
UPDATE Location SET Quantity = -27 WHERE Location_ID = 1;
-- Negative shelf number
UPDATE Location SET Shelf = -27 WHERE Location_ID = 1;
-- Duplicate ISBN
UPDATE Book SET ISBN = 172100001 WHERE ID = 3;
-- Update in written_by a null author
UPDATE Written_By SET Author_ID = NULL WHERE Author_ID = 465532191;
-- Update in written_by a non-existent author
UPDATE Written_By SET Author_ID = 123456789 WHERE Author_ID = 465532191;
-- Update in type_of a non-existent genre
UPDATE Type_of SET Genre_ID = 123456789 WHERE Genre_ID = 465532191;
-- Update in Publisher a not unique phone number
UPDATE Publisher SET Phone_Number = '123456789' WHERE Publisher_ID = 1;


-- Delete invalid constraints
-- delete country that is in use
DELETE FROM Country WHERE Country_ID = 23;
-- delete author that is in use
DELETE FROM Author WHERE Author_ID =756070228;
-- delete genre that is in use
DELETE FROM Genre WHERE Genre_ID = 1;
-- delete publisher that is in use
DELETE FROM Publisher WHERE Publisher_ID = 1;
-- delete language that is in use
DELETE FROM Language WHERE Language_ID = 1;
-- delete location that is in use
DELETE FROM Location WHERE Location_ID = 1;
-- delete book that is in use
DELETE FROM Book WHERE ID = 1;
