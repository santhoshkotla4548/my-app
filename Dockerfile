# Use an official Maven image as a parent image
FROM maven:3.8.5-openjdk-11 AS build
 
# Set the working directory in the container
WORKDIR /app
 
# Copy the Maven project's pom.xml to the container
COPY pom.xml .
 
# Resolve all dependencies specified in the pom.xml and store them in the container cache
RUN mvn dependency:go-offline
 
# Copy the entire Maven project source code to the container
COPY src ./src
 
# Build the Maven project (package the application)
RUN mvn package
 
# Use a lightweight OpenJDK 11 JRE image for running the application
FROM openjdk:11-jre-slim
 
# Set the working directory in the container
WORKDIR /app
 
# Copy the built JAR file from the Maven build stage to the runtime container
COPY --from=build /app/target/my-app-1.0-SNAPSHOT.jar ./app.jar
 
# Specify the command to run the application when the container starts
CMD ["java", "-jar", "app.jar"]
