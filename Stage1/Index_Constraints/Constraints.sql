-- Indexes
CREATE INDEX IF NOT EXISTS idx_author_dob_id ON Author(Author_ID, Date_of_Birth); -- Author age
CREATE INDEX IF NOT EXISTS idx_book_page_count_id ON Book(ID, Page_Count); -- book facts
CREATE INDEX IF NOT EXISTS idx_book_release_date ON Book(ID, Release_Date);
CREATE INDEX IF NOT EXISTS idx_locale_quantity ON Location(ID, Quantity);
CREATE INDEX IF NOT EXISTS idx_locale_quantity_condition ON Location(ID, Condition, Quantity);
CREATE INDEX IF NOT EXISTS idx_locale_specific ON Location(ID, Floor, Condition, Quantity);

-- Foreign keys as indexes
CREATE INDEX IF NOT EXISTS idx_written_by_id ON Written_By(ID);
CREATE INDEX IF NOT EXISTS idx_location_id ON Location(ID);
CREATE INDEX IF NOT EXISTS idx_type_of_genre_id ON Type_of(Genre_ID);
CREATE INDEX IF NOT EXISTS idx_location_book ON Location(ID);
CREATE INDEX IF NOT EXISTS idx_written_by_author_id ON Written_By(Author_ID); 
CREATE INDEX IF NOT EXISTS idx_published_by_publisher_id ON Published_By(Publisher_ID);
CREATE INDEX IF NOT EXISTS idx_published_by_book ON Published_By(ID);
CREATE INDEX IF NOT EXISTS idx_written_in_language_id ON Written_In(Language_ID);
CREATE INDEX IF NOT EXISTS idx_written_in_book ON Written_In(ID);
CREATE INDEX IF NOT EXISTS idx_type_of_book ON Type_of(ID);
CREATE INDEX IF NOT EXISTS idx_is_in_pub_id ON Is_In(Publisher_ID);
CREATE INDEX IF NOT EXISTS idx_is_in_country_id ON Is_In(Country_ID);


-- Constraints (already in CreateTable)