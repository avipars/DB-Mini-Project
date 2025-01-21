
-- These are queries from the VIEW section of the assignment

-- Query 1 Select 1:
-- Get all archived books that are legendary, academic, and in the study area between 2000 and 2020
SELECT * FROM Find_Archived_Books_View WHERE release_date BETWEEN '2000-01-01' AND '2020-12-31' AND rarity = 'Legendary' AND book_type = 'Academic' AND floor = 'Study Area';

-- Query 2 Select 2:
-- Get all disposed books that were buried and made of synthetic material, and were disposed by disposal workers over 60 years old
SELECT name, role, disposal_date, book_title, age FROM Disposed_Books_Employees WHERE method = 'Burial' AND material_of_book = 'Synthetic' AND role = 'Disposal Worker' AND age > 60;