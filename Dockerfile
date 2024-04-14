# Use an official Maven image as a parent image
FROM maven:3.8.5-openjdk-11 AS build
 
# Set the working directory in the container
WORKDIR /app
 
# Copy the Maven project's pom.xml to the container
COPY pom.xml .
 
# Copy the entire Maven project source code to the container
COPY src ./src
 
# Build the Maven project (package the application)
RUN mvn package
 
# Set the working directory in the container
WORKDIR /app
 
# Copy the built JAR file from the Maven build stage to the runtime container
COPY --from=build /app/target/my-app-1.0-SNAPSHOT.jar ./app.jar

