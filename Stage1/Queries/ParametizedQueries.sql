-- Selects the top 5 publishers with the most books in stock and accounts the quantity of books in stock.

SELECT 
    p.Name AS Publisher_Name,
    SUM(l.Quantity) AS Total_Books
FROM 
    Publisher p
JOIN 
    Published_By pb ON p.Publisher_ID = pb.Publisher_ID
JOIN 
    Book b ON pb.ID = b.ID
JOIN 
    Location l ON b.ID = l.ID
GROUP BY 
    p.Name
ORDER BY 
    Total_Books DESC
LIMIT 5;

-- Selects the top 5 languages 
SELECT 
    l.Name AS Language_Name,
    COUNT(wi.ID) AS Total_Books
FROM 
    Language l
JOIN 
    Written_In wi ON l.Language_ID = wi.Language_ID
GROUP BY 
    l.Name
ORDER BY 
    Total_Books DESC
LIMIT 5;


-- Selects the best rank <= 5 authors with the most books in the 5 most popular genres
WITH GenrePopularity AS (
    SELECT 
        g.Genre_ID,
        g.Name AS Genre_Name,
        COUNT(tof.ID) AS Total_Books
    FROM 
        Genre g
    JOIN 
        Type_of tof ON g.Genre_ID = tof.Genre_ID
    GROUP BY 
        g.Genre_ID, g.Name
    ORDER BY 
        Total_Books DESC
    LIMIT 5
),
AuthorPopularity AS (
    SELECT 
        wb.Author_ID,
        a.First_Name || ' ' || a.Last_Name AS Author_Name,
        tof.Genre_ID,
        COUNT(wb.ID) AS Total_Books_By_Author
    FROM 
        Written_By wb
    JOIN 
        Book b ON wb.ID = b.ID
    JOIN 
        Type_of tof ON b.ID = tof.ID
    JOIN 
        Author a ON wb.Author_ID = a.Author_ID
    WHERE 
        tof.Genre_ID IN (SELECT Genre_ID FROM GenrePopularity)
    GROUP BY 
        wb.Author_ID, a.First_Name, a.Last_Name, tof.Genre_ID
),
TopAuthorsByGenre AS (
    SELECT 
        Genre_ID,
        Author_ID,
        Author_Name,
        Total_Books_By_Author,
        RANK() OVER (PARTITION BY Genre_ID ORDER BY Total_Books_By_Author DESC) AS Author_Rank
    FROM 
        AuthorPopularity
)
SELECT 
    gp.Genre_Name,
    ta.Author_Name,
    ta.Total_Books_By_Author
FROM 
    TopAuthorsByGenre ta
JOIN 
    GenrePopularity gp ON ta.Genre_ID = gp.Genre_ID
WHERE 
    ta.Author_Rank <= 5
ORDER BY 
    gp.Genre_Name, ta.Total_Books_By_Author DESC;


-- a query that shows the 5 most book names that are contained in the same shelf
SELECT 
    l.Shelf,
    b.Title AS Book_Title,
    COUNT(*) AS Frequency
FROM 
    Location l
JOIN 
    Book b ON l.ID = b.ID
GROUP BY 
    l.Shelf, b.Title
ORDER BY 
    Frequency DESC
LIMIT 5;
