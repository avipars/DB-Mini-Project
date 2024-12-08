# BookDB Stage 3

### Authors: Leib Blam and Avi Parshan

##### Worth knowing

<details>
<summary>Extract Extra DB Info</summary>

   * In PSQL Shell:

        * enter '\di' without the quotes, to get general info

        * enter '\d' without the quotes, to get relation info... can do '\d author' to get specific information about the Author table for example
</details>

<details>
<summary>Restore DB with Indexes</summary>

   * Restore backupPSQL (binary format) with Indexes

      ```bash
      pg_restore -U postgres -d postgres -v --clean --if-exists --disable-triggers --no-owner --no-privileges --format=c "backupPSQLIndex.sql"
      ```

        Ensure you are in the [Stage2 Folder](https://gitlab.com/avipars/db-lfs/-/tree/main/Stage2)
</details>

   
### Queries 

#### [Join Queries](https://github.com/avipars/DB-Mini-Project/blob/main/Stage3/Queries/JoinQueries.sql)

* (Query 1) This query joins the Book, Written_By, and Author tables to get the first and last name of the author of a book with a specific ID

* (Query 2) This query updates all the books published by Murray-Jenkins to Good Condition

* (Query 3) This query joins the Publisher, Is_In, and Country tables to get the name of the country where a specific publisher is located

* (Query 4) This query selects all books with more than 10 pages and where the book wass released within 10 years of the author being born


#### Timings 

| Query Number | Normal Runtime (ms) | Runtime With Indexes (ms) |
| ------------ | ------------------- | ------------------------- |
| 1            | 4.033               | 2.521                     |
| 2            | 29.940              | 6.404                     |
| 3            | 2.936               | 1.332                     |
| 4            | 2.416               | 1.083                     |

   [Logs with timings](https://github.com/avipars/DB-Mini-Project/blob/main/Stage3/Queries/JoinQueriesTime.log)

   [Indexed logs with timings](https://github.com/avipars/DB-Mini-Project/blob/main/Stage3/Queries/IndexJoinQueriesTime.log)


### [Views](https://github.com/avipars/DB-Mini-Project/blob/main/Stage3/Views)

#### [Creating Views](https://github.com/avipars/DB-Mini-Project/blob/main/Stage3/Views/Views.sql)

* Providing a limited view of our database system:

    1. View details of available books to take out

    2. View of all publishers with ability to manage them

    3. View of authors and books they wrote

    4. View of book quantity per Genre

    [Creating View Logs](https://github.com/avipars/DB-Mini-Project/blob/main/Stage3/Views/Views.log)


#### [Querying via Views](https://github.com/avipars/DB-Mini-Project/blob/main/Stage3/Views/ViewQueries.sql)

* Testing the views via SELECT, INSERT, UPDATE, and DELETE statements: 

    * Any views that were based on several tables will not let you INSERT, UPDATE, or DELETE

    * Publisher_Detail_View allows all of these commands, provided that the queries use abide by the existing database system rules

    [View Query Logs](https://github.com/avipars/DB-Mini-Project/blob/main/Stage3/Views/ViewQueries.log)

### [Visualizations](https://github.com/avipars/DB-Mini-Project/blob/main/Stage3/Visualizations)

View 1: Average page count of books per each language

```sql
SELECT Language_Name, ROUND(AVG(Page_Count),2) AS Avg_Page_Count
FROM Book_Detail_View
GROUP BY Language_Name
ORDER BY Avg_Page_Count DESC;
```
  ![lang](https://github.com/user-attachments/assets/1c84470d-466d-4a4d-b602-efcefdc0c1de)

View 4: Total Copies Available per Genre 

```sql
SELECT Genre_Name, Total_Copies_Available, Unique_Titles 
From Genre_Location_Popularity_View 
ORDER BY Unique_Titles;
```
![unique_titles](https://github.com/user-attachments/assets/2aab045c-c574-4261-853a-26ff3119108a)


### Functions

TODO - Leib



### [Triggers](https://github.com/avipars/DB-Mini-Project/blob/main/Stage3/Triggers/Trigger.sql)

To enhance logging capability and functionality of the database, we created 2 useful triggers. 

1. Log if a book gets deleted from DB in the Book_Log Table (new table made in the same Trigger.sql file)

    * Functions: log_book_deletion()

    * Trigger Name: book_delete_trigger
    
    * Activated: After DELETE on Book Table

2. If a book is classified as an Ebook, automate location changes (set condition, floor, shelf, quantity)

    * Functions: update_condition_for_ebook()

    * Trigger Name: update_condition_on_ebook_format, insert_condition_on_new_ebook

    * Activated: After a Book format changes on UPDATE in Book Table, or After a Book is INSERTED to the Book Table

[Logs for creation](https://github.com/avipars/DB-Mini-Project/blob/main/Stage3/Triggers/Trigger.log)

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

* Insert sample book in Ebook format. The trigger will automatically add an entry in the Location table coordinating to the E-Library Section, New Condition, Shelf 1, Quantity of 1. 

    After insertion into Book and running a SELECT

    | title     | id      | release_date | page_count | format | description           | isbn      |
    |-----------|---------|--------------|------------|--------|-----------------------|-----------|
    | New eBook | 100009  | 2024-12-08   | 200        | Ebook  | An exciting new eBook! | 987684321 |

    After Insertion to Location (by trigger) and running a SELECT

    | quantity | floor             | shelf | location_id | condition | id     |
    |----------|-------------------|-------|-------------|-----------|--------|
    | 1        | E-Library Section | 1     | 100009      | New       | 100009 |

[Logs for testing](https://github.com/avipars/DB-Mini-Project/blob/main/Stage3/Triggers/TestTrigger.log)