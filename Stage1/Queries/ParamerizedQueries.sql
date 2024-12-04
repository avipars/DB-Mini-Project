-- QUERY 9: a query where the user enters a genre and number of outputs and results the most ranked authors in that genre
-- RANK = number of books written by author in that genre
-- Prepare the query
PREPARE find_top_books_by_author(CHARACTER VARYING, INTEGER) AS
WITH AuthorRank AS (
    SELECT 
        wb.Author_ID,
        a.First_Name || ' ' || a.Last_Name AS Author_Name, 
        COUNT(wb.ID) AS Total_Books_By_Author,
        tof.Genre_ID
    FROM 
        Written_By wb
    JOIN 
        Book b ON wb.ID = b.ID
    JOIN 
        Type_of tof ON b.ID = tof.ID
    JOIN 
        Author a ON wb.Author_ID = a.Author_ID
    JOIN 
        Genre g ON tof.Genre_ID = g.Genre_ID
    WHERE 
        g.Name = $1 -- Genre parameter
    GROUP BY 
        wb.Author_ID, a.First_Name, a.Last_Name, tof.Genre_ID
    ORDER BY 
        Total_Books_By_Author DESC
    LIMIT $2 -- Number of top authors parameter
)
SELECT 
    b.Title AS Book_Title,
    ar.Author_Name,
    ar.Total_Books_By_Author
FROM 
    AuthorRank ar
JOIN 
    Written_By wb ON ar.Author_ID = wb.Author_ID
JOIN 
    Book b ON wb.ID = b.ID
JOIN 
    Type_of tof ON b.ID = tof.ID
WHERE 
    tof.Genre_ID = (SELECT Genre_ID FROM Genre WHERE Name = $1) -- Genre parameter
ORDER BY 
    ar.Total_Books_By_Author DESC, b.Title ASC
LIMIT $2; -- Number of top books parameter

-- Execute the prepared query with arguments
EXECUTE find_top_books_by_author('Fantasy', 5);


-- QUERY 10: a query where the user enters a language and it outputs 5 books written in that language
-- Prepare the query
PREPARE find_books_by_language(CHARACTER VARYING, INTEGER) AS
SELECT 
    b.Title AS Book_Title,
    b.Release_Date,
    b.ISBN,
    b.Page_Count,
    b.Format
FROM 
    Book b
JOIN 
    Written_In wi ON b.ID = wi.ID
JOIN 
    Language l ON wi.Language_ID = l.Language_ID
WHERE 
    l.Name = $1  -- Parameterized language input
ORDER BY 
    b.Title ASC  -- Optionally, order by Title or any other criteria
LIMIT $2;  -- Limit to top N books based on user input

-- Execute the prepared query with arguments
EXECUTE find_books_by_language('Spanish', 5);


-- QUERY 11: The user enters a book name and it outputs all the publishers of this book
-- Prepare the query
PREPARE find_publishers_by_book(CHARACTER VARYING) AS
SELECT 
    p.Name AS Publisher_Name,
    p.Phone_Number,
    p.Website AS Publisher_Address
FROM 
    Publisher p
JOIN 
    Published_By pb ON p.Publisher_ID = pb.Publisher_ID
JOIN 
    Book b ON pb.ID = b.ID
WHERE 
    b.Title = $1;  -- Parameterized book title input

-- Execute the prepared query with the book name as an argument
EXECUTE find_publishers_by_book('View store draw maintain should PM.');

-- QUERY 12: The user enters a publisher name and it outputs all the books published by this publisher
-- Prepare the query
PREPARE find_books_by_publisher(CHARACTER VARYING) AS
SELECT 
    b.Title AS Book_Title,
    b.Release_Date,
    b.ISBN,
    b.Page_Count,
    b.Format
FROM 
    Publisher p
JOIN 
    Published_By pb ON p.Publisher_ID = pb.Publisher_ID
JOIN 
    Book b ON pb.ID = b.ID
WHERE 
    p.Name = $1;  -- Parameterized publisher name input

-- Execute the prepared query with the publisher name as an argument
EXECUTE find_books_by_publisher('Norton, Stevens and Dunlap');

