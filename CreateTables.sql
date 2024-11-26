-- Creating book table
CREATE TABLE B-- Creating book tableook
(
  Title VARCHAR(1000) NOT NULL,
  ID INT NOT NULL,
  Release_Date DATE NOT NULL,
  Page_Count INT NOT NULL,
  Format VARCHAR(1000) NOT NULL,
  Description VARCHAR(1000) NOT NULL,
  ISBN INT NOT NULL,
  PRIMARY KEY (ID),
  UNIQUE (ISBN)
);

-- Creating language (of book) table
CREATE TABLE Language
(
  Language_ID INT NOT NULL,
  Name VARCHAR(1000) NOT NULL,
  PRIMARY KEY (Language_ID)
);

-- Creating location (in library) table
CREATE TABLE Location
(
  Quantity INT NOT NULL,
  Floor VARCHAR(1000) NOT NULL,
  Shelf INT NOT NULL,
  Location_ID INT NOT NULL,
  Condition VARCHAR(1000) NOT NULL,
  ID INT NOT NULL,
  PRIMARY KEY (Location_ID),
  FOREIGN KEY (ID) REFERENCES Book(ID)
);

-- Creating publisher (of book) table
CREATE TABLE Publisher
(
  Name VARCHAR(1000) NOT NULL,
  Phone_Number VARCHAR(200) NOT NULL,
  Website VARCHAR(1000),
  Publisher_ID INT NOT NULL,
  PRIMARY KEY (Publisher_ID),
  UNIQUE (Phone_Number)
);

-- Creating author (of book) table
CREATE TABLE Author
(
  First_Name VARCHAR(1000) NOT NULL,
  Last_Name VARCHAR(1000) NOT NULL,
  Date_of_Birth DATE NOT NULL,
  Author_ID INT NOT NULL,
  Biography VARCHAR(1000) NOT NULL,
  PRIMARY KEY (Author_ID)
);

-- Creating genre/category (of book) table
CREATE TABLE Genre
(
  Name VARCHAR(1000) NOT NULL,
  Description VARCHAR(1000),
  Genre_ID INT NOT NULL,
  PRIMARY KEY (Genre_ID)
);

-- Creating country (of publisher)
CREATE TABLE Country
(
  Name VARCHAR(1000) NOT NULL,
  Country_ID INT NOT NULL,
  PRIMARY KEY (Country_ID)
);

-- Creating written by table (author writes book)
CREATE TABLE Written_By
(
  ID INT NOT NULL,
  Author_ID INT NOT NULL,
  PRIMARY KEY (ID, Author_ID),
  FOREIGN KEY (ID) REFERENCES Book(ID),
  FOREIGN KEY (Author_ID) REFERENCES Author(Author_ID)
);

-- Creating published by table (book published by publisher)
CREATE TABLE Published_By
(
  ID INT NOT NULL,
  Publisher_ID INT NOT NULL,
  PRIMARY KEY (ID, Publisher_ID),
  FOREIGN KEY (ID) REFERENCES Book(ID),
  FOREIGN KEY (Publisher_ID) REFERENCES Publisher(Publisher_ID)
);

-- Creating written in book table (book written in language)
CREATE TABLE Written_In
(
  ID INT NOT NULL,
  Language_ID INT NOT NULL,
  PRIMARY KEY (ID, Language_ID),
  FOREIGN KEY (ID) REFERENCES Book(ID),
  FOREIGN KEY (Language_ID) REFERENCES Language(Language_ID)
);

-- Creating type of table (book type is genre - e.g. Dune is sci-fi)
CREATE TABLE Type_of
(
  ID INT NOT NULL,
  Genre_ID INT NOT NULL,
  PRIMARY KEY (ID, Genre_ID),
  FOREIGN KEY (ID) REFERENCES Book(ID),
  FOREIGN KEY (Genre_ID) REFERENCES Genre(Genre_ID)
);

-- Creating is in table (publisher is situated in Country e.g. Random House is in the US)
CREATE TABLE Is_In
(
  Publisher_ID INT NOT NULL,
  Country_ID INT NOT NULL,
  PRIMARY KEY (Publisher_ID, Country_ID),
  FOREIGN KEY (Publisher_ID) REFERENCES Publisher(Publisher_ID),
  FOREIGN KEY (Country_ID) REFERENCES Country(Country_ID)
);