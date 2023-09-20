# Java Database Connectivity (JDBC)
JDBC is an API that connects any given database with any given Java version for accessing data from database via code.  
Let's first setup our Database and respective tables to continue with JDBC.
#### Official JDBC API Documentation
Make habit of using Java documentation as often as possible while building Java code.  
Here is [JDBC API documentation](https://docs.oracle.com/javase/8/docs/technotes/guides/jdbc/).  
Here is [Java 8 Documentation](https://docs.oracle.com/javase/8/docs/api/index.html) for your Core Java reference.
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

>**Good Practice:** Always describe table after creating it. To make sure you the table has the structure you need.  
Insert one record to set the starting value for `userId`. Then insert multiple records. Make sure the values in `userType` column of `user` table matches the `userTypeId` column of `user_type` table.

**Motivation to learn JDBC**
Before continuing with JDBC, let's see what can we do with such tables...
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

Some **common CRUD operations** that can be performed on these tables:
1. Insert records
2. Read all or specific records based on some criteria
4. Update all or specific records based on some criteria
5. Delete all or specific records based on some criteria

**Note:** Among the above CRUD operations, Read operation (SELECT) shall be used for all the various analysis that can be done based on the data in the tables and the relationship among the tables.

A sample CLI menu for basic CRUD operations on `user_type` table:  
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

A sample CLI menu for basic CRUD operations on `user` table:  
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

>**Good Practice:** Always have a table design and respective CLI or GUI menu ready before starting JDBC code.

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
That way, you know what features you want to work on. Each CLI or GUI menu becomes a method in your Java code which is dedicated to do one and only one job.

#### Planning Methods for the CRUD Operations
Let's think of method names and respective parameters or returns for each of the menu items for `user_type` or `user` table.  
Let's consider a menu item based on a simple SQL query: SELECT * FROM table-name; This query is simple and doesn't need any extra data to work.  
>2. View All User Types  

This menu item fits our simple query.  
It is *easy to come up with method signature*, if we understand the expected behavior of the method. The method for the above menu item should print all the records of the table `user_type`.
##### Steps to decide Method Signature
1. Decide the method *name*: `printAllUserTypes` is a good name for this method
2. Decide the method's *return*: the method name chosen starts with print, that means, maybe we just want to print the data received. So, `void` as return type is sufficient for this method.
3. Decide the method's *parameters*: this decision can be taken based on if any extra data is needed for this method to run and finish it's job.  
 For a simple `select` query which shows all records of the table doesn't have any constraints (conditions), so no extra data is needed to run this query. So, parameters are not needed.  

Finally, we have the method signature as:
>`void printAllUserTypes()`

The method would look like:
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

In the above steps, Steps 1, 2, and 6 are common to all JDBC code. Step 3 may vary based on how much *simplicity* or how much *security* you want in the code. Step 6 is optional, may or may not be used for experiments by beginners. But, it MUST be used in professional code, i.e., in job.  

## Connect to a MySQL database `user_mgmt` using JDBC
### Problem: Verify if the `user_type` table has at least one record
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
} catch(ClassNotFoundException ex) {
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
} catch (ClassNotFoundException ex) {
	System.out.println("Driver class not found.");
} catch (SQLException ex) {
	System.out.println("Exception: Check spelling mistake in values of dbUrl or dbUsername or dbPassword");
}
```
#### Step #3: Create a Statement
**Explanation:** After establishing a connection, you can execute SQL statements or queries against the database. This will involve writing simple SELECT statements to retrieve data from the database. The simplest way to execute a query using JDBC is using a Statement object.
```
Statement stmt = con.createStatement();
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
String query = "SELECT * FROM user_type";
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
	Statement stmt = con.createStatement();
  	String query = "SELECT * FROM user_type";
  	boolean isSuccess = stmt.execute(query);
} catch(ClassNotFoundException ex) {
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
void printAllUserTypes() {
   String dbUrl = "jdbc:mysql://localhost:3306/user_mgmt";
   String dbUsername = "root";
   String dbPassword = "root";
   String query = "SELECT * FROM user_type";
   try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection con = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
	Statement stmt = con.createStatement();
  	boolean isSuccess = stmt.execute(query);
  	if (isSuccess) {
	  System.out.println("Query executed successfully.");
  	} else {
	  System.out.println("Query failed.");
  	}
   	stmt.close();
   	con.close();
   } catch(ClassNotFoundException ex) {
	System.out.println("Driver class not found.");
   } catch(SQLException ex) {
	System.out.println("Exception: Check spelling mistake in values of dbUrl or dbUsername or dbPassword or query");
   }
}
```

But the above **_code is not such a good_** one. Why? Because, we are using `boolean execute(String sql)` method and this method doesn't give correct results because of it's return type policy.  
A _better code_ could be using `ResultSet executeQuery(String sql)` method. This method returns an object that contains all the result returned by the database and so can be used to check if the records are available in the result.  
### How to avoid the wrong output from previous code?
Before making any updates in the code, let's see what need not be disturbed. As discussed earlier, Steps 1, 2, 3, and 6 are common to our previous JDBC code. The code up to creating a statement (Step 3), and the code that continues from Closing the Connection (Step 6) need not be disturbed.  
Step #1 to Step #3:
```
void printAllUserTypes() {
   String dbUrl = "jdbc:mysql://localhost:3306/user_mgmt";
   String dbUsername = "root";
   String dbPassword = "root";
   String query = "SELECT * FROM user_type";
   try {
	Class.forName("com.mysql.cj.jdbc.Driver");			// Step #1
	Connection con = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);	// Step #2
	Statement stmt = con.createStatement();				// Step #3
```
Step #6 onwards:
```
   	stmt.close();
   	con.close();
   } catch(ClassNotFoundException ex) {
	System.out.println("Driver class not found.");
   } catch(SQLException ex) {
	System.out.println("Exception: Check spelling mistake in values of dbUrl or dbUsername or dbPassword or query");
   }
}   // method close bracket
```
#### Step #4: Execute the query and save the result as `ResultSet` object
Let's update the previous code with this new `execute` method of `Statement` interface.. Execute the query using `ResultSet executeQuery(String sql)` method and save the result in `ResultSet` object.  
```
	ResultSet rs = stmt.executeQuery(query);
```
`ResultSet` object refers to the whole result returned from executing the query. The result may include no records, 1 record, or multiple records based on the data available in the table. `ResultSet` interface has a method called `boolean next()` which maintains a cursor that refers to the first record of the result and checks if the `ResultSet` object refers to a record or not. If `ResultSet` object refers to a record, `rs.next()` returns `true` and moves the cursor to the next record in the result. If `ResultSet` object does not refer to a record, `rs.next()` returns `false`.  
#### Step #5: Process the result - saved data can be used to print or do any other operation
First, let's just check if there is any record in the result. If rs.next() returns true, there is at least one record in the result.
```
	if (rs.next()) {
		// record is available
		System.out.println("record is available");
	}
```
The above `if` condition prints the message "record is available" if there is at least one record in the result. If we use `while` instead of `if`, the same message is repeatedly printed till all records of the result are accessed.
>**Think and Explain:** How using `while` instead of `if` prints the same message repeatedly based on the number of records

##### Print the record data
Update the code inside the `if` block to print the data of the record.  
This table (`user_type`) contains 4 columns: userTypeId (int), userType (varchar), description (varchar), and userTypeLevel (int)  
I have mentioned the column type for each column within the pair of parentheses () for reference. This information is crucial to access individual column data per record.  
>**Good Practice:** Always write down the table you are working on, their columns names with column data types for reference.

`ResultSet` interface contains a lot of get methods for each primitive data type, one for String, and one for Object. And these methods are overloaded methods, i.e., same method name with different parameter types.  
##### Overloaded get methods of `ResultSet`
>`int getInt(int columnIndex)`  
>`int getInt(String columnLabel)`

Find more ResultSet get methods from its documentation page [here](https://docs.oracle.com/javase/8/docs/api/java/sql/ResultSet.html).  
These methods return the value of the given column of the current record that is accessed using `ResultSet` rs object.  
##### Example
>`rs.getInt(1)` returns the current record's first column value, i.e., userTypeId column value.  
>Alternatively, `rs.getInt("userTypeId")` too returns the value of the current record's column with column-label "userTypeId" 

**Note:** Unlike Java's array index which starts from 0, SQL table's column index starts from 1.  

>**Question:** How to decide which get method of `ResultSet` to use?  

##### How to decide which get method of `ResultSet` to use?
Decide that based on _the data type_ of the column. For integer number types of SQL: getInt or getLong or getByte or getShort. For fractional number types of SQL: getFloat or getDouble. For varchar or any string types of SQL: getString. etc.  

So, the final code to print all the columns of the first record of result:
```
	if (rs.next()) {
		System.out.println("User Type ID: " + rs.getInt("userTypeId"));
		System.out.println("User Type: " + rs.getString("userType"));
		System.out.println("Description: " + rs.getString("description"));
		System.out.println("User Type Level: " + rs.getInt("userTypeLevel"));
	}
```
>**Question:** What if the there are no records in the result? Will the code still work??  

Just add one more close statement before closing stmt. Close `ResultSet` rs object.  

So, the final code using `ResultSet`:
```
void printAllUserTypes() {
   String dbUrl = "jdbc:mysql://localhost:3306/user_mgmt";
   String dbUsername = "root";
   String dbPassword = "root";
   String query = "SELECT * FROM user_type";
   try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection con = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
	Statement stmt = con.createStatement();
	ResultSet rs = stmt.executeQuery(query);
	if (rs.next()) {
		System.out.println("User Type ID: " + rs.getInt("userTypeId"));
		System.out.println("User Type: " + rs.getString("userType"));
		System.out.println("Description: " + rs.getString("description"));
		System.out.println("User Type Level: " + rs.getInt("userTypeLevel"));
	}
	rs.close();
   	stmt.close();
   	con.close();
   } catch(ClassNotFoundException ex) {
	System.out.println("Driver class not found.");
   } catch(SQLException ex) {
	System.out.println("Exception: Check spelling mistake in values of dbUrl or dbUsername or dbPassword or query");
   }
}	// method close bracket
```
### Problem: Print all users based on given `userName`
If you think about this problem, it is similar to the previous problem. Except that it is a different table (`user`), and the method needs an extra information, i.e., the value of the column `userName` to do the job.  
>**_Good Practice_:** Write down an example query and test it in the SQL Server. Keep it available in comment line for reference.  

>**Example SQL Query for this problem:** SELECT * FROM user WHERE userName = 'Raju B';

![query result](https://github.com/vikas-bandaru/learn-web-dev/blob/main/jdbc/images/userByName.PNG)  
Decide **_Method Signature_** for this problem: Follow the steps mentioned earlier under the section "Steps to decide Method Signature".
My choice: `void printUserByName(String name)`  
This query needs a value in WHERE clause, i.e., `WHERE userName = 'Raju B'`. A method that runs this query should receive user's name, like "Raju B" as extra information and that value can be any name. So, we need a String parameter for this method.  
As this method should just print the result, so `void` is enough as return type.  

#### Code
The code is very much similar to previous problem's method. The only things to take care of: 
1. Write the query in Java String format (parameter variable to be concatenated properly)  
 The method receives the parameter `name`. This variable can be used to make the _dynamic SQL Query_ as a String value:  
 "SELECT * FROM user WHERE userName = '" + name + "'"  
 So, the query variable becomes: `String query = "SELECT * FROM user WHERE userName = '" + name + "'"`;
 **Note:** Be careful while concatenating. Make sure the String value is enclosed in single quotes ''
3. Update `ResultSet` get methods based on the columns to print. Refer to the previous content under "How to decide which get method of `ResultSet` to use?" section.  

In the following code, I am printing only 4 columns of the `user` table.  
Updated previous code with changing the method signature and added updated _dynamic SQL query_.
```
void printUserByName(String name) {
   String dbUrl = "jdbc:mysql://localhost:3306/user_mgmt";
   String dbUsername = "root";
   String dbPassword = "root";
   // Example query: SELECT * FROM user WHERE userName = 'Vijay'
   String query = "SELECT * FROM user WHERE userName = '" + name + "'";
   try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection con = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
	Statement stmt = con.createStatement();
	ResultSet rs = stmt.executeQuery(query);
	// using different get methods based on the columns that are being printed: userName, gender, dob, country
	while (rs.next()) {
		System.out.print(rs.getString("userName") + "\t");
		System.out.print(rs.getString("gender") + "\t");
		System.out.print(rs.getString("dob") + "\t");
		System.out.println(rs.getString("country"));
	}
	rs.close();
   	stmt.close();
   	con.close();
   } catch(ClassNotFoundException ex) {
	System.out.println("Driver class not found.");
   } catch(SQLException ex) {
	System.out.println("Exception: Check spelling mistake in values of dbUrl or dbUsername or dbPassword or query");
   }
}	// method close bracket
```

#### Exercises
1. Get the student based on id (expected result is one record, as id is unique)  
 Expected return is an object that contains all the details of the resulting object
2. Get the students based on name (expected result  is multiple records, as name is not unique and there may be duplicates)  
 Expected return is a list of objects that contain all the details of the resulting objects
3. Get the students based on age (expected result is multiple records, as age is not unique and there may be duplicates)  
 Expected return is a list of objects that contain all the details of the resulting objects

### Problem: Insert a record into `user_type` table
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
