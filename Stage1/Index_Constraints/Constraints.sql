-- Indexes
-- Must haves -- 
CREATE INDEX idx_author_dob_id ON Author(Author_ID, Date_of_Birth); -- q1 


-- q2
CREATE INDEX idx_location_id ON Location(ID);
CREATE INDEX idx_type_of_genre_id ON Type_of(Genre_ID);
-- end q2

-- q3
CREATE INDEX IF NOT EXISTS idx_locale ON Location(ID, Condition, Quantity);
-- end q3

CREATE INDEX idx_book_page_count ON Book(Page_Count);
CREATE INDEX idx_book_page_count_id ON Book(ID, Page_Count);

CREATE INDEX idx_book_release_date ON Book(Release_Date);


-- speeds up book search by release date 
CREATE INDEX idx_location_quantity_condition ON Location(ID, Quantity);
-- location quantity and ID for q4, q8
CREATE INDEX idx_location_metrics ON Location(ID, Floor, Condition, Quantity);
-- for q6
CREATE INDEX idx_location_metrics ON Location(ID, Quantity, Condition);
-- for q7

-- Foreign keys -- 
CREATE INDEX idx_location_book ON Location(ID);

CREATE INDEX idx_written_by_author_id ON Written_By(Author_ID); -- q1
CREATE INDEX idx_written_by_book ON Written_By(ID);

CREATE INDEX idx_published_by_publisher_id ON Published_By(Publisher_ID);
CREATE INDEX idx_published_by_book ON Published_By(ID);

CREATE INDEX idx_written_in_language_id ON Written_In(Language_ID);
CREATE INDEX idx_written_in_book ON Written_In(ID);

CREATE INDEX idx_type_of_book ON Type_of(ID);

CREATE INDEX idx_is_in_pub_id ON Is_In(Publisher_ID);
CREATE INDEX idx_is_in_country_id ON Is_In(Country_ID);

-- CREATE INDEX idx_book_title ON Book(Title, Page_Count);
-- book search by title

-- CREATE INDEX idx_language_name ON Language(Name);
-- -- language name
-- CREATE INDEX idx_publisher_name ON Publisher(Name);
-- -- publisher name
-- CREATE INDEX idx_genre_name ON Genre(Name);
-- genre name

-- CREATE INDEX idx_location_floor ON Location(Floor);
-- -- location operations 
-- CREATE INDEX idx_location_condition ON Location(Condition);
-- location condition




-- CREATE INDEX idx_author_dob ON Author(Date_of_Birth);
-- -- author DOB
-- CREATE INDEX idx_author_name ON Author(First_Name, Last_Name);
-- author name



-- -- foreign key





-- Constraints

-- TODO CHANGE THIS (OLD)



-- Book quantity is 0 or more
ALTER TABLE Location
ADD CONSTRAINT Book_Quantity CHECK (Quantity >= 0);

-- Shelf number is 0 or more
ALTER TABLE Location
ADD CONSTRAINT Shelf_Min CHECK (Shelf >= 0);

-- Book page count is 0 or more (for digital books)
ALTER TABLE Book
ADD CONSTRAINT Page_Min CHECK (Page_Count >= 0);

-- Book ISBN is unique
ALTER TABLE Book
ADD CONSTRAINT ISBN_Unique UNIQUE (ISBN);

-- Release date is not in the future
ALTER TABLE Book
ADD CONSTRAINT Release_Future CHECK (Release_Date <= CURRENT_DATE);

-- DOB is not in the future
ALTER TABLE Author
ADD CONSTRAINT DOB_Future CHECK (Date_of_Birth <= CURRENT_DATE);

-- Book has a publisher
ALTER TABLE Published_By
ADD CONSTRAINT Publisher_Exists FOREIGN KEY (Publisher_ID) REFERENCES Publisher(Publisher_ID);