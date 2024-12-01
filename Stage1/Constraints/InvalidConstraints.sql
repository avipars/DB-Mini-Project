-- TODO VERIFY IT WORKS
-- Test input of invalid constraints which should cause an error
-- Negative book quantity
INSERT INTO Location (Quantity, Floor, Shelf, Location_ID, Condition, ID) VALUES (-1, 'History Section', 85, 1, 'New', 62819);
-- Negative shelf number
INSERT INTO Location (Quantity, Floor, Shelf, Location_ID, Condition, ID) VALUES (1, 'History Section', -85, 1, 'Like New', 62819);

-- Negative page count
INSERT INTO Book (ID, Title, ISBN, Page_Count, Release_Date) VALUES (1, 'The Hobbit', '123456789', -310, '1937-09-21');
-- Duplicate ISBN
INSERT INTO Book (ID, Title, ISBN, Page_Count, Release_Date) VALUES (1, 'The Hobbit', '869427396', 310, '1937-09-21');
-- Future release date
INSERT INTO Book (ID, Title, ISBN, Page_Count, Release_Date) VALUES (1, 'The Hobbit', '123456789', 310, '2037-09-21');

-- Future DOB
INSERT INTO Author (Author_ID, Name, Date_of_Birth) VALUES (1, 'J.R.R. Tolkien', '2037-01-03');
-- Non-existent publisher
INSERT INTO Published_By (ID, Publisher_ID) VALUES (1, 100);
-- Non-existent author
INSERT INTO Written_By (ID, Author_ID) VALUES (1, 100);
-
