# Stage 1: Build the application
FROM gradle:8.4.0-jdk17 AS builder

WORKDIR /app

# Copy source files
COPY package*.json ./
COPY build.gradle .
COPY settings.gradle .
COPY src ./src

# Build the project (create JAR)
RUN gradle build --no-daemon

# Stage 2: Create minimal runtime image
FROM eclipse-temurin:17-jre

WORKDIR /app

# Copy the built JAR file from builder
COPY --from=builder /app/build/libs/*.jar app.jar

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]


# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json (or yarn.lock)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Expose the port the app will run on
EXPOSE 3000

# Run the application
CMD ["npm", "start"]
