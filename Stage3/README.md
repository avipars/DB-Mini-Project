# BookDB Stage 3

### Authors: Avi Parshan and Leib Blam

##### Things worth knowing

<details>
<summary>Extract Extra DB Info</summary>

   * In PSQL Shell Enter:

        * `\di` to get general info
        * `\d` to get relation info... can do `\d author` to get specific information about the Author table for example
        * `VACUUM;` to clear up old space in the database (and also works on indexes)
</details>
<details>
<summary>Restore DB with Indexes</summary>

   * Restore backupPSQL (binary format) with Indexes

      ```bash
      pg_restore -U postgres -d postgres -v --clean --if-exists --disable-triggers --no-owner --no-privileges --format=c "backupPSQLIndex.sql"
      ```

        Ensure you are in the [Stage2 Folder](https://gitlab.com/avipars/db-lfs/-/tree/main/Stage2)
</details>
<details>
<summary>Dropping tables</summary>

* Use [DropTables.sql](https://github.com/avipars/DB-Mini-Project/blob/main/Stage3/Commands/DropItems.sql) first to drop the Stage 3 additions. Afterwards, you can run the [DropTables.sql](https://github.com/avipars/DB-Mini-Project/blob/main/Stage1/Commands/DropTables.sql) from Stage 1 to remove all tables.

</details>

   
### Queries 

#### [Join Queries](https://github.com/avipars/DB-Mini-Project/blob/main/Stage3/Queries/JoinQueries.sql)

- To avoid confusion with the previous stage's Queries.sql file, we have created a new file specifically for the join queries in this stage.

1. This query joins the Book, Written_By, and Author tables to get the first and last name of the author of a book with a specific ID

    ```sql
    SELECT 
        Author.First_Name, 
        Author.Last_Name
    FROM Book
    JOIN 
        Written_By ON Book.ID = Written_By.ID
    JOIN 
        Author ON Written_By.Author_ID = Author.Author_ID
    WHERE Book.ID = 2;
    ```


2. This query updates all the books published by Murray-Jenkins to Good Condition

    ```sql
    UPDATE Location
    SET Condition = 'Good'
    WHERE ID IN (
        SELECT B.ID
        FROM Book B
        JOIN 
            Written_By WB ON B.ID = WB.ID
        JOIN 
            Author A ON WB.Author_ID = A.Author_ID
        JOIN 
            Published_By PB ON B.ID = PB.ID
        JOIN 
            Publisher P ON PB.Publisher_ID = P.Publisher_ID
        WHERE P.Name = 'Murray-Jenkins');
    ```

3. This query joins the Publisher, Is_In, and Country tables to get the name of the country where a specific publisher is located

    ```sql
    SELECT Country.Name
    FROM Publisher
    JOIN 
        Is_In ON Publisher.Publisher_ID = Is_In.Publisher_ID
    JOIN 
        Country ON Is_In.Country_ID = Country.Country_ID
    WHERE Publisher.Publisher_ID = 1;
    ```

4. This query selects all books with more than 10 pages and where the book was released within 10 years of the author being born, taking the first 5 results

    ```sql
    SELECT
        b.ID AS Book_ID, 
        b.Release_Date, 
        a.Date_of_Birth
    FROM Book b
    JOIN 
        Written_By wb ON b.ID = wb.ID
    JOIN 
        Author a ON wb.Author_ID = a.Author_ID
    WHERE 
        b.Release_Date < (a.Date_of_Birth + INTERVAL '10 years') 
        AND b.Page_Count > 10
    LIMIT 5;
    ```

#### Timings 

| Query Number | Normal Runtime (ms) | Runtime With Indexes (ms) |
| ------------ | ------------------- | ------------------------- |
| 1            | 4.033               | 2.521                     |
| 2            | 29.940              | 6.404                     |
| 3            | 2.936               | 1.332                     |
| 4            | 2.416               | 1.083                     |

[Logs for Queries](https://github.com/avipars/DB-Mini-Project/blob/main/Stage3/Queries/JoinQueriesTime.log)

[Logs for Queries with Indexing](https://github.com/avipars/DB-Mini-Project/blob/main/Stage3/Queries/IndexJoinQueriesTime.log)


### [Views](https://github.com/avipars/DB-Mini-Project/blob/main/Stage3/Views)

#### [Creating Views](https://github.com/avipars/DB-Mini-Project/blob/main/Stage3/Views/Views.sql)

* Providing a limited view of our database system:

    1. View details of available books to take out

    ```sql
    CREATE OR REPLACE VIEW Book_Detail_View AS
    SELECT 
        b.ID,
        b.Title,
        b.Release_Date,
        b.Page_Count,
        b.Format,
        b.Description,
        lo.Floor,
        lo.Shelf,
        g.Name AS Genre_Name,
        l.Name AS Language_Name,  
        p.Name AS Publisher_Name
    FROM Book b
    JOIN Type_of t ON b.ID = t.ID
    JOIN Genre g ON t.Genre_ID = g.Genre_ID
    JOIN Written_In wi ON b.ID = wi.ID
    JOIN Language l ON wi.Language_ID = l.Language_ID
    JOIN Published_By pb ON b.ID = pb.ID
    JOIN Publisher p ON pb.Publisher_ID = p.Publisher_ID
    JOIN Location lo ON b.ID = lo.ID
    WHERE lo.Floor NOT IN ('Storage', 'Maintenance', 'Special Collections', 'Archive', 'Returns') 
    AND lo.Quantity >= 1;  -- Ensure books are available for loan
    ```

    2. View of all publishers with ability to manage them

    ```sql
    CREATE OR REPLACE VIEW Publisher_Detail_View AS 
    SELECT 
        p.Publisher_ID,
        p.Name,
        p.Phone_Number,
        p.Website
    FROM Publisher p;
    ```


    3. View of authors and books they wrote

    ```sql
    CREATE OR REPLACE VIEW Author_Books_View AS
    SELECT
        a.Author_ID,
        a.Date_of_Birth,
        a.Biography,
        b.ID,
        b.Title,
        CONCAT(a.First_Name, ' ', a.Last_Name) AS Author_Name
    FROM 
        Author a
    JOIN Written_By wb ON a.Author_ID = wb.Author_ID
    JOIN Book b ON wb.ID = b.ID;
    ```


    4. View of book quantity per Genre

    ```sql
    CREATE OR REPLACE VIEW Genre_Location_Popularity_View AS
    SELECT 
        g.Name AS Genre_Name,
        SUM(lo.Quantity) AS Total_Copies_Available,
        COUNT(DISTINCT b.ID) AS Unique_Titles
    FROM Genre g
    JOIN Type_of t ON g.Genre_ID = t.Genre_ID
    JOIN Book b ON t.ID = b.ID
    JOIN Location lo ON b.ID = lo.ID
    GROUP BY g.Genre_ID, g.Name
    ORDER BY Total_Copies_Available DESC, Unique_Titles;
    ```


    [Logs for Views](https://github.com/avipars/DB-Mini-Project/blob/main/Stage3/Views/Views.log)

    [DB Dump for Views](https://gitlab.com/avipars/db-lfs/-/blob/main/Stage3/backupPSQLViews.sql)

#### [Querying via Views](https://github.com/avipars/DB-Mini-Project/blob/main/Stage3/Views/ViewQueries.sql)

* Testing the views via SELECT, INSERT, UPDATE, and DELETE statements: 

    * Any views that were based on several tables (or views that use GROUP BY) will not let you perform any modifications to the data

    * Publisher_Detail_View allows all of these commands, provided that the queries use abide by the existing database system rules

    [Logs for View Queries](https://github.com/avipars/DB-Mini-Project/blob/main/Stage3/Views/ViewQueries.log)

### [Visualizations](https://github.com/avipars/DB-Mini-Project/blob/main/Stage3/Visualizations)

I selected the following views to create visualizations of: 

View 3: Most popular birth month among authors

Pie Chart (Sorted by Month Number)

```sql
SELECT 
    TO_CHAR(a.Date_of_Birth, 'Month') AS Birth_Month, -- month name 
    COUNT(DISTINCT a.Author_ID) AS Author_Count, -- # of unique authors per month
    TO_CHAR(a.Date_of_Birth, 'MM') AS Month_Number -- Jan = '01'
FROM Author_Books_View a
WHERE 
    a.Date_of_Birth IS NOT NULL
GROUP BY 
    Birth_Month, Month_Number -- connect 2 columns
ORDER BY Month_Number; -- sort by month #
```

![months](https://github.com/user-attachments/assets/f0efddb0-30a8-40a1-a4f0-6b5c69c5a515)


View 4: Number of distinct books in each genre 

Bar Graph (Sorted from least to most unique titles)

```sql
SELECT 
    Genre_Name, 
    Total_Copies_Available, -- total copies of books in genre
    Unique_Titles  -- distinct titles in genre
From Genre_Location_Popularity_View 
ORDER BY Unique_Titles;
```

![unique_titles](https://github.com/user-attachments/assets/2aab045c-c574-4261-853a-26ff3119108a)


### [Functions](https://github.com/avipars/DB-Mini-Project/blob/main/Stage3/Functions/Functions.sql)

* We use the 4 queries from the joinQueries.sql from above and change them into Functions. Functions shows an approvement in time over regular queries. We write in the function CREATE OR REPLACE in order not the get double functions with the same name. Moreover, we define the Language the function is using with LANGUAGE plpgsql.

* To make our queries more reusable and less complex, we created the following 4 functions:

1. `GetAuthorNameByBookID(book_id INT)` - The first function returns the full name, first and last, of the author for a specific book, given by its book id. When we select the first name and last name attribute, we cast them into text and returning a Query back. We accept an Integer into our parameters and return all full names inside the query.

    ```sql
    CREATE OR REPLACE FUNCTION GetAuthorNameByBookID(book_id INT)
    RETURNS TABLE (first_name text, last_name text) AS $$
    BEGIN
        RETURN QUERY
            SELECT 
                CAST(a.First_Name AS text) AS first_name,
                CAST(a.Last_Name AS text) AS last_name
            FROM Book b
            JOIN Written_By w ON b.ID = w.ID
            JOIN Author a ON w.Author_ID = a.Author_ID
            WHERE b.ID = book_id;
    END;
    $$ LANGUAGE plpgsql;
    ```

2. `UpdateBooksConditionForPublisher(publisher_name VARCHAR, cond_name VARCHAR)` - The second function is a PROCEDURE, it updates the condition of all books written by an Publisher to a certain condition. The function accepts 2 parameters, publisher name as VARCHAR and condition name as VARCHAR and doesn't output any query in return.

    ```sql
    CREATE OR REPLACE PROCEDURE UpdateBooksConditionForPublisher(publisher_name VARCHAR, cond_name VARCHAR)
    LANGUAGE plpgsql
    AS $$
    BEGIN
        UPDATE Location
        SET condition = cond_name
        WHERE ID IN (
            SELECT B.ID
            FROM Book B
            JOIN Written_By WB ON B.ID = WB.ID
            JOIN Published_By PB ON B.ID = PB.ID
            JOIN Publisher P ON PB.Publisher_ID = P.Publisher_ID
            WHERE P.Name = publisher_name
        );
    END;
    $$;
    ```

3. `GetCountryByPublisherID(p_id INT)` - The third function returns the name of the country where a specific publisher is located. It accepts 1 parameter, publisher id as an Integer and returns a Table of all the names of the countries. To do so it declares country name to be a VARCHAR and puts the result into the Table and returns it out.

    ```sql
    CREATE OR REPLACE FUNCTION GetCountryByPublisherID(p_id INT)
    RETURNS TABLE (name VARCHAR) AS $$
    BEGIN
        RETURN QUERY
        SELECT c.Name
        FROM Publisher p
        JOIN Is_In ii ON p.Publisher_ID = ii.Publisher_ID
        JOIN Country c ON ii.Country_ID = c.Country_ID
        WHERE p.Publisher_ID = p_id;
    END;
    $$ LANGUAGE plpgsql;


    SELECT * FROM GetCountryByPublisherID(1);
    ```


4. `GetBooksReleasedWithin10YearsOfBirth(p_count INT, limit_count INT)` - The fourth function returns the first limit_count books with more than a p_count number of pages and released within 10 years of the author being born. It accepts two Integers as its parameters and returns a Table with Book id as Integer, Release Date as a Date, and Date of Birth of the Author as a DATE.

    ```sql
    CREATE OR REPLACE FUNCTION GetBooksReleasedWithin10YearsOfBirth(p_count INT, limit_count INT DEFAULT 5)
    RETURNS TABLE (
        Book_ID INT,
        Release_Date DATE,
        Date_of_Birth DATE
    ) AS $$
    BEGIN
        RETURN QUERY
        SELECT
            b.ID AS Book_ID, 
            b.Release_Date, 
            a.Date_of_Birth
        FROM Book b
        JOIN Written_By wb ON b.ID = wb.ID
        JOIN Author a ON wb.Author_ID = a.Author_ID
        WHERE 
            b.Release_Date < (a.Date_of_Birth + INTERVAL '10 years') 
            AND b.Page_Count > p_count
        LIMIT limit_count;
    END;
    $$ LANGUAGE plpgsql;
    ```

[Logs for Functions](https://github.com/avipars/DB-Mini-Project/blob/main/Stage3/Functions/Creation.log)

[DB Dump for Functions](https://gitlab.com/avipars/db-lfs/-/blob/main/Stage3/backupPSQLFunctions.sql)

#### Timing Functions

* Comparing function runtime with and without indexing

| Function Number | Runtime With Functions (ms) | Runtime With Functions and Indexing (ms) |
| ------------ | --------------------------- | ---------------------------------------- |
| 1            | 3.375                       | 0.73                                     |
| 2            | 27.598                      | 5.506                                    |
| 3            | 2.28                        | 0.505                                    |
| 4            | 1.398                       | 1.001                                    |

[Logs for running Functions](https://github.com/avipars/DB-Mini-Project/blob/main/Stage3/Functions/FunctionsTime.log)

[Logs for running Functions with Indexing](https://github.com/avipars/DB-Mini-Project/blob/main/Stage3/Functions/IndexFunctionsTime.log)

### Overall Timing

* By combining the previous two timing tables, we can get a better understanding of the overall performance of the database system

| Query/Function Number | Query Runtime (ms) | Query Runtime With Indexing (ms) | Runtime With Functions (ms) | Runtime With Functions and Indexing (ms) |
| ------------ | ------------------ | -------------------------------- | --------------------------- | ---------------------------------------- |
| 1            | 4.033              | 2.521                            | 3.375                       | 0.73                                     |
| 2            | 29.940             | 6.404                            | 27.598                      | 5.506                                    |
| 3            | 2.936              | 1.332                            | 2.28                        | 0.505                                    |
| 4            | 2.416              | 1.083                            | 1.398                       | 1.001                                    |

### [Triggers](https://github.com/avipars/DB-Mini-Project/blob/main/Stage3/Triggers/Trigger.sql)

To enhance logging capability and functionality of the database, we created 2 useful triggers: 

1. If a book gets deleted from the Book table, Log it in the Book_Log Table (new table created via Trigger.sql)

    * Functions: log_book_deletion()

    * Trigger Name: book_delete_trigger
    
    * Activated: After DELETE on Book Table

    * Tables Affected: Book_Log


    ```sql
    CREATE TABLE IF NOT EXISTS Book_Log
    (
    Log_ID SERIAL PRIMARY KEY,
    Book_ID INT NOT NULL,
    Title VARCHAR(1000) NOT NULL,
    Deleted_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

    CREATE OR REPLACE FUNCTION log_book_deletion()
    RETURNS TRIGGER AS $$
    BEGIN
    INSERT INTO Book_Log (Book_ID, Title, Deleted_At)
    VALUES (OLD.ID, OLD.Title, CURRENT_TIMESTAMP);

    RETURN OLD;
    END;
    $$ LANGUAGE plpgsql;
    ```


2. If a book is classified as an Ebook, automate location changes (Set condition, floor, shelf, quantity)

    * Functions: update_condition_for_ebook()

    * Trigger Name: update_condition_on_ebook_format, insert_condition_on_new_ebook

    * Activated: After a Book format changes on UPDATE in Book Table, or After a Book is INSERTED to the Book Table

    * Tables Affected: Book, Location

    * Note: If run via insert_condition_on_new_ebook, Location ID for these eBooks is the same as BookID for simplicity 


    ```sql
    CREATE OR REPLACE FUNCTION update_condition_for_ebook()
    RETURNS TRIGGER AS $$
    BEGIN
    -- Check if the book format is changed to 'eBook'
    IF TG_OP = 'UPDATE' AND NEW.Format = 'Ebook' AND OLD.Format != 'Ebook' THEN
        -- Update the Condition to 'NEW' in the Location table for the book
        UPDATE Location
        SET Condition = 'New', Floor = 'E-Library Section', Shelf = 1
        WHERE ID = NEW.ID;
    END IF;
        -- Handle when a new eBook is inserted
    IF TG_OP = 'INSERT' AND NEW.Format = 'Ebook' THEN
        -- Automatically add the eBook to the Location table with the 'New' condition and 'E-Library Section' floor
        INSERT INTO Location (Quantity, Floor, Shelf, Condition, ID, Location_ID)
        VALUES (1, 'E-Library Section', 1, 'New', NEW.ID, NEW.ID);
    END IF;


    RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    DROP TRIGGER IF EXISTS update_condition_on_ebook_format ON Book;

    CREATE TRIGGER update_condition_on_ebook_format
    AFTER UPDATE ON Book
    FOR EACH ROW
    WHEN (OLD.Format != NEW.Format AND NEW.Format = 'Ebook')
    EXECUTE FUNCTION update_condition_for_ebook();

    DROP TRIGGER IF EXISTS insert_condition_on_new_ebook ON Book;

    CREATE TRIGGER insert_condition_on_new_ebook
    AFTER INSERT ON Book
    FOR EACH ROW
    WHEN (NEW.Format = 'Ebook')
    EXECUTE FUNCTION update_condition_for_ebook();
    ```
[Logs for Triggers](https://github.com/avipars/DB-Mini-Project/blob/main/Stage3/Triggers/Trigger.log)

[DB Dump for Triggers](https://gitlab.com/avipars/db-lfs/-/blob/main/Stage3/backupPSQLTriggers.sql)

#### [Testing Trigger](https://github.com/avipars/DB-Mini-Project/blob/main/Stage3/Triggers/TestTrigger.sql)

Trigger 1: 
    
* Insert a sample book and then delete it. Afterwards, it shows up in a Journal Table called Book_Log

    After insertion into Book 

    | Title   | ID      | Release Date | Page Count | Format   | Description | ISBN      |
    |---------|---------|--------------|------------|----------|-------------|-----------|
    | Police  | 5000010 | 1884-05-21   | 1          | Magazine | Poster      | 322397558 |

    After deletion from Book

    | title  | id  | release_date | page_count | format | description | isbn |
    |--------|-----|--------------|------------|--------|-------------|------|


    After Insertion to Book_Log (by trigger)

    | log_id | book_id | title  | deleted_at                      |
    |--------|---------|--------|---------------------------------|
    | 1      | 5000010 | Police | 2024-12-08 21:45:48.635475     |

Trigger 2:

* Insert sample book in format other than Ebook. Update the format to Ebook, then the trigger will automatically change the Floor to E-Library Section, Condition to New, and Shelf to 1.

    Check Location Table for ID (we expect it to be empty at this stage)

    | quantity | floor | shelf | location_id | condition | id  |
    |----------|-------|-------|-------------|-----------|-----|
    |          |       |       |             |           |     |

    Check Book Table for ID 

    | title        | id     | release_date | page_count | format     | description                         | isbn      |
    |--------------|--------|--------------|------------|------------|-------------------------------------|-----------|
    | Physical Book | 100004 | 2024-01-02   | 349        | Hardcover  | A physical book with many pages.    | 123944679 |

    Now we insert into a location and then check table again

    | quantity | floor            | shelf | location_id | condition | id     |
    |----------|------------------|-------|-------------|-----------|--------|
    | 1        | Reference Section | 2     | 70002       | Used      | 100004 |

    After updating Format to Ebook, we check Location table (was changed by trigger)

    | quantity | floor             | shelf | location_id | condition | id     |
    |----------|-------------------|-------|-------------|-----------|--------|
    | 1        | E-Library Section  | 1     | 70002       | New       | 100004 |

    And also check the Book table for good measure

    | title        | id     | release_date | page_count | format | description                         | isbn      |
    |--------------|--------|--------------|------------|--------|-------------------------------------|-----------|
    | Physical Book | 100004 | 2024-01-02   | 349        | Ebook  | A physical book with many pages.    | 123944679 |

* Insert sample book in Ebook format. The trigger will automatically add an entry in the Location table coordinating to the E-Library Section, New Condition, Shelf number 1, Quantity of 1. 

    After insertion into Book and running a SELECT

    | title     | id      | release_date | page_count | format | description           | isbn      |
    |-----------|---------|--------------|------------|--------|-----------------------|-----------|
    | New eBook | 100009  | 2024-12-08   | 200        | Ebook  | An exciting new eBook! | 987684321 |

    After Insertion to Location (by trigger) and running a SELECT

    | quantity | floor             | shelf | location_id | condition | id     |
    |----------|-------------------|-------|-------------|-----------|--------|
    | 1        | E-Library Section | 1     | 100009      | New       | 100009 |

[Logs for Testing Triggers](https://github.com/avipars/DB-Mini-Project/blob/main/Stage3/Triggers/TestTrigger.log)

[DB Dumps for Triggers](https://gitlab.com/avipars/db-lfs/-/blob/main/Stage3/backupPSQLTriggers.sql?ref_type=heads)

[DB Dumps for Stage3](https://gitlab.com/avipars/db-lfs/-/tree/main/Stage3?ref_type=heads)