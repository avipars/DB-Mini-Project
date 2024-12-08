-- 3 or more queries that utilize a 2 or 3 table join (SELECT, UPDATE or both)

-- Query 1
-- This query joins the Book, Written_By, and Author tables to get the first and last name of the author of a book with a specific ID
SELECT Author.First_Name, Author.Last_Name
FROM Book
JOIN Written_By ON Book.ID = Written_By.ID
JOIN Author ON Written_By.Author_ID = Author.Author_ID
WHERE Book.ID = 2;

-- Query 2
-- This query updates all the books published by Murray-Jenkins to Good Condition
UPDATE Location
SET Condition = 'Good'
WHERE ID IN (
    SELECT B.ID
    FROM Book B
    JOIN Written_By WB ON B.ID = WB.ID
    JOIN Author A ON WB.Author_ID = A.Author_ID
    JOIN Published_By PB ON B.ID = PB.ID
    JOIN Publisher P ON PB.Publisher_ID = P.Publisher_ID
    WHERE P.Name = 'Murray-Jenkins');


-- Query 3
-- This query joins the Publisher, Is_In, and Country tables to get the name of the country where a specific publisher is located
SELECT Country.Name
FROM Publisher
JOIN Is_In ON Publisher.Publisher_ID = Is_In.Publisher_ID
JOIN Country ON Is_In.Country_ID = Country.Country_ID
WHERE Publisher.Publisher_ID = 1;

-- Query 4
-- This query selects all books with more than 10 pages and where the book wass released within 10 years of the author being born
    b.ID AS Book_ID, 
    b.Release_Date, 
    a.Date_of_Birth
FROM 
    Book b
JOIN 
    Written_By wb ON b.ID = wb.ID
JOIN 
    Author a ON wb.Author_ID = a.Author_ID
WHERE 
    b.Release_Date < (a.Date_of_Birth + INTERVAL '10 years') AND b.Page_Count > 10
LIMIT 5;