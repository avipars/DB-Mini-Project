-- Enable timing
\timing on
-- SELECTS

-- 1. Find the 5 oldest authors (Name, DOB) who published at least 1 book in the database 
SELECT a.First_Name, a.Last_Name, a.Date_of_Birth 
FROM Author a 
JOIN Written_By wb ON a.Author_ID = wb.Author_ID 
JOIN Book b ON wb.ID = b.ID 
GROUP BY a.First_Name, a.Last_Name, a.Date_of_Birth
HAVING COUNT(DISTINCT b.ID) > 0 -- at least one book written
ORDER BY a.Date_of_Birth ASC -- oldest first (DESC would be youngest first)
LIMIT 5;

-- 2. Get average amount of books published by any publisher
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
);

-- 3. Get publisher (ID) with books published in the most languages
WITH LanguageCounts AS ( 
    SELECT -- subquery that gives you publisher name and unique language count
        P.Name,  -- publisher name
        COUNT(DISTINCT w.Language_ID) AS LanguageCount -- count unique languages
    FROM Publisher p
    JOIN Published_By pb ON p.Publisher_ID = pb.Publisher_ID
    JOIN Written_In w ON pb.ID = w.ID 
    GROUP BY P.Publisher_ID, P.Name -- group by publisher
);
SELECT Name, LanguageCount 
FROM LanguageCounts
WHERE LanguageCount = (SELECT MAX(LanguageCount) FROM LanguageCounts); -- take previous subquery and extract the MAX

-- 4. Get book title and quantity of book with the lowest quantity in stock
SELECT b.Title, l.Quantity
FROM Book b
JOIN Location l ON b.ID = l.ID
WHERE l.Quantity = (SELECT MIN(Quantity) FROM Location) -- get the book with the lowest quantity
LIMIT 1;

-- UPDATES

-- 5. Fix the Y2K bug by changing all books released between 1999-12-28 and 1999-12-31 to 2000-01-01:
-- To check what will change: 
-- SELECT b.Release_Date 
-- FROM Book b 
-- WHERE Release_Date > '1999-12-27' AND Release_Date <= '1999-12-31'
UPDATE Book 
SET Release_Date = '2000-01-01'
WHERE Release_Date > '1999-12-27' AND Release_Date <= '1999-12-31';

-- 6. Move all returned Children's books from Returns that are in decent condition to the Kids Corner:
-- To check what will change:
-- SELECT l.ID, l.Floor, l.Condition
-- FROM Location l
-- WHERE l.ID IN (
--     SELECT b.ID
--     FROM Book b
--     JOIN Type_of t ON b.ID = t.ID
--     JOIN Genre g ON t.Genre_ID = g.Genre_ID
--     WHERE g.Name = 'Childrens' 
-- )
-- AND l.Condition IN ('Good', 'New', 'Like New') AND l.Floor = 'Returns' AND l.quantity > 0;
UPDATE Location
SET Floor = 'Kids Corner'
WHERE ID IN (
    SELECT b.ID
    FROM Book b
    JOIN Type_of t ON b.ID = t.ID
    JOIN Genre g ON t.Genre_ID = g.Genre_ID
    WHERE g.Name = 'Childrens'
)
AND Condition IN ('Good', 'New', 'Like New') 
AND Floor = 'Returns' 
AND quantity > 0;

-- DELETES

-- 7. Delete books with 0 copies that are moldy or damaged
-- To check what will change:
-- SELECT * FROM Book
-- WHERE ID IN (
--     SELECT b.ID
--     FROM Book b
--     JOIN Location l ON b.ID = l.ID
--     WHERE l.Quantity = 0 AND l.Condition IN ('Damaged', 'Moldy')
-- );
-- 1. Delete from the Written_By table (book-author relation)
BEGIN;
    DELETE FROM Written_By
    WHERE ID IN (
        SELECT b.ID
        FROM Book b
        JOIN Location l ON b.ID = l.ID
        WHERE l.Quantity = 0 AND l.Condition IN ('Damaged', 'Moldy')
    );
    -- 2. Delete from the Published_By table (book-publisher relation)
    DELETE FROM Published_By
    WHERE ID IN (
        SELECT b.ID
        FROM Book b
        JOIN Location l ON b.ID = l.ID
        WHERE l.Quantity = 0 AND l.Condition IN ('Damaged', 'Moldy')
    );
    -- 3. Delete from the Written_In table (book-language relation)
    DELETE FROM Written_In
    WHERE ID IN (
        SELECT b.ID
        FROM Book b
        JOIN Location l ON b.ID = l.ID
        WHERE l.Quantity = 0 AND l.Condition IN ('Damaged', 'Moldy')
    );
    -- 4. Delete from the Type_of table (book-genre relation)
    DELETE FROM Type_of
    WHERE ID IN (
        SELECT b.ID
        FROM Book b
        JOIN Location l ON b.ID = l.ID
        WHERE l.Quantity = 0 AND l.Condition IN ('Damaged', 'Moldy')
    );
    -- 5. Delete from the Location table (book location)
    DELETE FROM Location
    WHERE ID IN (
        SELECT b.ID
        FROM Book b
        JOIN Location l ON b.ID = l.ID
        WHERE l.Quantity = 0 AND l.Condition IN ('Damaged', 'Moldy')
    );
    -- 6. Finally, delete the book from the Book table
    DELETE FROM Book
    WHERE ID IN (
        SELECT b.ID
        FROM Book b
        JOIN Location l ON b.ID = l.ID
        WHERE l.Quantity = 0 AND l.Condition IN ('Damaged', 'Moldy')
    );
COMMIT;


-- 8. Due to the war with ukraine, we have to remove all books written in russian that have more than 90 copies in stock
-- To check what will change:
-- SELECT b.Title, b.ID, COUNT(wb.Author_ID)
-- FROM Book b
-- JOIN Written_By wb ON b.ID = wb.ID
-- JOIN Written_In wi ON b.ID = wi.ID
-- JOIN Language l ON wi.Language_ID = l.Language_ID
-- JOIN Location loc ON b.ID = loc.ID
-- WHERE l.Name = 'Russian'
--   AND loc.Quantity > 90
-- GROUP BY b.ID

-- 1. Delete from Written_By (book-author relation)
BEGIN;
    DELETE FROM Written_By
    WHERE ID IN (
        SELECT b.ID
        FROM Book b
        JOIN Written_By wb ON b.ID = wb.ID
        JOIN Written_In wi ON b.ID = wi.ID
        JOIN Language l ON wi.Language_ID = l.Language_ID
        JOIN Location loc ON b.ID = loc.ID
        WHERE l.Name = 'Yiddish'
        AND loc.Quantity > 5
        GROUP BY b.ID
        HAVING COUNT(wb.Author_ID) = 4
    );

    -- 2. Delete from Published_By (book-publisher relation)
    DELETE FROM Published_By
    WHERE ID IN (
        SELECT b.ID
        FROM Book b
        JOIN Written_By wb ON b.ID = wb.ID
        JOIN Written_In wi ON b.ID = wi.ID
        JOIN Language l ON wi.Language_ID = l.Language_ID
        JOIN Location loc ON b.ID = loc.ID
        WHERE l.Name = 'Russian'
        AND loc.Quantity > 90
        GROUP BY b.ID
    );

    -- 3. Delete from Written_In (book-language relation)
    DELETE FROM Written_In
    WHERE ID IN (
        SELECT b.ID
        FROM Book b
        JOIN Written_By wb ON b.ID = wb.ID
        JOIN Written_In wi ON b.ID = wi.ID
        JOIN Language l ON wi.Language_ID = l.Language_ID
        JOIN Location loc ON b.ID = loc.ID
        WHERE l.Name = 'Russian'
        AND loc.Quantity > 90
        GROUP BY b.ID
    );

    -- 4. Delete from Type_of (book-genre relation)
    DELETE FROM Type_of
    WHERE ID IN (
        SELECT b.ID
        FROM Book b
        JOIN Written_By wb ON b.ID = wb.ID
        JOIN Written_In wi ON b.ID = wi.ID
        JOIN Language l ON wi.Language_ID = l.Language_ID
        JOIN Location loc ON b.ID = loc.ID
        WHERE l.Name = 'Russian'
        AND loc.Quantity > 90
        GROUP BY b.ID
    );

    -- 5. Delete from Location (book location)
    DELETE FROM Location
    WHERE ID IN (
        SELECT b.ID
        FROM Book b
        JOIN Written_By wb ON b.ID = wb.ID
        JOIN Written_In wi ON b.ID = wi.ID
        JOIN Language l ON wi.Language_ID = l.Language_ID
        JOIN Location loc ON b.ID = loc.ID
        WHERE l.Name = 'Russian'
        AND loc.Quantity > 90
        GROUP BY b.ID
    );

    -- 6. Finally, delete the book from the Book table
    DELETE FROM Book
    WHERE ID IN (
        SELECT b.ID
        FROM Book b
        JOIN Written_By wb ON b.ID = wb.ID
        JOIN Written_In wi ON b.ID = wi.ID
        JOIN Language l ON wi.Language_ID = l.Language_ID
        JOIN Location loc ON b.ID = loc.ID
        WHERE l.Name = 'Russian'
        AND loc.Quantity > 90
        GROUP BY b.ID
    );
COMMIT;