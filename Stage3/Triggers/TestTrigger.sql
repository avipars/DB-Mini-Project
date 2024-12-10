-- Trigger 1 

INSERT INTO Book (Title, ID, Release_Date, Page_Count, Format, Description, ISBN)
VALUES ('Police ', 5000010, '1884-05-21', 1, 'Magazine', 'Poster', 322397558); -- Regular insert

SELECT * FROM Book WHERE ID = 5000010; -- Verify it got added

DELETE FROM Book WHERE ID = 5000010; -- Delete it 

SELECT * FROM Book_Log
ORDER BY Log_ID ASC;  -- check new log table

-- Trigger 2

-- Try UPDATE 
INSERT INTO Book (Title, ID, Release_Date, Page_Count, Format, Description, ISBN)
VALUES ('Physical Book', 100004, '2024-01-02', 349, 'Hardcover', 'A physical book with many pages.', 123944679); -- insert as hardcover to DB

SELECT * FROM Location WHERE ID = 100004; -- check in table

SELECT * FROM Book WHERE ID = 100004; -- check in table

INSERT INTO Location (Quantity, Floor, Shelf, Location_ID, Condition, ID)
VALUES (1, 'Reference Section', 2, 70002, 'Used', 100004); -- insert to location

SELECT * FROM Location WHERE ID = 100004; -- check in table

UPDATE Book
SET Format = 'Ebook'
WHERE ID = 100004; -- converted license to eBook

SELECT * FROM Location WHERE ID = 100004; -- check in table for changes

SELECT * FROM Book WHERE ID = 100004; -- check in table too


-- TRY INSERT

INSERT INTO Book (Title, ID, Release_Date, Page_Count, Format, Description, ISBN)
VALUES ('New eBook', 100009, '2024-12-08', 200, 'Ebook', 'An exciting new eBook!', 987684321);

-- check book
SELECT * FROM Book WHERE ID = 100009; -- check in table

-- now check location
SELECT * FROM Location WHERE ID = 100009; -- check in table for changes

