-- Drops everything we did in Stage4 (Deletes everything)
-- Exercise caution and ensure you know what you are doing before running this, you will lose all the DB data
BEGIN; 

DROP VIEW IF EXISTS Find_Archived_Books_View; -- View 1
DROP VIEW IF EXISTS Disposed_Books_Employees; -- View 2

DROP TABLE IF EXISTS Archival_Assignment; -- Employee archives a book
DROP TABLE IF EXISTS Upkeep; -- Employee performs upkeep on a book
DROP TABLE IF EXISTS Disposal; -- Employee disposes of a book
DROP TABLE IF EXISTS Location; -- Location of publisher
DROP TABLE IF EXISTS Archive; -- Archive of books
DROP TABLE IF EXISTS Employee; -- Employee
DROP TABLE IF EXISTS Is_In; -- Publisher is in country
DROP TABLE IF EXISTS Type_of; -- Book is genre
DROP TABLE IF EXISTS Written_In; -- Book is in language
DROP TABLE IF EXISTS Published_By; -- Book is published by publisher
DROP TABLE IF EXISTS Written_By; -- Book is written by author
DROP TABLE IF EXISTS Book; -- Book
DROP TABLE IF EXISTS Genre; -- Genre
DROP TABLE IF EXISTS Language; -- Language
DROP TABLE IF EXISTS Author; -- Author
DROP TABLE IF EXISTS Publisher; -- Publisher
DROP TABLE IF EXISTS Country; -- Country

COMMIT;