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

-- 2. Average page count for Science books stored in locations with > 5 copies in subpar condition, useful for library inventory analysis and condition-based reporting
-- (taking up shelf space)
SELECT 
    ROUND(AVG(b.Page_Count), 2) AS avg_location_quantity
FROM 
    Location l, Book b, Type_of t, Genre g
WHERE 
    l.ID = b.ID
    AND b.ID = t.ID
    AND t.Genre_ID = g.Genre_ID
    AND g.Name = 'Science'
    AND l.Quantity > 5
    AND l.Condition NOT IN ('New', 'Like New', 'Very Good')


-- 3. Get books with the highest amount of pages that are in stock in decent condition
SELECT b.Title, b.Page_Count, l.Quantity
FROM Book b
JOIN Location l ON b.ID = l.ID
WHERE l.Quantity > 1 AND l.Condition IN ('New', 'Like New', 'Very Good') AND 
b.Page_Count = (SELECT MAX(Page_Count) FROM Book);

-- 4. Get book in english with the fewest pages
SELECT b.Title,b.Page_Count, l.Name AS Language
FROM Book b
JOIN Written_In wi ON b.ID = wi.ID
JOIN Language l ON wi.Language_ID = l.Language_ID
WHERE b.Page_Count = (SELECT MIN(Page_Count) FROM Book) AND l.Name = 'English'
GROUP BY b.Title, l.Name, b.Page_Count;


-- UPDATES

-- 5. Fix the Y2K bug by changing all books released between 1999-12-28 and 1999-12-31 to 2000-01-01 and has at least 2 pages:
-- To check what will change: 
-- SELECT b.Release_Date 
-- FROM Book b 
UPDATE Book 
SET Release_Date = '2000-01-01'
WHERE Release_Date > '1999-12-27' AND Release_Date <= '1999-12-31'  AND Page_Count > 1;

-- 6. Move all returned Children's books from Returns that are in decent condition to the Kids Corner:
-- To check what will change:
-- SELECT l.ID, l.Floor, l.Condition
-- FROM Location l
UPDATE Location l
SET Floor = 'Kids Corner'
FROM (
    SELECT b.ID
    FROM Book b
    JOIN Type_of t ON b.ID = t.ID
    JOIN Genre g ON t.Genre_ID = g.Genre_ID
    WHERE g.Name = 'Children'
) AS SubQuery
WHERE l.ID = SubQuery.ID
AND l.Floor = 'Returns' 
AND l.Condition IN ('Good', 'New', 'Like New') 
AND l.Quantity >= 1;

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
        WHERE  l.Condition IN ('Damaged', 'Moldy') AND l.Quantity = 0
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
        WHERE l.Name = 'Russian'
        AND loc.Quantity > 90
        GROUP BY b.ID
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