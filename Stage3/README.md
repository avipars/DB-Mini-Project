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

### Triggers (Bonus)

TODO - Leib and Avi?
