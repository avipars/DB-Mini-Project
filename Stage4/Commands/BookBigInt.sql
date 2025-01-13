-- Script is used to convert INT to BIGINT for Book ID before merging tables
DROP VIEW IF EXISTS genre_location_popularity_view;
DROP VIEW IF EXISTS book_detail_view ;
DROP VIEW IF EXISTS author_books_view ;

Alter Table Book Alter Column id TYPE BIGINT;
Alter Table written_by Alter Column id TYPE BIGINT;
Alter Table Published_by Alter Column id TYPE BIGINT;
Alter Table written_in Alter Column id TYPE BIGINT;
Alter Table type_of Alter Column id TYPE BIGINT;
