-- Indexes

-- Index on Genre.Name for fast lookups when filtering by genre
CREATE INDEX IF NOT EXISTS idx_genre_name ON Genre(Name);

-- Index on Written_By.Author_ID for fast joins with the Author table
CREATE INDEX IF NOT EXISTS idx_written_by_author_id ON Written_By(Author_ID);

-- Index on Written_By.ID for joining with Book table
CREATE INDEX IF NOT EXISTS idx_written_by_id ON Written_By(ID);

-- Index on Type_of.Genre_ID for fast joins with Genre table
CREATE INDEX IF NOT EXISTS idx_type_of_genre_id ON Type_of(Genre_ID);

-- Index on Book.ID for joining with Written_By and Type_of tables
CREATE INDEX IF NOT EXISTS idx_book_id ON Book(ID);

-- Index on Language.Name for fast lookups when filtering by language
CREATE INDEX IF NOT EXISTS idx_language_name ON Language(Name);

-- Index on Written_In.Language_ID for fast joins with Language table
CREATE INDEX IF NOT EXISTS idx_written_in_language_id ON Written_In(Language_ID);

-- Index on Written_In.ID for joining with Book table
CREATE INDEX IF NOT EXISTS idx_written_in_id ON Written_In(ID);

-- Index on Book.ID for joining with Written_In table
CREATE INDEX IF NOT EXISTS idx_book_id_on_written_in ON Book(ID);

-- Index on Book.Title for fast lookups when filtering by book title
CREATE INDEX IF NOT EXISTS idx_book_title ON Book(Title);

-- Index on Published_By.Publisher_ID for fast joins with the Publisher table
CREATE INDEX IF NOT EXISTS idx_published_by_publisher_id ON Published_By(Publisher_ID);

-- Index on Published_By.ID for joining with Book table
CREATE INDEX IF NOT EXISTS idx_published_by_id ON Published_By(ID);

-- Index on Publisher.Publisher_ID for fast joins with Published_By table
CREATE INDEX IF NOT EXISTS idx_publisher_id ON Publisher(Publisher_ID);

-- Index on Publisher.Name for fast lookups when filtering by publisher name
CREATE INDEX IF NOT EXISTS idx_publisher_name ON Publisher(Name);

-- Index on Book.ID for joining with Published_By table
CREATE INDEX IF NOT EXISTS idx_book_id_on_published_by ON Book(ID);