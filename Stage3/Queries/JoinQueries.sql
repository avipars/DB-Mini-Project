-- 3 or more queries that utilize a 2 or 3 table join (SELECT, UPDATE or both)

-- Query 1
-- This query joins the Book, Written_By, and Author tables to get the first and last name of the author of a book with a specific ID
-- SELECT Author.First_Name, Author.Last_Name
-- FROM Book
-- JOIN Written_By ON Book.ID = Written_By.ID
-- JOIN Author ON Written_By.Author_ID = Author.Author_ID
-- WHERE Book.ID = 2;
CREATE OR REPLACE FUNCTION GetAuthorNameByBookID(book_id INT)
RETURNS TABLE (first_name text, last_name text) AS $$
BEGIN
    RETURN QUERY
        SELECT 
            CAST(a.First_Name AS text) AS first_name,
            CAST(a.Last_Name AS text) AS last_name
        FROM 
            Book b
        JOIN 
            Written_By w ON b.ID = w.ID
        JOIN 
            Author a ON w.Author_ID = a.Author_ID
        WHERE 
            b.ID = book_id;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM GetAuthorNameByBookID(2);
-- -- Query 2
-- -- This query updates all the books published by Murray-Jenkins to Good Condition
-- UPDATE Location
-- SET Condition = 'Good'
-- WHERE ID IN (
--     SELECT B.ID
--     FROM Book B
--     JOIN Written_By WB ON B.ID = WB.ID
--     JOIN Author A ON WB.Author_ID = A.Author_ID
--     JOIN Published_By PB ON B.ID = PB.ID
--     JOIN Publisher P ON PB.Publisher_ID = P.Publisher_ID
--     WHERE P.Name = 'Murray-Jenkins');
CREATE OR REPLACE PROCEDURE UpdateBooksConditionForPublisher(publisher_name VARCHAR, cond_name VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Location
    SET condition = cond_name
    WHERE ID IN (
        SELECT B.ID
        FROM Book B
        JOIN Written_By WB ON B.ID = WB.ID
        JOIN Published_By PB ON B.ID = PB.ID
        JOIN Publisher P ON PB.Publisher_ID = P.Publisher_ID
        WHERE P.Name = publisher_name
    );
END;
$$;

CALL UpdateBooksConditionForPublisher('Murray-Jenkins', 'Good');

-- Litmus test - check if the condition was updated
-- SELECT DISTINCT b.ID, b.Title, p.Name AS Publisher, l.Condition
-- FROM Book b
-- JOIN Published_By pb ON b.ID = pb.ID
-- JOIN Publisher p ON pb.Publisher_ID = p.Publisher_ID
-- JOIN Location l ON b.ID = l.ID
-- WHERE p.Name = 'Murray-Jenkins' AND l.Condition = 'Good';

-- -- Query 3
-- -- This query joins the Publisher, Is_In, and Country tables to get the name of the country where a specific publisher is located
-- SELECT Country.Name
-- FROM Publisher
-- JOIN Is_In ON Publisher.Publisher_ID = Is_In.Publisher_ID
-- JOIN Country ON Is_In.Country_ID = Country.Country_ID
-- WHERE Publisher.Publisher_ID = 1;
CREATE OR REPLACE FUNCTION GetCountryByPublisherID(p_id INT)
RETURNS VARCHAR AS $$
DECLARE
    country_name VARCHAR;
BEGIN
    SELECT c.Name 
    INTO country_name
    FROM Publisher p
    JOIN Is_In ii ON p.Publisher_ID = ii.Publisher_ID
    JOIN Country c ON ii.Country_ID = c.Country_ID
    WHERE p.Publisher_ID = p_id;

    RETURN country_name;
END;
$$ LANGUAGE plpgsql;

SELECT GetCountryByPublisherID(1);
-- -- Query 4
-- -- This query selects all books with more than 10 pages and where the book was released within 10 years of the author being born
-- SELECT
--     b.ID AS Book_ID, 
--     b.Release_Date, 
--     a.Date_of_Birth
-- FROM 
--     Book b
-- JOIN 
--     Written_By wb ON b.ID = wb.ID
-- JOIN 
--     Author a ON wb.Author_ID = a.Author_ID
-- WHERE 
--     b.Release_Date < (a.Date_of_Birth + INTERVAL '10 years') AND b.Page_Count > 10
-- LIMIT 5;
CREATE OR REPLACE FUNCTION GetBooksReleasedWithin10YearsOfBirth(p_count INT)
RETURNS TABLE (
    Book_ID INT,
    Release_Date DATE,
    Date_of_Birth DATE
) AS $$
BEGIN
    RETURN QUERY
    SELECT
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
        b.Release_Date < (a.Date_of_Birth + INTERVAL '10 years') 
        AND b.Page_Count > p_count
    LIMIT 5;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM GetBooksReleasedWithin10YearsOfBirth(10);
