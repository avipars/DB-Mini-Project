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
-- Constraints for Update
-- Update ID in Published_By
ALTER TABLE Published_By
ADD CONSTRAINT fk_publisher_update
FOREIGN KEY (Publisher_ID) REFERENCES Publisher(Publisher_ID)
ON UPDATE CASCADE;
-- Update ID in Written_By
ALTER TABLE Written_By
ADD CONSTRAINT fk_author_update
FOREIGN KEY (Author_ID) REFERENCES Author(Author_ID)
ON UPDATE CASCADE;
-- Update ID in Written_In
ALTER TABLE Written_In
ADD CONSTRAINT fk_language_update
FOREIGN KEY (Language_ID) REFERENCES Language(Language_ID)
ON UPDATE CASCADE;
-- Update ID in Type_of
ALTER TABLE Type_of
ADD CONSTRAINT fk_genre_update
FOREIGN KEY (Genre_ID) REFERENCES Genre(Genre_ID)
ON UPDATE CASCADE;
-- Update ID in Location
ALTER TABLE Location
ADD CONSTRAINT fk_book_update
FOREIGN KEY (ID) REFERENCES Book(ID)
ON UPDATE CASCADE;
-- Update ID in Is_In
ALTER TABLE Is_In
ADD CONSTRAINT fk_country_update
FOREIGN KEY (Country_ID) REFERENCES Country(Country_ID)
ON UPDATE CASCADE;
-- Make sure that pages are not negative on update
ALTER TABLE Book
ADD CONSTRAINT ck_page_count
CHECK (Page_Count >= 0);
-- Make sure that shelf is not negative on update
ALTER TABLE Location
ADD CONSTRAINT ck_shelf
CHECK (Shelf >= 0);
-- Make sure that quantity is not negative on update
ALTER TABLE Location
ADD CONSTRAINT ck_quantity
CHECK (Quantity >= 0);
-- Make sure that release date is not in the future
ALTER TABLE Book
ADD CONSTRAINT ck_release_date
CHECK (Release_Date <= CURRENT_DATE);
-- Make sure that Date of Birth is not in the future
ALTER TABLE Author
ADD CONSTRAINT ck_dob
CHECK (Date_of_Birth <= CURRENT_DATE);
-- Make sure that ISBN is unique
ALTER TABLE Book
ADD CONSTRAINT uq_isbn
UNIQUE (ISBN);
-- Make sure that phone number is unique
ALTER TABLE Publisher
ADD CONSTRAINT uq_phone_number
UNIQUE (Phone_Number);

-- Constraints for Delete
-- Delete book from location
ALTER TABLE Location
ADD CONSTRAINT fk_book_location
FOREIGN KEY (ID) REFERENCES Book(ID)
ON DELETE CASCADE;
-- Delete author from written_by
ALTER TABLE Written_By
ADD CONSTRAINT fk_author_written_by
FOREIGN KEY (Author_ID) REFERENCES Author(Author_ID)
ON DELETE CASCADE;
-- Delete publisher from published_by
ALTER TABLE Published_By
ADD CONSTRAINT fk_publisher_published_by
FOREIGN KEY (Publisher_ID) REFERENCES Publisher(Publisher_ID)
ON DELETE CASCADE;
-- Delete language from written_in
ALTER TABLE Written_In
ADD CONSTRAINT fk_language_written_in
FOREIGN KEY (Language_ID) REFERENCES Language(Language_ID)
ON DELETE CASCADE;
-- Delete genre from type_of
ALTER TABLE Type_of
ADD CONSTRAINT fk_genre_type_of
FOREIGN KEY (Genre_ID) REFERENCES Genre(Genre_ID)
ON DELETE CASCADE;
-- Delete country from is_in
ALTER TABLE Is_In
ADD CONSTRAINT fk_country_is_in
FOREIGN KEY (Country_ID) REFERENCES Country(Country_ID)
ON DELETE CASCADE;
-- Delete author from author
ALTER TABLE Author
ADD CONSTRAINT fk_author_author
FOREIGN KEY (Author_ID) REFERENCES Written_By(Author_ID)
ON DELETE CASCADE;
-- Delete book from book
ALTER TABLE Book
ADD CONSTRAINT fk_book_book
FOREIGN KEY (ID) REFERENCES Written_By(ID)
ON DELETE CASCADE;
-- Delete publisher from publisher
ALTER TABLE Publisher
ADD CONSTRAINT fk_publisher_publisher
FOREIGN KEY (Publisher_ID) REFERENCES Published_By(Publisher_ID)
ON DELETE CASCADE;
-- Delete language from language
ALTER TABLE Language
ADD CONSTRAINT fk_language_language
FOREIGN KEY (Language_ID) REFERENCES Written_In(Language_ID)
ON DELETE CASCADE;
-- Delete genre from genre
ALTER TABLE Genre
ADD CONSTRAINT fk_genre_genre
FOREIGN KEY (Genre_ID) REFERENCES Type_of(Genre_ID)
ON DELETE CASCADE;
-- Delete country from country
ALTER TABLE Country
ADD CONSTRAINT fk_country_country
FOREIGN KEY (Country_ID) REFERENCES Is_In(Country_ID)
ON DELETE CASCADE;
-- Delete location from location
ALTER TABLE Location
ADD CONSTRAINT fk_location_location
FOREIGN KEY (ID) REFERENCES Location(ID)
ON DELETE CASCADE;


