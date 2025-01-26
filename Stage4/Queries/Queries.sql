-- These are queries from the QUERIES section of the assignment

-- VIEW 1 --

-- Query 5: A book was declared missing but we found it. Update the condition status to match this in the Find_Archived_Books_View (query fails due to view using joins)
UPDATE Find_Archived_Books_View
SET condition = 'Found'
WHERE archive_number = (
    SELECT archive_number
    FROM Find_Archived_Books_View
    WHERE condition = 'Missing'
    AND shelf = 99
    AND archive_number = 2
)
AND title = 'Yard job stop court computer beautiful enough such.';

-- Query 6: Delete all books from the archive with the title that contains the words 'car TV' from the Find_Archived_Books_View (query fails due to view using joins)
DELETE FROM Find_Archived_Books_View
WHERE Title LIKE '%car TV%' AND Archive_Number = 46;

-- VIEW 2 --
-- Query 7: Insert a record saying that Sonya (Existing Employee) disposed of a specific book today (query fails due to view using joins)
INSERT INTO Disposed_Books_Employees (employee_id, name, role, age, salary, disposal_date, method, material_of_book, book_title, book_id)
VALUES (97, 'Sonya West', 'Archivist', 20, 67252, '2025-01-26', 'Burial', 'Paper', 'Federal hundred sure country.', 99999);

-- Query 8: Update the disposal method of the book with the title contains the words 'floor plan' to 'Recycling' in the Disposal table (query fails due to view using joins)
UPDATE Disposed_Books_Employees
SET Method = 'Recycling'
WHERE Book_ID = (SELECT Book_ID FROM Disposed_Books_Employees WHERE Book_Title LIKE '%floor plan%');