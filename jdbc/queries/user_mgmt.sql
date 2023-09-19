create database user_mgmt;
use user_mgmt;

# create user_type table with columns userTypeId, userType, description, userTypeLevel
create table user_type (userTypeId int auto_increment primary key, userType varchar(15), description varchar(100), userTypeLevel int);

drop table user_type;
describe user_type;

insert into user_type values (101, 'admin', 'A user to handle all admin operations on user table.', 10);
insert into user_type (userType, description, userTypeLevel) 
			values ('customer', 'A user who is the end customer of the project.', 1),
				   ('db_manager', 'A user of database who will maintain the user data in the database.', 5);

select * from user_type;

# create user table with columns userId, userName, gender, dob, country, emailId, password
create table user (userId int auto_increment primary key, userName varchar(64), gender varchar(6), dob date, 
				   country varchar(16), emailId varchar(64), password varchar(64), userType INT NOT NULL,
                   FOREIGN KEY (userType) REFERENCES user_type(userTypeId));
                   
describe user;

insert into user values (201, 'Vikas Bandaru', 'Male', '1986-01-14', 'India', 'vikas@gmail.com', 'Vikas@123', 101);

insert into user (userName, gender, dob, country, emailId, password, userType) 
			values ('Deepak Chakravarthy', 'Male', '1985-02-18', 'His Own World', 'deepak@gmail.com', 'Deepak@123', 102),
            ('Raju B', 'Male', '1996-02-14', 'World Operations', 'raju@gmail.com', 'Raju@123', 103),
            ('Gayatri T', 'Female', '1986-01-14', 'Mauritius', 'gayatri@gmail.com', 'Gayatri@123', 102);
            
select * from user;