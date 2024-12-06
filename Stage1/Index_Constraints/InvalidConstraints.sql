
-- Test input of invalid constraints which should cause an error

-- INSERTS 

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
-- Non-existent publisher of book
INSERT INTO Published_By (ID, Publisher_ID) VALUES (66925, 38816);
-- Non-existent book by publisher
INSERT INTO Published_By(Publisher_ID, ID) VALUES (29,155555);
-- Future DOB
INSERT INTO Author (First_Name,Last_Name,Date_of_Birth, Author_ID, Biography) VALUES ('J.R.R.', ' Tolkien', '2037-01-03', 123456789, 'Best author ever');
-- Non-existent author of book
INSERT INTO Written_By (ID, Author_ID) VALUES (1, 818352457);
-- Non-existent language to a book
INSERT INTO Written_In (ID,Language_ID) VALUES (31, 556);
-- Non-existent genre to a book
INSERT INTO Type_Of (ID, Genre_ID) VALUES (55, 78);
-- Non-existent book to a genre type 
INSERT INTO Type_Of (ID, Genre_ID) VALUES (100000, 77);
-- Non-existent country to publisher
INSERT INTO Is_In (Publisher_ID,Country_ID) VALUES (10,25);
-- Non-existent publisher in country
INSERT INTO Is_In (Publisher_ID,Country_ID) VALUES (30001,21);
-- Add a null author to written_by
INSERT INTO Written_By(Author_ID,ID) VALUES( NULL, 5);

-- UPDATES 

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
UPDATE Type_of SET Genre_ID = 123456789 WHERE Genre_ID = 18;
-- Update in Publisher a not unique phone number
UPDATE Publisher SET Phone_Number = '(420)325-5947' WHERE Publisher_ID = 1;
-- Update Publisher to a non-existent country
UPDATE Is_In SET Country_ID = 999 WHERE Publisher_ID = 10;
-- Update a future release date for a book
UPDATE Book SET Release_Date = '2025-12-25' WHERE ID = 50;
-- Update Written_In with a non-existent language
UPDATE Written_In SET Language_ID = 999 WHERE ID = 31;
-- Update an author's date of birth to a future date
UPDATE Author SET Date_of_Birth = '2030-01-01' WHERE Author_ID = 576940420;


-- DELETES 

-- Delete country that is in use (referenced in other tables)
DELETE FROM Country WHERE Country_ID = 23;
-- Delete author that is in use
DELETE FROM Author WHERE Author_ID =756070228;
-- Delete genre that is in use
DELETE FROM Genre WHERE Genre_ID = 1;
-- Delete publisher that is in use
DELETE FROM Publisher WHERE Publisher_ID = 7;
-- Delete language that is in use
DELETE FROM Language WHERE Language_ID = 5;
-- Delete book that is in use 
DELETE FROM Book WHERE ID = 13;
