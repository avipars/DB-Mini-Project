"""(a) Prepare four functions that can replace parts (or whole) of queries that were already
introduced in previous steps.
(b) Place the queries in file Functions.sql. Add references and comments to these functions in the README. Make sure that flashy tricks in your functions are addressed in the
supporting documentation.
(c) Replace the original SQL with the ones that may carry the appropriate functions. Place
them in the file Queries.sql.
(d) Time the run of the resulting SQL statements using methods that we covered in class
"""
-- Query 1 - This function returns the first and last name of the author for a specific book, given the book ID.
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

-- Query 2 - This function updates the condition of books published by "Murray-Jenkins" to "Good".

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
-- Query 3 - This function returns the name of the country where a specific publisher is located, given the publisher ID.
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

-- Query 4 - This function returns books with more than 10 pages that were released within 10 years of the author's birth.
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

