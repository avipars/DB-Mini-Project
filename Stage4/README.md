# BookDB Stage 4

### Authors: Avi Parshan and Leib Blam

Final stage of project involving an integration with another team's project.

[DB Dumps for Stage 4](https://gitlab.com/avipars/db-lfs/-/tree/main/Stage4?ref_type=heads)

##### Things worth knowing
<details>
<summary>Extract Extra DB Info</summary>
   * In PSQL Shell Enter: ```\conninfo``` to get username, database name, & port number used
</details>
<details>
<summary>
Other Group's Github
</summary>
https://github.com/Ravioli246/Database-Project-2024-Semester-Spring
</details>

## Integration

As a part of stage 4, we merged our Book Database System with the Archive and Operations Database System. 

### [Design](https://github.com/avipars/DB-Mini-Project/tree/main/Stage1/Diagrams)

Our original ERD

![image](https://github.com/user-attachments/assets/7270b18c-912d-407b-a810-f23bce6a5289)

Their original ERD

![image](https://github.com/user-attachments/assets/dacabd2b-720c-4839-a225-a8ac0972e660)

Combined ERD

![image](https://github.com/user-attachments/assets/b997bdcc-ba72-4b49-85ca-cba9d5518c99)

Our original DSD

![image](https://github.com/user-attachments/assets/0ff9de90-8d15-4a85-81da-cc1b1c235dd3)

Their original DSD

![image](https://github.com/user-attachments/assets/be66427b-4e88-4bd5-a015-ef85d212ddd8)

Combined DSD

![image](https://github.com/user-attachments/assets/b4a52716-f43c-4b36-a474-e83360fdcd6f)


#### Links: 

[Their Original Diagrams and JSON](https://github.com/avipars/DB-Mini-Project/tree/main/Stage4/Diagrams/Theirs)

[Our Original Diagrams and JSON](https://github.com/avipars/DB-Mini-Project/tree/main/Stage1/Diagrams)

[Combined Diagrams and JSON](https://github.com/avipars/DB-Mini-Project/tree/main/Stage4/Diagrams/Combined)

---- 

#### Design Changes

To ensure compatibility with the other group’s database schema, we updated our Book IDs from the ```INT``` data type to ```BIGINT```, aligning with their schema. This required modifying our original database schema and addressing all dependent views that relied on the Book IDs. Running the script [BookBigInt.sql](https://github.com/avipars/DB-Mini-Project/tree/main/Stage4/Commands/BookBigInt.sql) applies these changes, enabling seamless integration between the two systems. ![image](https://github.com/user-attachments/assets/304f3285-14ff-437d-9a1d-d0c515d6dcc5). Following this update, we created a [new database dump](https://gitlab.com/avipars/db-lfs/-/tree/main/Stage4?ref_type=heads) reflecting the altered schema.

Additionally, we connected their ```Archive``` relationship with our ```Location``` ones in an efficient manner. Next, we added the Rarity attribute to our ```Book``` table to accommodate the other group's schema and data. 

### Data Integration

To successfully integrate the two systems, we ordered the table data insertion commands. This ensured that foreign key constraints were respected and no violations occurred during the data integration process. 

Insertion Order:

1. Country  
2. Publisher  
3. Archive  
4. Author  
5. Language  
6. Genre  
7. Book  
8. Location  
9. Written By  
10. Published By  
11. Written In  
12. Type Of  
13. Is In  
14. Employee  
15. Disposal  
16. Upkeep  
17. Archive Assignment  

![image](https://github.com/user-attachments/assets/40506187-a9d9-4671-910c-c46d02400e78)

After completing the data insertion stage, our database looks like this:

![image](https://github.com/user-attachments/assets/bd1d8d26-c31f-4637-92f5-b3277550af63)

We also ran a sample query to ensure that the new datbase is working as expected

![image](https://github.com/user-attachments/assets/93a4f74b-bfcc-4450-8a1c-e25f0aaa402d)

```sql
SELECT 
    B.Title, 
    B.Release_Date, 
    B.Rarity, 
    A.Book_Type, 
    L.Floor, 
    L.Shelf, 
    L.Condition,
	A.Archive_Number
FROM 
    Book B
JOIN 
    Location L ON B.ID = L.ID
JOIN 
    Archive A ON L.Archive_Number = A.Archive_Number
LIMIT 5;
```

[Insertion Scripts](https://github.com/avipars/DB-Mini-Project/tree/main/Stage4/Data_Samples/data)

[Insertion Logs](https://github.com/avipars/DB-Mini-Project/tree/main/Stage4/Data_Samples/Insertions.log)

### [Views](https://github.com/avipars/DB-Mini-Project/tree/main/Stage4/Views/Views.sql)

After incorporating both systems, we created two new views to utilize the additional functionality seamlessly.

1. ```Find_Archived_Books_View```

This view displays all books that have been archived, including their respective archive ID, book ID, and the date they were archived.

```sql
CREATE OR REPLACE VIEW Find_Archived_Books_View AS
SELECT 
    B.Title, 
    B.Release_Date, 
    B.Rarity, 
    A.Book_Type, 
    L.Floor, 
    L.Shelf, 
    L.Condition,
	A.Archive_Number
FROM 
    Book B
JOIN 
    Location L ON B.ID = L.ID
JOIN 
    Archive A ON L.Archive_Number = A.Archive_Number;
```


2. ```Disposed_Books_Employees``` 

This view shows all books that have been disposed of, along with the employee responsible for the disposal.

```sql
CREATE OR REPLACE VIEW  Disposed_Books_Employees AS
SELECT 
    E.Employee_ID, 
    E.Name, 
    E.Role, 
    E.Age, 
    E.Salary, 
    D.Date AS Disposal_Date, 
    D.Method, 
    D.Material_of_Book, 
    B.Title AS Book_Title, 
    B.ID AS Book_ID
FROM 
    Employee E
JOIN 
    Disposal D ON E.Employee_ID = D.Employee_ID
JOIN 
    Book B ON D.ID = B.ID;
```

[Logs for Views](https://github.com/avipars/DB-Mini-Project/tree/main/Stage4/Views/Views.log)

### [View Queries](https://github.com/avipars/DB-Mini-Project/tree/main/Stage4/Views/ViewQueries.sql)

#### View 1 ```Find_Archived_Books_View```

Query 1: Get all archived books that are legendary, academic, and in the study area between 2000 and 2020

```sql
SELECT * FROM Find_Archived_Books_View WHERE release_date BETWEEN '2000-01-01' AND '2020-12-31' AND rarity = 'Legendary' AND book_type = 'Academic' AND floor = 'Study Area';
```

Query 2: Delete all archived books with archive number 9
```sql
DELETE FROM Find_Archived_Books_View WHERE archive_number = 9;
```
This fails as the view is based upon several tables (using joins) and is not updatable

#### View 2 ```Disposed_Books_Employees``` 

Query 3: Get all disposed books that were buried and made of synthetic material, and were disposed by disposal workers over 60 years old
```sql
SELECT name, role, disposal_date, book_title, age FROM Disposed_Books_Employees WHERE method = 'Burial' AND material_of_book = 'Synthetic' AND role = 'Disposal Worker' AND age > 60;
```

Query 4: Raise the salary of the employee who has disposed of the most books by 10% 
```sql
UPDATE 
    Disposed_Books_Employees
SET 
    Salary = Salary * 1.10 
WHERE 
    Employee_ID = (
        SELECT 
            E.Employee_ID
        FROM 
            Employee E
        JOIN 
            Disposal D ON E.Employee_ID = D.Employee_ID
        GROUP BY 
            E.Employee_ID, E.Name
        ORDER BY 
            COUNT(*) DESC
        LIMIT 1
    );
```
This fails as the view is based upon several tables (using joins) and is not updatable

[Logs for View Queries](https://github.com/avipars/DB-Mini-Project/tree/main/Stage4/Views/ViewQueries.log)

### [Queries](https://github.com/avipars/DB-Mini-Project/tree/main/Stage4/Queries)

Additionally, we added new queries which take advantage of the views that have been created. 

#### View 1 ```Find_Archived_Books_View```

Query 5: A book was declared missing but we found it. Update the condition status to match this in the view

```sql
UPDATE Find_Archived_Books_View
SET condition = 'Found'
WHERE archive_number = (
    SELECT archive_number
    FROM Find_Archived_Books_View
    WHERE condition = 'Missing'
    AND shelf = 99
    AND archive_number = 2
)
AND title = 'Yard job stop court computer beautiful enough such.';
```

Query 6: Delete all books from the archive with the title that contains the words 'car TV' from the view

```sql
DELETE FROM Find_Archived_Books_View
WHERE Title LIKE '%car TV%' AND Archive_Number = 46;
```

#### View 2 ```Disposed_Books_Employees``` 

Query 7: Insert a record saying that Sonya (Existing Employee) disposed of a specific book today

```sql
INSERT INTO Disposed_Books_Employees (employee_id, name, role, age, salary, disposal_date, method, material_of_book, book_title, book_id)
VALUES (97, 'Sonya West', 'Archivist', 20, 67252, '2025-01-26', 'Burial', 'Paper', 'Federal hundred sure country.', 99999);
```


Query 8: Update the disposal method of the book with the title contains the words 'floor plan' to 'Recycling' in the Disposal table (query fails due to view using joins)

```sql
UPDATE Disposed_Books_Employees
SET Method = 'Recycling'
WHERE Book_ID = (SELECT Book_ID FROM Disposed_Books_Employees WHERE Book_Title LIKE '%floor plan%');
```

These queries fail to execute as both views are based upon several tables (using joins) and are therefore not modifiable.

[Logs for Queries](https://github.com/avipars/DB-Mini-Project/tree/main/Stage4/Queries/Queries.log)


#### Timing Queries

Using the timings, via the ```\timing``` command in the PSQL shell, we were able to determine the time. The timing logs are also found in [this file](https://github.com/avipars/DB-Mini-Project/tree/main/Stage4/Queries/Queries.log)


| View Number | Query Number | Query Runtime (ms) |
| ----------- | ------------ | ------------------ |
| 1           | 1            | 138.118            |
| 1           | 2            | 5.09               |
| 2           | 3            | 196.596            |
| 2           | 4            | 109.425            |
|             |              |                    |
| 1           | 5            | 3.771              |
| 1           | 6            | 92.362             |
| 2           | 7            | 7.094              |
| 2           | 8            | 3.805              |


[DB Dumps for Stage 4](https://gitlab.com/avipars/db-lfs/-/tree/main/Stage4?ref_type=heads)
