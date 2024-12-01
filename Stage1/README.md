# BookDB Stage 1 and Stage 2

## Leib Blam and Avi Parshan

### Disclaimer

This library book database system was created solely for educational and demonstration purposes. All data contained within is entirely fabricated and does not represent any real-world information. Any resemblance to actual book titles, authors, or other entities is purely coincidental and unintentional. 

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

### Design 

   * ERD
   ![ERDimage](https://github.com/avipars/DB-Mini-Project/blob/main/Stage1/Diagrams/BookERDMap.png?raw=true)

   * DSD
   ![DSDimage](https://github.com/avipars/DB-Mini-Project/blob/main/Stage1/Diagrams/BookDSDMap.png?raw=true)


   Main Entities: 

      1. Book

      2. Genre

      3. Location

      4. Language

      5. Author

      6. Publisher

      7. Country

### Data Generation

   * Schema Definition [CreateTables.sql](https://github.com/avipars/DB-Mini-Project/blob/main/Stage1/CreateTables.sql) is the script used to create the tables with the required schema.

   * Utilizing [sampleDataCreation.py](https://github.com/avipars/DB-Mini-Project/blob/main/Stage1/Data_Samples/sampleDataCreation.py) we created SQL insert statements that deal with 100.000 Books, 5.000 Authors, 30.000 Publishers, and 70.000 Locations. 

   Each SQL file can be found in the [Data Samples Directory](https://github.com/avipars/DB-Mini-Project/blob/main/Stage1/Data_Samples/data/)
   
   Run the SQL files in the following order: 

      1. Schema definition **CreateTables.sql**

      2. Data for tables

             1. Country
            - **Independent table**.
            - Script: `random_countries.sql`
            - 24 rows

             2. Publisher
            - **Depends on Country** for the `Is_In` table.
            - Script: `random_publishers.sql`
            - 30,000 rows
            
             3. Author
            - **Independent table**.
            - Script: `random_authors.sql`
            - 5,000 rows
            
             4. Language
            - **Independent table**.
            - Script: `random_languages.sql`
            - 62 rows
            
             5. Genre
            - **Independent table**.
            - Script: `random_genres.sql`
            - 77 rows
            
             6. Book
            - **Independent table** but referenced by several others.
            - Script: `random_books.sql`
            - 100,000 rows 
            
             7. Location
            - **Depends on Book.**
            - Script: `random_locations.sql`
            - 70,000 rows 
            
             8. Written_By
            - **Depends on Book and Author.**
            - Script: `written_by.sql`
            - 132,406 rows 
            
             9. Published_By
            - **Depends on Book and Publisher.**
            - Script: `published_by.sql`
            - 125,171 rows
            
             10. Written_In
            - **Depends on Book and Language.**
            - Script: `written_in.sql`
            - 124,727 rows

             11. Type_of
            - **Depends on Book and Genre.**
            - Script: `type_of.sql`
            - 124,756 rows 
            
             12. Is_In
            - **Depends on Publisher and Country.**
            - Script: `is_in.sql`
            - 37,048 rows

## Stage 2

### Create Tables in PostgreSQL

* ![image](https://github.com/user-attachments/assets/a8f66d3d-50f3-49a1-9e3b-1e6cf1d12e80)

Click Query Tool

Now open the CreateTable.sql script via Open File
![image](https://github.com/user-attachments/assets/bc311280-e445-4e25-8762-7236a0ff5b81)

And click execute script

![image](https://github.com/user-attachments/assets/47706ba8-9894-4da4-ba39-d22338730f4f)

### Load data

In a similar fashion to the CreateData.sql script, we now bring in each sql file and execute them in the order listed above

### Dump Data

Via command line, we can dump the data from the database into a file. 

clean to first drop tables

if-exists to avoid errors if tables do not exist

* backupSQL (with DROP . . . CREATE . . . INSERT)

   settled on 1000 rows per insert to balance speed and file size

   create to include create table statements

   inserts to include insert statements

   ```bash
   pg_dump -U postgres -d postgres -v -f "backupSQL.sql" --create --clean --if-exists --verbose --inserts --rows-per-insert "1000" 2>backupSQL.log
   ```

   Full dump output is [here](https://github.com/avipars/DB-Mini-Project/blob/main/Stage1/backupSQL.log)


* backupPSQL (binary format)

   ```bash
   pg_dump --file "backupPSQL.sql" --host "localhost" --port "5432" --username "postgres" --format=c --create --clean --if-exists --verbose "postgres" 2>backupPSQL.log
   ```

   Full dump output is [here](https://github.com/avipars/DB-Mini-Project/blob/main/Stage1/backupPSQL.log)


### Restore Data 

   * Restore backupPSQL (binary format)

      send logs to be appended to original log file, disable triggers helps us avoid future constraint issues with order of insertion into the table (preventative measure)

      no owner and no privileges to avoid issues with permissions
      
      ```bash
      pg_restore --host "localhost" --port "5432" --username "postgres" --dbname "postgres" --clean --if-exists --disable-triggers --verbose --no-owner --no-privileges --format=c "backupPSQL.sql" 2>>"backupPSQL.log"
      ```

### Basic Queries

   - found [here](https://github.com/avipars/DB-Mini-Project/blob/main/Stage1/Queries/Queries.sql)


### Timing

### Indexing

### Parameterized Queries