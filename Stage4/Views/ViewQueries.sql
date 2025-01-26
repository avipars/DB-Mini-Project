
-- These are queries from the VIEW section of the assignment

-- VIEW 1 -- 
-- QUERY 1 --
-- Get all archived books that are legendary, academic, and in the study area between 2000 and 2020
SELECT * FROM Find_Archived_Books_View WHERE release_date BETWEEN '2000-01-01' AND '2020-12-31' AND rarity = 'Legendary' AND book_type = 'Academic' AND floor = 'Study Area';

-- QUERY 2 --
-- Delete archived legendary academic books that were stolen but were last in the returns section (fails due to table joins)
DELETE FROM Find_Archived_Books_View WHERE  book_type = 'Academic' AND rarity = 'Legendary' AND floor = 'Returns' and condition = 'Stolen';

-- VIEW 2 --
-- QUERY 3 --
-- Get all disposed books that were buried and made of synthetic material, and were disposed by disposal workers over 60 years old
SELECT name, role, disposal_date, book_title, age FROM Disposed_Books_Employees WHERE method = 'Burial' AND material_of_book = 'Synthetic' AND role = 'Disposal Worker' AND age > 60;

-- QUERY 4 --
-- Raise the salary of the employee who has disposed of the most books by 10% (fails due to table joins)
UPDATE 
    Disposed_Books_Employees
SET 
    Salary = Salary * 1.10 
WHERE 
    Employee_ID = (
        SELECT 
            E.Employee_ID
        FROM 
            Employee E
        JOIN 
            Disposal D ON E.Employee_ID = D.Employee_ID
        GROUP BY 
            E.Employee_ID, E.Name
        ORDER BY 
            COUNT(*) DESC
        LIMIT 1
    );