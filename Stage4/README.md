# BookDB Stage 4

### Authors: Avi Parshan and Leib Blam

Final stage of project involving an integration with another team's project.

[DB Dumps for Stage 4](https://gitlab.com/avipars/db-lfs/-/tree/main/Stage4?ref_type=heads)

##### Things worth knowing
<details>
<summary>Extract Extra DB Info</summary>
   * In PSQL Shell Enter:
        * ```\conninfo``` to get username, datbase name, & port number used by Postgres
</details>
<details>
<summary>
Other Group's Github
</summary>
https://github.com/Ravioli246/Database-Project-2024-Semester-Spring
</details>

## Integration

As a part of stage 4, we merged our Book Database System with the Archive and Operations Database System. 

### Design

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

[Insertion Scripts](https://github.com/avipars/DB-Mini-Project/tree/main/Stage4/Data_Samples/data)

[Insertion Logs](https://github.com/avipars/DB-Mini-Project/tree/main/Stage4/Data_Samples/Insertions.log)

### [Views](https://github.com/avipars/DB-Mini-Project/tree/main/Stage4/Views)

After incorporating both systems, we created two new views to utilize the additional functionality seamlessly.

1. ```Find_Archived_Books_View```

This view displays all books that have been archived, including their respective archive ID, book ID, and the date they were archived.

2. ```Disposed_Books_Employees``` 

This view shows all books that have been disposed of, along with the employee responsible for the disposal.

Testing views:

[View Queries Scripts](https://github.com/avipars/DB-Mini-Project/tree/main/Stage4/Views/ViewQueries.sql)

[Logs for View Queries](https://github.com/avipars/DB-Mini-Project/tree/main/Stage4/Views/ViewQueries.log)

### [Queries](https://github.com/avipars/DB-Mini-Project/tree/main/Stage4/Queries)

Additionally, we added new queries which take advantage of the views that have been created. 
