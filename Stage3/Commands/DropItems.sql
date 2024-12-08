-- Drop items that don't get dropped in Stage1/Commands/DropTables.sql 
-- Exercise caution and ensure you know what you are doing before running this, you will lose all the DB data
BEGIN; 

-- dropping all of our own indexes (they do get deleted if you just drop the table via the other script)
-- Author age index
DROP INDEX IF EXISTS idx_author_dob_id;
-- Book facts index
DROP INDEX IF EXISTS idx_book_page_count_id;
-- Book release date index
DROP INDEX IF EXISTS idx_book_release_date;
-- Locale quantity index
DROP INDEX IF EXISTS idx_locale_quantity;
-- Locale quantity and condition index
DROP INDEX IF EXISTS idx_locale_quantity_condition;
-- Locale specific index
DROP INDEX IF EXISTS idx_locale_specific;
-- Foreign keys as indexes
DROP INDEX IF EXISTS idx_written_by_id;
DROP INDEX IF EXISTS idx_location_id;
DROP INDEX IF EXISTS idx_type_of_genre_id;
DROP INDEX IF EXISTS idx_location_book;
DROP INDEX IF EXISTS idx_written_by_author_id;
DROP INDEX IF EXISTS idx_published_by_publisher_id;
DROP INDEX IF EXISTS idx_published_by_book;
DROP INDEX IF EXISTS idx_written_in_language_id;
DROP INDEX IF EXISTS idx_written_in_book;
DROP INDEX IF EXISTS idx_type_of_book;
DROP INDEX IF EXISTS idx_is_in_pub_id;
DROP INDEX IF EXISTS idx_is_in_country_id;

DEALLOCATE PREPARE ALL; -- drops all prepared statements (these do not get deleted via the other script)

-- TODO for each function we make
-- DROP FUNCTION name(param)


-- VIEWS
DROP VIEW IF EXISTS Book_Detail_View;
DROP VIEW IF EXISTS Publisher_Detail_View;
DROP VIEW IF EXISTS Author_Books_View;
DROP VIEW IF EXISTS Genre_Location_Popularity_View;

commit;