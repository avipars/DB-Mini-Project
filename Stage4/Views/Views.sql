-- Create a view that shows all the archived books with their location and archive number
CREATE OR REPLACE VIEW Find_Archived_Books_View AS
SELECT 
    B.Title, 
    B.Release_Date, 
    B.Rarity, 
    A.Book_Type, 
    L.Floor, 
    L.Shelf, 
    L.Condition,
	A.Archive_Number
FROM 
    Book B
JOIN 
    Location L ON B.ID = L.ID
JOIN 
    Archive A ON L.Archive_Number = A.Archive_Number;

-- Connects employees with books that they have disposed
CREATE VIEW Disposed_Books_Employees AS
SELECT 
    E.Employee_ID, 
    E.Name, 
    E.Role, 
    E.Age, 
    E.Salary, 
    D.Date AS Disposal_Date, 
    D.Method, 
    D.Material_of_Book, 
    B.Title AS Book_Title, 
    B.ID AS Book_ID
FROM 
    Employee E
JOIN 
    Disposal D ON E.Employee_ID = D.Employee_ID
JOIN 
    Book B ON D.ID = B.ID
