# BookDB Stage 1 and Stage 2

### Authors: Leib Blam and Avi Parshan

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

- When a copy moves to a different location or gets reclasified with a different condition, it becomes its own entry in the Location table.

   * Quantity of the original unit can be decreased as well

[DB Dumps for Stage2](https://gitlab.com/avipars/db-lfs/-/tree/main/Stage2?ref_type=heads)
