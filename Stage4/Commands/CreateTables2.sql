-- We combined the schema of both groups

-- Creating language (of book) table
CREATE TABLE IF NOT EXISTS Language
(
  Language_ID INT NOT NULL,
  Name VARCHAR(1000) NOT NULL,
  PRIMARY KEY (Language_ID)
);
-- Creating publisher (of book) table
CREATE TABLE IF NOT EXISTS Publisher
(
  Name VARCHAR(1000) NOT NULL,
  Phone_Number VARCHAR(200) NOT NULL,
  Website VARCHAR(1000),
  Publisher_ID INT NOT NULL,
  PRIMARY KEY (Publisher_ID),
  UNIQUE (Phone_Number)
);

-- Creating author (of book) table
CREATE TABLE IF NOT EXISTS Author
(
  First_Name VARCHAR(1000) NOT NULL,
  Last_Name VARCHAR(1000) NOT NULL,
  Date_of_Birth DATE NOT NULL CHECK (Date_of_Birth <= CURRENT_DATE),
  Author_ID INT NOT NULL,
  Biography VARCHAR(1000) NOT NULL,
  PRIMARY KEY (Author_ID)
);

-- Creating genre/category (of book) table
CREATE TABLE IF NOT EXISTS Genre
(
  Name VARCHAR(1000) NOT NULL,
  Description VARCHAR(1000),
  Genre_ID INT NOT NULL,
  PRIMARY KEY (Genre_ID)
);

-- Creating country (of publisher)
CREATE TABLE IF NOT EXISTS Country
(
  Name VARCHAR(1000) NOT NULL,
  Country_ID INT NOT NULL,
  PRIMARY KEY (Country_ID)
);

-- Creating written by table (author writes book)
CREATE TABLE IF NOT EXISTS Written_By
(
  ID BIGINT NOT NULL,
  Author_ID INT NOT NULL,
  PRIMARY KEY (ID, Author_ID),
  FOREIGN KEY (ID) REFERENCES Book(ID) ON DELETE RESTRICT,
  FOREIGN KEY (Author_ID) REFERENCES Author(Author_ID) ON DELETE RESTRICT
);

-- Creating published by table (book published by publisher)
CREATE TABLE IF NOT EXISTS Published_By
(
  ID BIGINT NOT NULL,
  Publisher_ID INT NOT NULL,
  PRIMARY KEY (ID, Publisher_ID),
  FOREIGN KEY (ID) REFERENCES Book(ID) ON DELETE RESTRICT,
  FOREIGN KEY (Publisher_ID) REFERENCES Publisher(Publisher_ID) ON DELETE RESTRICT
);

-- Creating written in book table (book written in language)
CREATE TABLE IF NOT EXISTS Written_In
(
  ID BIGINT NOT NULL,
  Language_ID INT NOT NULL,
  PRIMARY KEY (ID, Language_ID),
  FOREIGN KEY (ID) REFERENCES Book(ID)  ON DELETE RESTRICT,
  FOREIGN KEY (Language_ID) REFERENCES Language(Language_ID) ON DELETE RESTRICT
);

-- Creating type of table (book type is genre - e.g. Dune is sci-fi)
CREATE TABLE IF NOT EXISTS Type_of
(
  ID BIGINT NOT NULL,
  Genre_ID INT NOT NULL,
  PRIMARY KEY (ID, Genre_ID),
  FOREIGN KEY (ID) REFERENCES Book(ID) ON DELETE RESTRICT,
  FOREIGN KEY (Genre_ID) REFERENCES Genre(Genre_ID) ON DELETE RESTRICT
);

-- Creating is in table (publisher is situated in Country e.g. Random House is in the US)
CREATE TABLE IF NOT EXISTS Is_In
(
  Publisher_ID INT NOT NULL,
  Country_ID INT NOT NULL,
  PRIMARY KEY (Publisher_ID, Country_ID),
  FOREIGN KEY (Publisher_ID) REFERENCES Publisher(Publisher_ID) ON DELETE RESTRICT,
  FOREIGN KEY (Country_ID) REFERENCES Country(Country_ID) ON DELETE RESTRICT
);

-- Creating location (in library) table
CREATE TABLE IF NOT EXISTS Location
(
  Quantity INT NOT NULL CHECK (Quantity > 0), 
  Floor VARCHAR(1000) NOT NULL,
  Shelf INT NOT NULL CHECK (Shelf >= 1),
  Location_ID INT NOT NULL,
  Condition VARCHAR(1000) NOT NULL,
  ID INT NOT NULL,
  Archive_Number INT,
  PRIMARY KEY (Location_ID),
  FOREIGN KEY (ID) REFERENCES Book(ID) ON DELETE RESTRICT,
  FOREIGN KEY (Archive_Number) REFERENCES Archive(Archive_Number)
);

CREATE TABLE Book
(
  Title VARCHAR(1000) NOT NULL,
  ID BIGINT NOT NULL,
  Release_Date DATE NOT NULL CHECK (Release_Date <= CURRENT_DATE),
  Page_Count INT NOT NULL CHECK (Page_Count >= 1),
  Format VARCHAR(1000) NOT NULL,
  Description VARCHAR(1000) NOT NULL,
  ISBN INT NOT NULL,
  Rarity VARCHAR(30) NOT NULL,
  Location_ID INT NOT NULL,
  PRIMARY KEY (ID),
  FOREIGN KEY (Location_ID) REFERENCES Location(Location_ID),
  UNIQUE (ISBN)
);

-- Creating employee table
CREATE TABLE Employee
(
  Role VARCHAR(20) NOT NULL,
  Age INT NOT NULL,
  Salary INT NOT NULL,
  Employee_ID INT NOT NULL,
  Name VARCHAR(50) NOT NULL,
  PRIMARY KEY (Employee_ID)
);

-- Creating archive table
CREATE TABLE Archive
(
  Archive_Number INT NOT NULL,
  Book_Type VARCHAR(20) NOT NULL, -- govermental, public, private
  PRIMARY KEY (Archive_Number)
);

CREATE TABLE Disposal
(
  Date DATE NOT NULL,
  Disposal_ID INT NOT NULL,
  Method VARCHAR(300) NOT NULL,
  Material_of_Book VARCHAR(50) NOT NULL,
  ID BIGINT NOT NULL,
  Employee_ID INT NOT NULL,
  PRIMARY KEY (Disposal_ID),
  FOREIGN KEY (ID) REFERENCES Book(ID),
  FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID)
);

CREATE TABLE Upkeep
(
  Upkeep_ID INT NOT NULL,
  Tools_used VARCHAR(300) NOT NULL,
  Reason_for_Upkeep VARCHAR(300) NOT NULL,
  Date DATE NOT NULL,
  ID BIGINT NOT NULL,
  Employee_ID INT NOT NULL,
  PRIMARY KEY (Upkeep_ID),
  FOREIGN KEY (ID) REFERENCES Book(ID),
  FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID)
);

CREATE TABLE Archival_Assignment
(
  Assignment_ID INT NOT NULL,
  Date DATE NOT NULL,
  ID BIGINT NOT NULL,
  Employee_ID INT NOT NULL,
  Archive_Number INT NOT NULL,
  New_LocationArchive_Number INT NOT NULL,
  PRIMARY KEY (Assignment_ID),
  FOREIGN KEY (ID) REFERENCES Book(ID),
  FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID),
  FOREIGN KEY (Archive_Number) REFERENCES Archive(Archive_Number),
  FOREIGN KEY (New_LocationArchive_Number) REFERENCES Archive(Archive_Number)
);