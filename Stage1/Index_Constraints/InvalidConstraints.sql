-- TODO CHANGE THIS (OLD) -- add UPDATE AND DELEETES

-- Test input of invalid constraints which should cause an error

-- Negative book quantity
INSERT INTO Location (Quantity, Floor, Shelf, Location_ID, Condition, ID) VALUES (-1, 'History Section', 85, 70000, 'New', 62819);
-- Negative shelf number
INSERT INTO Location (Quantity, Floor, Shelf, Location_ID, Condition, ID) VALUES (27, 'Adult Section', -52, 70001, 'New', 43003);
-- Negative page count
INSERT INTO Book (Title,ID , ISBN, Page_Count, Release_Date) VALUES ('The Hobbit',100000, 123456789, -310, '1937-09-21');
-- Duplicate ISBN
INSERT INTO Book (Title, ID, Release_Date, Page_Count, Format, Description, ISBN) VALUES ('The Hobbit', 999990,  '1937-09-21', 5,'Journal','An epic journal',869427396);
-- Future release date
INSERT INTO Book (ID, Title, ISBN, Page_Count, Release_Date) VALUES (1, 'The Hobbit', '123456789', 310, '2037-09-21');
-- Non-existent publisher
INSERT INTO Published_By (ID, Publisher_ID) VALUES (66925, 38816);
-- Future DOB
INSERT INTO Author (First_Name,Last_Name,Date_of_Birth, Author_ID, Biography) VALUES ('J.R.R.', ' Tolkien', '2037-01-03', 123456789, 'Best author ever');
-- Non-existent author
INSERT INTO Written_By (ID, Author_ID) VALUES (1, 818352457);


-- These test should not work
-- Update invalid constraints
-- Negative book quantity
UPDATE Location SET Quantity = -27 WHERE Location_ID = 70000;
-- Negative shelf number
UPDATE Location SET Shelf = -27 WHERE Location_ID = 70001;
-- Duplicate ISBN
UPDATE Book SET ISBN = 869427396 WHERE ID = 999990;
-- Update in written_by a null author
UPDATE Written_By SET Author_ID = NULL WHERE ID = 1;

-- Delete invalid constraints
-- delete country that is in use
DELETE FROM Is_In WHERE Country_ID = 1;
-- delete author that is in use
DELETE FROM Author WHERE Author_ID =1;