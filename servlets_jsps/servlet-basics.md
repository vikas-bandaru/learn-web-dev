# Java Servlet Basics
Find Java Servlet API [here](https://docs.oracle.com/javaee/7/api/overview-summary.html).
Find Apache Tomcat v9.0's implementation of Java Servlet API [here](https://tomcat.apache.org/tomcat-9.0-doc/servletapi/index.html).

## Setup Your Environment for Servlet Programming
1. Make sure JDK 1.8 is installed
2. Make sure compatible Eclipse for Java EE is available (Java Neon 3 is good)
3. Download zip file of Apache Tomcat v9.0 and extract it to safe location
4. Setup Environment Variables for JDK_HOME, JRE_HOME, CATALINA_HOME, and Path variable with JRE
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
