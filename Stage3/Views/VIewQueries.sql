-- View 1: Book details of available books
-- SELECT english dictionaries sorted by highest page count
SELECT Title, Description, Genre_Name, Publisher_Name, Page_Count
FROM Book_Detail_View  
WHERE Format = 'Dictionary' AND language_name = 'English'
ORDER BY Page_Count DESC;

-- INSERT (fail)
INSERT INTO Book_Detail_View (Title, Release_Date, Page_Count, Format, Description, Floor, Shelf, Genre_Name, Language_Name,Publisher_Name)
VALUES ('GenZ Dictionary', '2023-01-01', 55,'Dictionary', 'A book about me', 'E-Library Section',2,'Technology','English', 'Martinez-Mitchell');

-- UPDATE (fail)
UPDATE Book_Detail_View
SET Title = 'Self-Reflection'
WHERE ID = 17613;

-- DELETE (fail)
DELETE FROM Book_Detail_View WHERE ID = 17613;

-- View 2: Manage all the publishers 
-- SELECT publishers that have 1234 in their phone numbers
SELECT * FROM Publisher_Detail_View WHERE Phone_Number LIKE '%1234%';


-- INSERT (success)
INSERT INTO Publisher_Detail_View (Publisher_ID, Name, Phone_Number, Website)
VALUES (30001, 'Koren', '1-800-637-6724', 'https://korenpub.com/');

-- UPDATE (success)
UPDATE Publisher_Detail_View
SET Phone_Number='+972-2-633-0530', Website='https://korenpub.co.il/'
WHERE Publisher_ID = 30001;

-- DELETE (success)
DELETE FROM Publisher_Detail_View WHERE Publisher_ID = 30001;

-- View 3: Authors and books they wrote
-- SELECT authors born in winter 2000 and all the books they wrote
SELECT Author_Name, Title FROM Author_Books_View WHERE Date_of_Birth BETWEEN '2000-11-29' AND '2000-12-31';

-- INSERT (fail)
INSERT INTO Author_Books_View (Author_ID,Date_of_Birth, Biography,ID,Title,Author_Name) 
VALUES (438526395, '2000-02-02', 'Creator of epic science fiction worlds',458,'Twitter History','Daniel Johnson');

-- UPDATE (fail)
UPDATE Author_Books_View
SET Author_Name = 'Ed Norton'
WHERE Author_ID = 821474792;

-- DELETE (fail)
DELETE FROM Author_Books_View WHERE Author_ID = 281037653;

-- View 4: Book quantity per Genre
-- SELECT genres of books with less than 800 unique titles 
SELECT Genre_Name, Total_Copies_Available, Unique_Titles From Genre_Location_Popularity_View WHERE Unique_Titles <  800;

-- INSERT (fail)
INSERT INTO Genre_Location_Popularity_View(Genre_Name, Total_Copies_Available,Unique_Titles)
VALUES('Podcasts', 55,5);

-- UPDATE (fail)
UPDATE Genre_Location_Popularity_View
SET Total_Copies_Available = 50
WHERE Genre_Name = 'Non-Fiction';

-- DELETE (fail)
DELETE FROM Genre_Location_Popularity_View WHERE Genre_Name = 'Travel';