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