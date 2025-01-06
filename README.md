# BookDB 5785

## Authors: Leib Blam and Avi Parshan

### Requirements

PostgreSQL 17

PGAdmin 4 version 8.11

### Disclaimer

This library book database system was created solely for educational and demonstration purposes. All data contained within is entirely fabricated and does not represent any real-world information. Any resemblance to actual book titles, authors, or other entities is purely coincidental and unintentional. 

### Description

README files are included in each stage folder to provide a detailed explanation of the project's progress and the steps taken to achieve the final product

### Stages 

[Stage 1 + 2](https://github.com/avipars/DB-Mini-Project/blob/main/Stage1)

[Stage 3](https://github.com/avipars/DB-Mini-Project/blob/main/Stage3)

<!-- [Stage 4](https://github.com/avipars/DB-Mini-Project/blob/main/Stage4/README.md) -->

### Dumps 

[Gitlab for LFS](https://gitlab.com/avipars/db-lfs/-/tree/main?ref_type=heads)

Also available in the Github Releases section.


#  Stage 1 and Stage 2

## Stage 1 
### Project Proposal

Build a database system to manage books in a library.  

## Features and Functionalities  
1. **Coding Systems**  
   - Internal Code: Unique identifiers for internal processes.  
   - International Code: Integration with global standards like ISBN.  
2. **Location Tracking**  
   - Make it easier for librarians and patrons to find books based on floor and shelf. 
3. **Condition Monitoring**  
   - Track each book's condition assists librarians with inventory management and overall quality. 
4. **Copies Management**  
   - Total copies available per title.  

### [Design](https://github.com/avipars/DB-Mini-Project/tree/main/Stage1/Diagrams)
   * ERD
  ![BookERDMap](https://github.com/user-attachments/assets/fced78de-3de6-4077-bf7a-27c7f376a003)

   * DSD
![BookDSDMap](https://github.com/user-attachments/assets/2ab45822-aaa7-43cc-a443-a6fd51166b28)

   Main Entities: 
   * Book
   * Genre
   * Location
   * Language
   * Author
   * Publisher
   * Country

   Screenshots and erdplus json files are [here](https://github.com/avipars/DB-Mini-Project/tree/main/Stage1/Diagrams)

### Data Generation
   * Schema Definition [CreateTables.sql](https://github.com/avipars/DB-Mini-Project/blob/main/Stage1/Commands/CreateTables.sql) is the script used to create the tables with the required schema.
   * Utilizing [sampleDataCreation.py](https://github.com/avipars/DB-Mini-Project/blob/main/Stage1/Data_Samples/sampleDataCreation.py) we created SQL insert statements that deal with 100.000 Books, 5.000 Authors, 30.000 Publishers, and 70.000 Locations. 
   * Each SQL file can be found in the [Data Samples Directory](https://github.com/avipars/DB-Mini-Project/blob/main/Stage1/Data_Samples/data/)
   
   Run the SQL files in the following order: 
   1. Schema definition **CreateTables.sql**
   2. Data:

      Country
         - **Independent table**.
         - Script: `random_countries.sql`
         - Rows: 24

      Publisher
         - **Depends on Country** for `Is_In` table.
         - Script: `random_publishers.sql`
         - Rows: 30,000

      Author
         - **Independent table**.
         - Script: `random_authors.sql`
         - Rows: 5,000

      Language
         - **Independent table**.
         - Script: `random_languages.sql`
         - Rows: 63

      Genre
         - **Independent table**.
         - Script: `random_genres.sql`
         - Rows: 77

      Book
         - **Independent table** but referenced by several others.
         - Script: `random_books.sql`
         - Rows: 100,000

      Location
         - **Depends on Book**.
         - Script: `random_locations.sql`
         - Rows: 70,000

      Written_By
         - **Depends on Book and Author**.
         - Script: `written_by.sql`
         - Rows: 132,820
         
      Published_By
         - **Depends on Book and Publisher**.
         - Script: `published_by.sql`
         - Rows: 124,848

      Written_In
         - **Depends on Book and Language**.
         - Script: `written_in.sql`
         - Rows: 125,087

      Type_of
         - **Depends on Book and Genre**.
         - Script: `type_of.sql`
         - Rows: 124,741
         
      Is_In
         - **Depends on Publisher and Country**.
         - Script: `is_in.sql`
         - Rows: 37,134


![Screenshot 2024-12-03 155347](https://github.com/user-attachments/assets/bdbb31a5-5764-4919-8b04-1b8ef1238c82)

## Stage 2

### Create Tables in PostgreSQL

* ![image](https://github.com/user-attachments/assets/a8f66d3d-50f3-49a1-9e3b-1e6cf1d12e80)

Click Query Tool

Now open the [CreateTables.sql](https://github.com/avipars/DB-Mini-Project/blob/main/Stage1/Commands/CreateTables.sql) script via Open File
![image](https://github.com/user-attachments/assets/bc311280-e445-4e25-8762-7236a0ff5b81)

And click execute script

![image](https://github.com/user-attachments/assets/47706ba8-9894-4da4-ba39-d22338730f4f)

[Log for table creation, dump](https://github.com/avipars/DB-Mini-Project/blob/main/Stage1/Commands/Command.log)


### Load data

In a similar fashion to the CreateData.sql script, we now bring in each sql file and execute them in the order listed above

[Log for loading data](https://github.com/avipars/DB-Mini-Project/blob/main/Stage1/Data_Samples/data/Inserts.log)

### Dump Data
<!-- (our table name is postgres and password is admin) -->
Via command line, we can dump the data from the database into a file. 
--clean to first drop tables
--if-exists to avoid errors if tables do not exist

* backupSQL (with DROP . . . CREATE . . . INSERT)
   Settled on 1000 rows per insert to balance speed and file size.
   --create to include create table statements
   --inserts to include insert statements

   ```bash
   pg_dump -U postgres -d postgres -v -f "backupSQL.sql" --create --clean --if-exists --inserts --rows-per-insert "1000" 2>backupSQL.log
   ```

* backupPSQL (binary format) 

   ```bash
   pg_dump -U postgres -d postgres -v -f "backupPSQL.sql" --format=c --create --clean --if-exists 2>backupPSQL.log
   ```

   Full dumps and logs are [here](https://gitlab.com/avipars/db-lfs/-/tree/main/Stage1?ref_type=heads)
  
### Restore Data 

   * Restore backupPSQL (binary format)

      Send logs to be appended to original log file, disable triggers helps us avoid future constraint issues with order of insertion into the table (preventative measure).
      No owner and no privileges to avoid potential issues with permissions.
      
      ```bash
      pg_restore -U postgres -d postgres -v --clean --if-exists --disable-triggers --no-owner --no-privileges --format=c "backupPSQL.sql" 2>>"backupPSQL.log"
      ```

     [Log for dump, restore](https://gitlab.com/avipars/db-lfs/-/blob/main/Stage1/backupPSQL.log?ref_type=heads)
     
### Queries 

#### [Basic Queries](https://github.com/avipars/DB-Mini-Project/blob/main/Stage1/Queries/Queries.sql)

   SELECT: 
   * (Query 1) Find the 5 oldest authors (Name, DOB) who published at least 1 book in the database
   * (Query 2) Average page count for Science books with > 5 copies in subpar condition (taking up shelf space)
   * (Query 3) Get books with the highest amount of pages that are in stock in decent condition
   * (Query 4) Get book in english with the fewest pages

   UPDATE: 
   * (Query 5) Change all books (with 2 or more pages) released between 1999-12-28 and 1999-12-31 to 2000-01-01 
   * (Query 6) Move all returned Children's books from Returns that are in decent condition to the Kids Corner

   DELETE:
   * (Query 7) Delete books with 0 copies that are moldy or damaged
   * (Query 8) Delete all books written in Russian that have more than 90 copies in stock

   [Logs with timings](https://github.com/avipars/DB-Mini-Project/blob/main/Stage1/Queries/QueriesTime.log)
 
####  [Parameterized Queries](https://github.com/avipars/DB-Mini-Project/blob/main/Stage1/Queries/ParamerizedQueries.sql)

   * (Query 9) Top N prolific authors in a genre (who wrote the most books in that genre)
   * (Query 10) Top N books written in a specified language
   * (Query 11) All publishers associated with a specified book
   * (Query 12) All books published by a specified publisher

   [Logs with timings](https://github.com/avipars/DB-Mini-Project/blob/main/Stage1/Queries/ParamQueriesTime.log)

### [Indexing](https://github.com/avipars/DB-Mini-Project/blob/main/Stage1/Index_Constraints/Constraints.sql)

To optimize the performance of queries on the database, we created indexes on the columns that are frequently used.
Additionally, all foreign keys for each table are also used as indexes (This helps for referential integrity, as it prevents data being deleted when its referenced elsewhere).

* [Logs for indexing](https://github.com/avipars/DB-Mini-Project/blob/main/Stage1/Index_Constraints/Index.log)

* [DB Dump after Indexing](https://gitlab.com/avipars/db-lfs/-/tree/main/Stage2?ref_type=heads)

### Timing

(1 to 8 are basic queries, 9 to 13 are parameterized)

| Query Number | Normal Runtime (ms) | Runtime With Indexes (ms) |
| ------------ | ------------------- | ------------------------- |
| 1            | 84.207              | 80.004                    |
| 2            | 32.147              | 5.371                     |
| 3            | 31.784              | 11.209                    |
| 4            | 25.110              | 13.830                    |
| 5            | 11.120              | 12.255                    |
| 6            | 321.113             | 7.711                     |
| 7            | 53.818              | 10.199                    |
| 8            | 113.304             | 28.650                    |
| 9            | 55.366              | 11.174                    |
| 10           | 16.055              | 6.270                     |
| 11           | 8.349               | 8.538                     |
| 12           | 12.886              | 2.713                     |

* Logs and queries are found [here](https://github.com/avipars/DB-Mini-Project/blob/main/Stage1/Queries/)

### Constraints

To make our database system more robust, we enforced the following rules during table creation phase in [CreateTables.sql](https://github.com/avipars/DB-Mini-Project/blob/main/Stage1/Commands/CreateTables.sql):

* **Location and Books:**
  * Book quantity must be at least 1.
  * Shelf numbers must be positive.
  * Book page count must be at least 1.
* **Books:**
  * ISBN values must be unique.
  * Release dates cannot be in the future.
* **Authors:**
  * Author birth dates cannot be in the future.
* **Foreign Keys:**
  * Every book must have a publisher.
  * Foreign keys reference existing rows, and non-existent publishers, authors, genres, or countries cannot be added.
  * `ON DELETE RESTRICT` is applied to relevant foreign keys to maintain referential integrity.


#### [Testing constraints](https://github.com/avipars/DB-Mini-Project/blob/main/Stage1/Index_Constraints/InvalidConstraints.sql)

To test these constraints, we designed and executed invalid scenarios that should produce errors. These include:

#### **INSERTS**
* **Invalid Numerical Values:**
  * Negative book quantity or shelf number.
  * Negative page count for a book.
* **Invalid Dates:**
  * Release date of a book set in the future.
  * Future birth date for an author.
* **Non-Existent Foreign Keys:**
  * Associating a book with a non-existent publisher, author, language, genre, or country.
  * Adding a publisher in a non-existent country.
* **Unique Constraints Violations:**
  * Duplicate ISBN values for books.

#### **UPDATES**
* **Invalid Numerical Updates:**
  * Updating book quantity or shelf number to negative values.
* **Invalid Dates:**
  * Changing a book's release date to a future date.
  * Updating an author's birth date to a future date.
* **Foreign Key Violations:**
  * Updating `Written_By` to reference a null or non-existent author.
  * Updating `Type_Of` or `Written_In` to reference non-existent genres or languages.
  * Changing a publisher's country to a non-existent one.
* **Unique Constraint Violations:**
  * Updating a publisher's phone number to one already in use.

#### **DELETES**
* Attempting to delete rows that are in use by other tables, including:
  * Countries, authors, genres, publishers, languages, or books referenced in other relationships.


[Testing Constraint error log](https://github.com/avipars/DB-Mini-Project/blob/main/Stage1/Index_Constraints/InvalidConstraints.log)


### Copies

- If several copies of the same book are in the same location, they are classified as 1 unit in the Location table. 

- When a copy moves to a different location or gets reclassified with a different condition, it becomes its own entry in the Location table.

   * Quantity of the original unit can be decreased as well

[DB Dumps for Stage 2](https://gitlab.com/avipars/db-lfs/-/tree/main/Stage2?ref_type=heads)

# Stage 3

##### Things worth knowing

<details>
<summary>Extract Extra DB Info</summary>

   * In PSQL Shell Enter:

        * `\di` to get general info
        * `\d` to get relation info... can do `\d Author` to get specific information about the Author table for example
        * `\df` to get user created function info
        * `\dS Book` to get trigger info for the Book table 
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

    1. View details of available books to take out matching these conditiions: Books that aren't in Storage, Maintenance, Special Collections, Archive, or Returns with a quantity greater than 0

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

1. `GetAuthorNameByBookID(book_id INT)` - The first function returns the full name, first and last, of the author for a specific book, given by its book id. When we select the first name and last name attribute, we cast them into text and returning a Query back. We accept an integer into our parameters and return all full names inside the query.

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

2. `UpdateBooksConditionForPublisher(publisher_name VARCHAR, cond_name VARCHAR)` - The second function is a PROCEDURE, it updates the condition of all books written by an Publisher to a certain condition. The function accepts 2 parameters, publisher name as VARCHAR and condition name as VARCHAR.

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

3. `GetCountryByPublisherID(p_id INT)` - The third function returns the name of the country where a specific publisher is located. It accepts 1 parameter, publisher id as an integer and returns a table of all the names of the countries. The result is returned as a table of countries

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
    ```


4. `GetBooksReleasedWithin10YearsOfBirth(p_count INT, limit_count INT)` - The fourth function returns the first limit_count books with more than a p_count number of pages and released within 10 years of the author being born. It accepts two integers as its parameters and returns a Table with Book id as integer, Release Date, and Date of Birth of the Author.

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
    Deleted_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- deletion time
    );

    CREATE OR REPLACE FUNCTION log_book_deletion()
    RETURNS TRIGGER AS $$
    BEGIN
    INSERT INTO Book_Log (Book_ID, Title, Deleted_At)
    VALUES (OLD.ID, OLD.Title, CURRENT_TIMESTAMP); --logs id , title and deletion time 

    RETURN OLD; 
    END;
    $$ LANGUAGE plpgsql;

    DROP TRIGGER IF EXISTS book_delete_trigger ON Book; -- remove former trigger

    CREATE TRIGGER book_delete_trigger -- re-create
    AFTER DELETE ON Book
    FOR EACH ROW
    EXECUTE FUNCTION log_book_deletion(); -- run function whenever there is a deletion
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
    -- check if book format is changed to 'eBook'
    IF TG_OP = 'UPDATE' AND NEW.Format = 'Ebook' AND OLD.Format != 'Ebook' THEN
        -- update condition to 'NEW' in Location table for book
        UPDATE Location
        SET Condition = 'New', Floor = 'E-Library Section', Shelf = 1
        WHERE ID = NEW.ID;
    END IF;
        -- handle when new eBook is inserted
    IF TG_OP = 'INSERT' AND NEW.Format = 'Ebook' THEN
        -- automatically add eBook to Location table with 'New' condition and 'E-Library Section' floor
        INSERT INTO Location (Quantity, Floor, Shelf, Condition, ID, Location_ID)
        VALUES (1, 'E-Library Section', 1, 'New', NEW.ID, NEW.ID);
    END IF;

    RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    DROP TRIGGER IF EXISTS update_condition_on_ebook_format ON Book; -- remove former trigger

    CREATE TRIGGER update_condition_on_ebook_format  -- re-create
    AFTER UPDATE ON Book
    FOR EACH ROW
    WHEN (OLD.Format != NEW.Format AND NEW.Format = 'Ebook') -- format changed of existing book
    EXECUTE FUNCTION update_condition_for_ebook();

    DROP TRIGGER IF EXISTS insert_condition_on_new_ebook ON Book; -- remove former trigger

    CREATE TRIGGER insert_condition_on_new_ebook   -- re-create
    AFTER INSERT ON Book
    FOR EACH ROW
    WHEN (NEW.Format = 'Ebook') -- inserted ebook
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

[DB Dumps for Stage 3](https://gitlab.com/avipars/db-lfs/-/tree/main/Stage3?ref_type=heads)
