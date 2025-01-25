-- These are queries from the QUERIES section of the assignment

-- VIEW 1 --

-- Query 1: Insert a new book into the archive with the archive number 2001 and book type 'Classic' if it does not already exist in the Find_Archived_Books_View
INSERT INTO Archive (Archive_Number, Book_Type)
SELECT 2001, 'Classic'
WHERE NOT EXISTS (
    SELECT 1 FROM Find_Archived_Books_View WHERE Archive_Number = 2001
);
-- Query 2: Delete all books from the archive with the title 'The Great Gatsby' from the Find_Archived_Books_View
DELETE FROM Find_Archived_Books_View
WHERE Title = 'The Great Gatsby'
AND Archive_Number = 2001;


-- VIEW 2 --
-- Query 1: Insert a new employee into the Employee table with the Employee_ID 3001, Name 'Jane Smith', Role 'Manager', Age 40, and Salary 55000 if they have not disposed of any books
INSERT INTO Employee (Employee_ID, Name, Role, Age, Salary)
SELECT 3001, 'Jane Smith', 'Manager', 40, 55000
WHERE NOT EXISTS (
    SELECT 1 FROM Disposed_Books_Employees WHERE Employee_ID = 3001
);
-- Query 2: Update the disposal method of the book with the title 'Old Encyclopedia' to 'Recycling' in the Disposal table
UPDATE Disposal
SET Method = 'Recycling'
WHERE ID = (SELECT Book_ID FROM Disposed_Books_Employees WHERE Book_Title = 'Old Encyclopedia');
