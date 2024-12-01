-- Get all entries - good for "backup"
SELECT * FROM Book; 
SELECT * FROM Language; 
SELECT * FROM Location;
SELECT * FROM Publisher;
SELECT * FROM Author;
SELECT * FROM Genre;
SELECT * FROM Country;
SELECT * FROM Written_By;  -- Book is written by author
SELECT * FROM Published_By; -- Book is published by publisher
SELECT * FROM Written_In; -- Book is in language
SELECT * FROM Type_of; -- Book is genre
SELECT * FROM Is_In; -- Publisher is in country

commit;