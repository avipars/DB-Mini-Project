-- Script is used to convert INT to BIGINT for Book ID before merging tables
-- Need to drop these views as they use Book ID 
DROP VIEW IF EXISTS Genre_Location_Popularity_View; 
DROP VIEW IF EXISTS Book_Detail_View;
DROP VIEW IF EXISTS Author_Books_View;

-- Then every table that uses Book ID needs to have it's type changed
ALTER TABLE Book ALTER COLUMN ID TYPE BIGINT;
ALTER TABLE Written_By ALTER COLUMN ID TYPE BIGINT;
ALTER TABLE Published_By ALTER COLUMN ID TYPE BIGINT;
ALTER TABLE Written_In ALTER COLUMN ID TYPE BIGINT;
ALTER TABLE Type_Of ALTER COLUMN ID TYPE BIGINT;
