# Java Database Connectivity (JDBC)
JDBC is an API that connects any given database with any given Java version for accessing data from database via code.  
Let's first setup our Database and respective tables to continue with JDBC.
#### RDBMS
MySQL v8.0 
#### Database
user_mgmt
#### Tables
Create a table named `user_type`:  
>![user_tye table](https://github.com/vikas-bandaru/learn-web-dev/blob/main/jdbc/images/user_type%20table.PNG)  

Describe `user_type` table:  
>`describe user_type;`  

Insert one record:
>`insert into user_type values (101, 'admin', 'A user to handle all admin operations on user table.', 10);`

Insert multiple records (using `auto_increment` feature):
>```
>insert into user_type (userType, description, userTypeLevel) 
>values ('customer', 'A user who is the end customer of the project.', 1),
>('db_manager', 'A user of database who will maintain the user data in the database.', 5);
>```

Check the records of the `user_type` table:
>`select * from user_type;`

Create a table named `user`:  
>![user table](https://github.com/vikas-bandaru/learn-web-dev/blob/main/jdbc/images/user%20table.PNG)

Describe the `user` table to check if it is created correctly.  
Insert one record to set the starting value for `userId`. Then insert multiple records. Make sure the values in `userType` column of `user` table matches the `userTypeId` column of `user_type` table.

Before continuing with JDBC, let's see what can we do with such tables...  
Some Operations:
1. Demographic Analysis:  
  a. **Age Distribution:** By using the `dob` column in the `user` table, you can determine the age distribution of users.  
  b. **Gender Distribution:** The `gender` column can provide insights into the distribution of male, female, and other genders among users.  
  c. **Country Distribution:** Analyze users based on their country of residence.
2. User Type Analysis:  
  a. **User Type Distribution:** Find out how many users belong to each user type using the `userType` column in the `user` table and the `userTypeId` column in the `user_type` table.  
  b. **User Type Descriptions:** By joining the tables on the `userType` and `userTypeId` columns, you can get descriptions and other attributes for each user.  
3. Login Patterns (requires additional data such as login timestamps):  
  If you had a table or column that stored login timestamps, you could determine patterns such as the most active times of day, days of the week, or even seasonality trends for user logins.
4. Email Domain Analysis:  
  By parsing the `emailId` column, you can determine the most popular email domains (e.g., gmail.com, yahoo.com) among users.
5. Password Security Analysis:  
  Although it's generally not recommended to analyze raw passwords, if you were to, you could determine the strength and complexity of user passwords. However, for security best practices, passwords should be hashed and not stored in plain text.
6. Correlation Analysis:  
  You might find correlations between certain fields. For example, does a specific country have a higher proportion of a certain user type? Or are users of a specific age range more likely to be of a particular user type?

Some common CRUD operations that can be performed on these tables:
1. Insert records
2. Read all or specific records based on some criteria
4. Update all or specific records based on some criteria
5. Delete all or specific records based on some criteria

Among the above CRUD operations, Read operation (SELECT) shall be used for all the various analysis that can be done based on the data in the tables and the relationship among the tables.

A sample CLI menu for basic CRUD operations on user_type table:  
>=========================== USER_TYPE TABLE MENU ===========================  
>1. Create New User Type (Insert a User_Type record)
>2. View All User Types
>3. Update User Type Details
>4. Delete User Type
>5. Return to Main Menu
>6. Exit
>
>=======================================================================  
Please enter your choice:  

A sample CLI menu for basic CRUD operations on user table:  
>============================= USER TABLE MENU ==============================  
>1. Create New User
>2. View All Users
>3. View User by ID
>4. Update User Details
>5. Delete User
>6. Return to Main Menu
>7. Exit
>
>=======================================================================  
Please enter your choice:  

## JDBC Code
>**Good Practice:** Always have a table design and respective CLI or GUI menu ready before starting JDBC code.

That way, you know what features you want to work on. Each CLI or GUI menu becomes a method in your Java code which is dedicated to do one and only one job.

Next, let's think of method names and respective parameters or returns for each of the menu items for `user_type` table.
>1. Create New User Type (Insert a User_Type record)  

First, decide on the method name: `insertUserType` is a good name for the method  
Then, decide if the method needs to return anything: this decision can be taken based on if the respective SQL query returns anyting or not.
> Does `insert` query of SQL show any result when executed? - try this in your MySQL tool and come to a decision

Then, decide if the method needs any parameters: this decision can be taken based on if any extra data is needed for this method to run and finish it's job  
We know that to perform `insert` SQL query, we need data of the record. So, if the same has to be done with Java code, that method also needs the data to be supplied to it.  

It can be achieved in two ways:
1. Supply individual column data as separate parameters
2. Supply all columns data as a single parameter

Let's work on it one by one
