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


### Views

TODO - Avi

### Visualizations

TODO

### Functions

TODO 

### Triggers (Bonus)

TODO
