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

TODO - Leib


    SELECT: 
    * (Query 1)
    * (Query 2)
    * (Query 3)


#### Timings 

TODO - Leib

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

View 4: Total Copies Available per Genre 

```sql
SELECT Genre_Name, Total_Copies_Available, Unique_Titles 
From Genre_Location_Popularity_View 
ORDER BY Unique_Titles;
```



### Functions

TODO - Leib

### Triggers (Bonus)

TODO - Leib and Avi?
