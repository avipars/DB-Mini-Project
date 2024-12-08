-- 3 or more queries that utilize a 2 or 3 table join (SELECT, UPDATE or both)

-- Query 1
-- This query joins the Book, Written_By, and Author tables to get the first and last name of the author of a book with a specific ID
SELECT Author.First_Name, Author.Last_Name
FROM Book
JOIN Written_By ON Book.ID = Written_By.ID
JOIN Author ON Written_By.Author_ID = Author.Author_ID
WHERE Book.ID = 1;

-- Query 2
-- This query updates all the books located in a specific shelf to have a new condition
UPDATE Location
SET Condition = 'New Condition'
FROM Book
WHERE Book.ID = Location.ID AND Location.Shelf = 1;


-- Query 3
-- This query joins the Publisher, Is_In, and Country tables to get the name of the country where a specific publisher is located
SELECT Country.Name
FROM Publisher
JOIN Is_In ON Publisher.Publisher_ID = Is_In.Publisher_ID
JOIN Country ON Is_In.Country_ID = Country.Country_ID
WHERE Publisher.Publisher_ID = 1;

-- Query 4
-- This query selects all queries where the release date is before its author's date of birth and updates the release date to be the author's 20th birthday
SELECT Book.ID, Book.Release_Date, Author.Date_of_Birth
FROM Book
JOIN Written_By ON Book.ID = Written_By.ID
JOIN Author ON Written_By.Author_ID = Author.Author_ID
WHERE Book.Release_Date < (Author.Date_of_Birth + INTERVAL '20 years');

