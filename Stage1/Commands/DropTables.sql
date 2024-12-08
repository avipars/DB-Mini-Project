-- Drop script (Deletes everything)
-- Exercise caution and ensure you know what you are doing before running this, you will lose all the DB data

DROP TABLE IF EXISTS Is_In; -- Publisher is in country
DROP TABLE IF EXISTS Type_of; -- Book is genre
DROP TABLE IF EXISTS Written_In; -- Book is in language
DROP TABLE IF EXISTS Published_By; -- Book is published by publisher
DROP TABLE IF EXISTS Written_By; -- Book is written by author
DROP TABLE IF EXISTS Location; -- Location of publisher
DROP TABLE IF EXISTS Book; -- Book
DROP TABLE IF EXISTS Genre; -- Genre
DROP TABLE IF EXISTS Language; -- Language
DROP TABLE IF EXISTS Author; -- Author
DROP TABLE IF EXISTS Publisher; -- Publisher
DROP TABLE IF EXISTS Country; -- Country

commit;