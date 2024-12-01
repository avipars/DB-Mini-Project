-- 4 SELECTS
-- Find the 5 oldest authors (Name, DOB) who published at least 1 book in the database 
SELECT a.First_Name, a.Last_Name, a.Date_of_Birth 
FROM Author a 
JOIN Written_By wb ON a.Author_ID = wb.Author_ID 
JOIN Book b ON wb.ID = b.ID 
GROUP BY a.First_Name, a.Last_Name, a.Date_of_Birth
HAVING COUNT(DISTINCT b.ID) > 0 -- at least one book written
ORDER BY a.Date_of_Birth ASC -- oldest first (DESC would be youngest first)
LIMIT 5;

-- Get average amount of books published by any publisher
SELECT 
    ROUND(AVG(BookCount), 2) AS Average_Books_Per_Publisher -- round to 2 decimal places
FROM (
    SELECT 
        p.Publisher_ID, 
        p.Name AS Publisher_Name, 
        COUNT(pb.ID) AS BookCount -- count books published by each publisher
    FROM Publisher p 
    LEFT JOIN Published_By pb ON p.Publisher_ID = pb.Publisher_ID -- join publishers with books
    GROUP BY p.Publisher_ID, p.Name -- group by publisher
)

-- Get publisher (ID) with books published in the most languages
WITH LanguageCounts AS ( 
    SELECT -- subquery that gives you publisher name and unique language count
        P.Name,  -- publisher name
        COUNT(DISTINCT w.Language_ID) AS LanguageCount -- count unique languages
    FROM Publisher p
    JOIN Published_By pb ON p.Publisher_ID = pb.Publisher_ID
    JOIN Written_In w ON pb.ID = w.ID 
    GROUP BY P.Publisher_ID, P.Name -- group by publisher
)
SELECT Name, LanguageCount 
FROM LanguageCounts
WHERE LanguageCount = (SELECT MAX(LanguageCount) FROM LanguageCounts) -- take previous subquery and extract the MAX

-- Get book title and quantity of book with the lowest quantity in stock
SELECT b.Title, l.Quantity
FROM Book b
JOIN Location l ON b.ID = l.ID
WHERE l.Quantity = (SELECT MIN(Quantity) FROM Location) -- get the book with the lowest quantity
LIMIT 1;

-- 2 UPDATES
-- Fix the Y2K bug by changing all books released between 1999-12-28 and 1999-12-31 to 2000-01-01:

-- To check what will change: 
-- SELECT b.Release_Date 
-- FROM Book b 
-- WHERE Release_Date > '1999-12-27' AND Release_Date <= '1999-12-31'
UPDATE Book 
SET Release_Date = '2000-01-01'
WHERE Release_Date > '1999-12-27' AND Release_Date <= '1999-12-31'

-- Move all returned Reference books from Returns that are in good condition to the Reference section:
SELECT l.ID, l.Floor, l.Condition
FROM Location l
WHERE l.ID IN (
    SELECT b.ID
    FROM Book b
    JOIN Type_of t ON b.ID = t.ID
    JOIN Genre g ON t.Genre_ID = g.Genre_ID
    WHERE g.Name = 'Childrens' 
)
AND l.Condition IN ('Good', 'New', 'Like New') AND l.Floor = 'Returns' AND l.quantity > 0;

-- -- TODO CHECK AND VERIFY THE FOLLOWING
-- -- All new books that have been released in the last 3 years that are New are now considered Like New:
-- UPDATE Location
-- SET Condition = 'Like New'
-- WHERE ID IN (
--     SELECT b.ID
--     FROM Book b
--     WHERE b.Release_Date >= DATE_SUB(CURDATE(), INTERVAL 3 YEAR)
-- )
-- AND Condition = 'New';

-- -- Move all returned Reference books that are in good condition to the Reference section:
-- UPDATE Location
-- SET Floor = 'Reference Section'
-- WHERE ID IN (
--     SELECT b.ID
--     FROM Book b
--     JOIN Type_of t ON b.ID = t.ID
--     JOIN Genre g ON t.Genre_ID = g.Genre_ID
--     WHERE g.Name = 'Reference'
-- )
-- AND Condition = 'Good';

-- 2 DELETES
-- -- TODO CHECK AND VERIFY THE FOLLOWING
-- -- Delete books that are in Poor or Damaged condition if their copies are less than 5:
-- DELETE FROM Book
-- WHERE ID IN (
--     SELECT b.ID
--     FROM Book b
--     JOIN Location l ON b.ID = l.ID
--     WHERE l.Condition IN ('Poor', 'Damaged') AND l.Quantity < 5
-- );

-- -- Delete publishers that have no books published by them in the database:
-- DELETE FROM Publisher
-- WHERE Publisher_ID NOT IN (
--     SELECT DISTINCT Publisher_ID
--     FROM Published_By
-- );

-- delete books with quantity of 0? 