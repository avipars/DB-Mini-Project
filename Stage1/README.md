# BookDB

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

   Each SQL file can be found in the [Data Samples Directory](https://github.com/avipars/DB-Mini-Project/blob/main/Stage1/Data_Samples/)
   
   Run the SQL files in the following order: 

      1. Schema definition **CreateTables.sql**

      2. Data for tables

         * random_countries.sql

         * random_publishers.sql

         * random_authors.sql

         * random_languages.sql

         * random_genres.sql

         * random_locations.sql

         * random_books.sql

         * written_by.sql

         * published_by.sql

         * written_in.sql

         * type_of.sql

         * is_in.sql


## Stage 2

### Create Tables

* ![image](https://github.com/user-attachments/assets/a8f66d3d-50f3-49a1-9e3b-1e6cf1d12e80)

Click Query Tool

Now open the CreateTable.sql script via Open File
![image](https://github.com/user-attachments/assets/bc311280-e445-4e25-8762-7236a0ff5b81)

And click execute script

![image](https://github.com/user-attachments/assets/47706ba8-9894-4da4-ba39-d22338730f4f)

### Load data

In a similar fashion to the CreateData.sql script, we now bring in each sql file and execute them in the following order

# Schema Dependency Outline

## 1. Country
- **Independent table**.
- Script: `random_countries.sql`

## 2. Publisher
- **Depends on Country** for the `Is_In` table.
- Script: `random_publishers.sql`

## 3. Author
- **Independent table**.
- Script: `random_authors.sql`

## 4. Language
- **Independent table**.
- Script: `random_languages.sql`

## 5. Genre
- **Independent table**.
- Script: `random_genres.sql`

## 6. Book
- **Independent table** but referenced by several others.
- Script: `random_books.sql`

## 7. Location
- **Depends on Book.**
- Script: `random_locations.sql`

## 8. Written_By
- **Depends on Book and Author.**
- Script: `written_by.sql`

## 9. Published_By
- **Depends on Book and Publisher.**
- Script: `published_by.sql`

## 10. Written_In
- **Depends on Book and Language.**
- Script: `written_in.sql`

## 11. Type_of
- **Depends on Book and Genre.**
- Script: `type_of.sql`

## 12. Is_In
- **Depends on Publisher and Country.**
- Script: `is_in.sql`




