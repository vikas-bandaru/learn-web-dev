# Java Servlet Basics
Find Java Servlet API [here](https://docs.oracle.com/javaee/7/api/overview-summary.html).  
Find Apache Tomcat v9.0's implementation of Java Servlet API [here](https://tomcat.apache.org/tomcat-9.0-doc/servletapi/index.html).

## Setup Your Environment for Servlet Programming
1. Make sure JDK 1.8 is installed
2. Make sure compatible Eclipse for Java EE is available (Java Neon 3 is good)
3. Download zip file of Apache Tomcat v9.0 and extract it to safe location
4. Setup Environment Variables for JDK_HOME, JRE_HOME, CATALINA_HOME, and Path variable with JRE
 Go to Windows menu and search for env, you will see two results as:
 ![env-option-1](https://github.com/vikas-bandaru/learn-web-dev/blob/main/jdbc/images/env1.png)
 Choose the right option as mentioned above
![env-setup-1](https://github.com/vikas-bandaru/learn-web-dev/blob/main/jdbc/images/env-variables-1.PNG)  
![env-setup-2](https://github.com/vikas-bandaru/learn-web-dev/blob/main/jdbc/images/env-variables-2.PNG)  

 Confirm successful JDK configuration by checking this in Command Prompt:  
 >`java -version`

 If you see the JDK version as 1.8.xxx, it's a success.
5. Configure Apache Tomcat v9.0 Server in Eclipse Java EE perspective
![eclipse-tomcat-setup-1](https://github.com/vikas-bandaru/learn-web-dev/blob/main/jdbc/images/eclipse-tomcat-setup-1.PNG)  
![eclipse-tomcat-setup-2](https://github.com/vikas-bandaru/learn-web-dev/blob/main/jdbc/images/eclipse-tomcat-setup-2.PNG)  
![eclipse-tomcat-setup-3](https://github.com/vikas-bandaru/learn-web-dev/blob/main/jdbc/images/eclipse-tomcat-setup-3.PNG)  
![eclipse-tomcat-setup-4](https://github.com/vikas-bandaru/learn-web-dev/blob/main/jdbc/images/eclipse-tomcat-setup-4.PNG)  
![eclipse-tomcat-setup-5](https://github.com/vikas-bandaru/learn-web-dev/blob/main/jdbc/images/eclipse-tomcat-setup-5.PNG)  

### Create a new Dynamic Web Project in Eclipse and observe the Project File Structure
1. Create a new Dynamic Web Project  
![web-project-1](https://github.com/vikas-bandaru/learn-web-dev/blob/main/jdbc/images/web-project-1.PNG)  
![web-project-2](https://github.com/vikas-bandaru/learn-web-dev/blob/main/jdbc/images/web-project-2.PNG)  
![web-project-3](https://github.com/vikas-bandaru/learn-web-dev/blob/main/jdbc/images/web-project-3.PNG)  
#### Observe the Project File Structure
![project-file-structure-1](https://github.com/vikas-bandaru/learn-web-dev/blob/main/jdbc/images/project-file-structure-1.PNG)  
##### Create files and check how they are created in the respective files automatically
Create a HTML file by Right-clicking on Project name and choosing HTML file from menu.  
![create-html-file-1](https://github.com/vikas-bandaru/learn-web-dev/blob/main/jdbc/images/create-html-file-1.PNG)  
Enter the file name as `index.html` and press Finish button  
![create-html-file-2](https://github.com/vikas-bandaru/learn-web-dev/blob/main/jdbc/images/create-html-file-2.PNG)  

##### Exercise
Create a Java class by Right-clicking on Project name and choosing Class from menu.  
Enter the file name as `Sample` and press Finish button  
Observe where this file is created in the Project File Structure.  

###### To be updated:
1. Provide a form with action attribute, input with name attribute, button with submit type
2. Provide a Servlet with doGet() to greet the user in browser
3. Update the behaviour to get the data from database and print the same in browser
4. Update the behaviour to get all the records from database and print the same in browser
