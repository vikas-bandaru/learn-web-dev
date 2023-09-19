# Java Database Connectivity (JDBC)
JDBC is an API that connects any given database with any given Java version for accessing data from database via code.  
Let's first setup our Database and respective tables to continue with JDBC.
#### RDBMS
MySQL v8.0 
#### Database
user_mgmt
#### Tables
Create a table named `user_type`:  
>![user_tye table](https://github.com/vikas-bandaru/learn-web-dev/blob/main/jdbc/images/user-type-table.PNG)  

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
>![user table](https://github.com/vikas-bandaru/learn-web-dev/blob/main/jdbc/images/user-table.PNG)

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

## JDBC
### Set up JDBC Environment
This will involve downloading and installing the JDBC driver for the database you will be working with.
If you have installed Full Installation of MySQL, then you will find MySQL Connector / J in:  
>C Drive → Program Files (x86) → MySQL → Connector J 8.0

Do the following in the Eclipse Java Project:
1. Right click on the project and go to Build Path
2. Go to Configure Build Path under it
3. It opens a window → select “Library” tab in it
4. Then, select classpath in it (don’t worry, if you don’t see it, just go to next step)
5. Then, click a button located on the right side named “Add External JARs”
6. It opens a new window, Go to the location mentioned above (Connector J 8.0)
7. Choose the mysql-connector-j file from that location and click “Open” button
8. Then, click “Apply and Close” button OR click “Apply” first and then “OK” (the buttons might change among versions of MySQL)

### Some ChatGPT prompts on MySQL & JDBC content:
1. give me a list of all string and number functions of mysql in a tabular format along with respective description, example query
2. give me list of frequently used interfaces that are part of JDBC API
3. give me a mapping of MySQL classes that implement these JDBC API interfaces in a tabular form mapped with similar implementations by Oracle database
4. now give me most used methods of MySQL classes with their description and usage example in a tabular format

>**Good Practice:** Always have a table design and respective CLI or GUI menu ready before starting JDBC code.

That way, you know what features you want to work on. Each CLI or GUI menu becomes a method in your Java code which is dedicated to do one and only one job.

Next, let's think of method names and respective parameters or returns for each of the menu items for `user_type` table.  
Let's consider a simple menu item based on SQL query syntax.
>2. View All User Types  

It is easy to come up with method signature, if we understand the expected behavior of the method. The method for the above menu item should print all the records of the table `user_type`.
First, decide on the method name: `printAllUserTypes` is a good name for this method  
Then, decide if the method needs to return anything: the method name chosen starts with print, that means, maybe we just want to print the data received. So, `void` as return type is sufficient for this method.  
Then, decide if the method needs any parameters: this decision can be taken based on if any extra data is needed for this method to run and finish it's job.  
For a simple `select` query which shows all records of the table that doesn't have any constraints (conditions), so no extra data is needed to run this query. So, parameters are not needed.  

So, finally we have the method signature as:
>`void printAllUserTypes()`

And so, method would look like:
```
void printAllUserTypes() {

}
```

What should we write inside this method such that this method prints all the record details of the table `user_type`?
Let's first revise the steps involved in JDBC code..

Step #1: Register the Database Driver class or Load the JDBC Driver  
Step #2: Establish Connection with the database (using DB url, DB username, DB password)  
Step #3: Create a Statement - this object can execute the query  
Step #4: Execute the query and save the result  
Step #5: Process the result - saved data can be used to print or do any other operation  
Step #6: Close the Connection

In the above steps, Steps 1, 2, and 6 are common to all JDBC code. Step 6 is optional, may or may not be used for experiments by beginners. But, it MUST be used in professional code, i.e., in job.  

### Connect to a MySQL database `user_mgmt` using JDBC
#### Step #1: Load the MySQL JDBC Driver
**Explanation:** JDBC drivers are responsible for communicating with the database. Before establishing a connection, you need to load the appropriate JDBC driver class.
```
Class.forName("com.mysql.jdbc.Driver");
OR
Class.forName("com.mysql.cj.jdbc.Driver");
```
In this example, we load the MySQL JDBC driver class. The Class.forName() method dynamically loads the Driver class into memory. This class is located in the MySQL connector jar file that we set up in the previous step.
The above statement causes an exception called "ClassNotFoundException". Handle the exception using try-catch block like this:
```
try {
	Class.forName("com.mysql.cj.jdbc.Driver");
} catch(ClassNotFoundExcpetion ex) {
	System.out.println("Driver class not found.");
}
```
#### Step #2: Establish a Connection to the Database
**Explanation:** To connect to a MySQL database, you need to provide the necessary connection details, such as the URL, username, and password of the database. URL includes a particular format that is used in almost all web or server-based software:
>protocol://hostname:portNumber/resourceName
```
String dbUrl = "jdbc:mysql://host:port/your-database";
String dbUsername = "your-db-username";
String dbPassword = "your–db-password";
Connection con = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
```
In the getConnection() method, you pass the connection URL, username, and password to establish a connection with the database. The URL typically follows the format `jdbc:mysql://host:port/your-database`, where host is the hostname or IP address of the database server, port is the port number (default is 3306 for MySQL), and your-database is the name of the specific database you want to connect to.

##### Example:
```
String dbUrl = "jdbc:mysql://localhost:3306/user_mgmt";
String dbUsername = "root";
String dbPassword = "root";
Connection con = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
```
The above statement causes an exception called "SQLException" that can be handled like this:
```
String dbUrl = "jdbc:mysql://localhost:3306/user_mgmt";
String dbUsername = "root";
String dbPassword = "root";
try {
	Connection con = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
} catch(SQLException ex) {
	System.out.println("Exception: Check spelling mistake in values of dbUrl or dbUsername or dbPassword");
}
```
In the above 2 steps, there are two separate try-catch blocks, they can be written together as
```
String dbUrl = "jdbc:mysql://localhost:3306/user_mgmt";
String dbUsername = "root";
String dbPassword = "root";
try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection con = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
} catch(ClassNotFoundExcpetion ex) {
	System.out.println("Driver class not found.");
} catch(SQLException ex) {
	System.out.println("Exception: Check spelling mistake in values of dbUrl or dbUsername or dbPassword");
}
```
#### Step #3: Create a Statement
**Explanation:** After establishing a connection, you can execute SQL statements or queries against the database. This will involve writing simple SELECT statements to retrieve data from the database. The simplest way to execute a query using JDBC is using a Statement object.
```
Statement stmt = connection.createStatement();
```
#### Step #4: Execute the query and save the result
Statement interface has many execute methods. Execution methods available in Statement interface:
1. boolean execute(String sql) -> rarely used
  Executes any SQL statement. It can be used for statements that do not return results, such as INSERT, UPDATE, DELETE, or DDL statements.
2. ResultSet executeQuery(String sql) -> frequently used
  Executes an (DRL) SQL SELECT query and returns a ResultSet object containing the query results.
3. int executeUpdate(String sql) -> used with DML queries
  Executes an SQL INSERT, UPDATE, or DELETE statement and returns the number of affected rows.
4. int[] executeBatch()
  Executes a batch of SQL statements as a single operation. It is useful for executing multiple statements efficiently in a batch.
Let us try one of them:
```
String query = "SELECT * FROM emp";
boolean isSuccess = stmt.execute(query);
```
The execute method returns true if the statement is a ResultSet-producing statement, and false otherwise.  
All the execute methods cause "SQLException". They must be handled using try-catch blocks. Instead of writing separate try catch block, that code can be included in the previous try-catch block like:
```
String dbUrl = "jdbc:mysql://localhost:3306/fsd46";
String dbUsername = "root";
String dbPassword = "root";
try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection con = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
	Statement stmt = connection.createStatement();
  String query = "SELECT * FROM emp";
  boolean isSuccess = stmt.execute(query);
} catch(ClassNotFoundExcpetion ex) {
	System.out.println("Driver class not found.");
} catch(SQLException ex) {
  System.out.println("Exception: Check spelling mistake in values of dbUrl or dbUsername or dbPassword or query ");
}
```
#### Step #5: Process the result - saved data can be used to print or do any other operation 
**Explanation:** You can verify if the returned boolean value from execute method was true or false and accordingly print a message to the user.
```
if (isSuccess) {
	System.out.println("Query executed successfully.");
} else {
	System.out.println("Query failed.");
}
```
Now, this code can be kept outside try-catch or inside depending on your comfort in resolving any syntax errors that arise.
#### Step #6: Close the Connection and Resources
**Explanation:** Once you're done with the database operations, it's important to close the connection and release any associated resources to free up system resources.
```
stmt.close();
con.close();
```
So, the final code for the above 6 steps:
```
String dbUrl = "jdbc:mysql://localhost:3306/user_mgmt";
String dbUsername = "root";
String dbPassword = "root";
String query = "SELECT * FROM emp";
try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection con = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
	Statement stmt = connection.createStatement();
  boolean isSuccess = stmt.execute(query);
  if (isSuccess) {
	  System.out.println("Query executed successfully.");
  } else {
	  System.out.println("Query failed.");
  }
  stmt.close();
  con.close();
} catch(ClassNotFoundExcpetion ex) {
	System.out.println("Driver class not found.");
} catch(SQLException ex) {
	System.out.println("Exception: Check spelling mistake in values of dbUrl or dbUsername or dbPassword or query");
}
```

Let's think of another method's names and respective parameters or returns for each of the menu items for `user_type` table.
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
