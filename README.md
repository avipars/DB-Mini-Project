# BookDB

## Leib Blam and Avi Parshan

### Disclaimer

This library book database system was created solely for educational and demonstration purposes. All data contained within is entirely fabricated and does not represent any real-world information. Any resemblance to actual book titles, authors, or other entities is purely coincidental and unintentional. 

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

   * Utilizing [sampleDataCreation.py](https://github.com/avipars/DB-Mini-Project/blob/main/Stage1/Data_Samples/sampleDataCreation.py) we created SQL insert statements that deal with 20.000 Books, 5.000 Authors, 3.000 Publishers, and 10.000 Locations. 

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

