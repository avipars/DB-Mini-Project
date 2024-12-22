-- View 1: Book details of available books
CREATE OR REPLACE VIEW Book_Detail_View AS
SELECT 
    b.ID,
    b.Title,
    b.Release_Date,
    b.Page_Count,
    b.Format,
    b.Description,
    lo.Floor,
    lo.Shelf,
    g.Name AS Genre_Name,
    l.Name AS Language_Name,  
    p.Name AS Publisher_Name
FROM Book b
JOIN Type_of t ON b.ID = t.ID
JOIN Genre g ON t.Genre_ID = g.Genre_ID
JOIN Written_In wi ON b.ID = wi.ID
JOIN Language l ON wi.Language_ID = l.Language_ID
JOIN Published_By pb ON b.ID = pb.ID
JOIN Publisher p ON pb.Publisher_ID = p.Publisher_ID
JOIN Location lo ON b.ID = lo.ID
WHERE lo.Floor NOT IN ('Storage', 'Maintenance', 'Special Collections', 'Archive', 'Returns') 
  AND lo.Quantity >= 1;  -- Ensure books are available for loan


-- View 2: Manage all the publishers 
CREATE OR REPLACE VIEW Publisher_Detail_View AS 
SELECT
	p.Publisher_ID,
    p.Name,
    p.Phone_Number,
    p.Website
FROM Publisher p;

-- View 3: Authors and books they wrote
CREATE OR REPLACE VIEW Author_Books_View AS
SELECT
    a.Author_ID,
    a.Date_of_Birth,
    a.Biography,
    b.ID,
    b.Title,
    CONCAT(a.First_Name, ' ', a.Last_Name) AS Author_Name
FROM 
    Author a
JOIN Written_By wb ON a.Author_ID = wb.Author_ID
JOIN Book b ON wb.ID = b.ID;


-- View 4: Book quantity per Genre
CREATE OR REPLACE VIEW Genre_Location_Popularity_View AS
SELECT 
    g.Name AS Genre_Name,
    SUM(lo.Quantity) AS Total_Copies_Available,
    COUNT(DISTINCT b.ID) AS Unique_Titles
FROM Genre g
JOIN Type_of t ON g.Genre_ID = t.Genre_ID
JOIN Book b ON t.ID = b.ID
JOIN Location lo ON b.ID = lo.ID
GROUP BY g.Genre_ID, g.Name
ORDER BY Total_Copies_Available DESC, Unique_Titles;
