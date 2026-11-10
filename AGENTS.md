# Project Overview
Java Web application using Jakarta Servlet/JSP (Tomcat 10.1 compatible) and MySQL.

# Build & Development
- **Build Tool:** Apache Maven
- **Packaging:** WAR (`target/agenda.war`)
- **Commands:**
  - Build: `mvn clean package`
- **Key Directories:**
  - `src/main/java`: Backend controllers (`Controller.java`) and models (`DAO.java`, `JavaBeans.java`).
  - `src/main/webapp`: Frontend resources (JSP/HTML/CSS).

# Database
- **Driver:** MySQL Connector/J 8.3.0.
- **Infrastructure:** `docker-compose.yml` is present for local environment setup.
