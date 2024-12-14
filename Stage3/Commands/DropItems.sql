-- Drop items that don't get dropped in Stage1/Commands/DropTables.sql 
-- Exercise caution and ensure you know what you are doing before running this, you will lose all the DB data
BEGIN; 

-- Dropping all of our own indexes (they do get deleted if you just drop the table via the other script)
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

-- PREPARED STATEMENTS (Parameterized queries)
DEALLOCATE PREPARE ALL; --(these do not get deleted via the other script, even if all tables are dropped)

-- FUNCTIONS 
DROP FUNCTION IF EXISTS GetAuthorNameByBookID;
DROP FUNCTION IF EXISTS UpdateBooksConditionForPublisher;
DROP FUNCTION IF EXISTS GetCountryByPublisherID;
DROP FUNCTION IF EXISTS GetBooksReleasedWithin10YearsOfBirth(INT,INT);

-- VIEWS
DROP VIEW IF EXISTS Book_Detail_View;
DROP VIEW IF EXISTS Publisher_Detail_View;
DROP VIEW IF EXISTS Author_Books_View;
DROP VIEW IF EXISTS Genre_Location_Popularity_View;

-- TRIGGER
DROP TRIGGER IF EXISTS update_condition_on_ebook_format ON Book;
DROP TRIGGER IF EXISTS insert_condition_on_new_ebook ON Book;

DROP TABLE IF EXISTS Book_Log;
DROP TRIGGER IF EXISTS book_delete_trigger ON Book;
DROP FUNCTION IF EXISTS log_book_deletion;

COMMIT;