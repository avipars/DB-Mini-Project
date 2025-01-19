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

Our original ERD:

![image](https://github.com/user-attachments/assets/7270b18c-912d-407b-a810-f23bce6a5289)

Their original ERD:

![image](https://github.com/user-attachments/assets/dacabd2b-720c-4839-a225-a8ac0972e660)

Combined ERD:

![image](https://github.com/user-attachments/assets/8487af23-1814-41f1-823b-0b7969bdd024)

Our original DSD:

![image](https://github.com/user-attachments/assets/0ff9de90-8d15-4a85-81da-cc1b1c235dd3)

Their original DSD:

![image](https://github.com/user-attachments/assets/be66427b-4e88-4bd5-a015-ef85d212ddd8)

Combined DSD:

![image](https://github.com/user-attachments/assets/760c6cc3-e318-4115-aa56-8b9d10382977)


#### Links: 

[Their Original Diagrams](https://github.com/Ravioli246/Database-Project-2024-Semester-Spring/tree/main/media)

[Our Original Diagrams and JSON](https://github.com/avipars/DB-Mini-Project/tree/main/Stage1/Diagrams)

[Our Combined Diagrams and JSON](https://github.com/avipars/DB-Mini-Project/tree/main/Stage4/Diagrams)

---- 

#### Design Hurdles

Our Book IDs were using the INT data type, while the other group is using BIGINT. We were required to alter the original schema as well as address any views that relied upon our Book IDs in order to execute the change. Running [BookBigInt.sql](https://github.com/avipars/DB-Mini-Project/tree/main/Stage4/Commands/BookBigInt.sql) allows our database be compatible with the other group's. ![image](https://github.com/user-attachments/assets/304f3285-14ff-437d-9a1d-d0c515d6dcc5). Afterwards, I created a [new dump](https://gitlab.com/avipars/db-lfs/-/tree/main/Stage4?ref_type=heads) reflecting those changes.

Additionally, we connected their Archive relationship with our Location ones in an efficient manner. Next, we added the Rarity attribute to our Book table to accommodate the other group's schema and data. 

### Views

After incorporating both systems, we created two new views to utilize the additional functionality seamlessly.

### Queries

Additionally, we added new queries which take advantage of the views that have been created. 