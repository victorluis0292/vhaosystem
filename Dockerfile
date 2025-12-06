# ---------- Etapa 1: Compilar ----------
FROM maven:3.9.9-eclipse-temurin-17 AS build

WORKDIR /app

# Copia archivo POM y descarga dependencias
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copia el código fuente
COPY src ./src

# Compila y crea el JAR
RUN mvn clean package -DskipTests

# ---------- Etapa 2: Ejecutar ----------
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Copia el jar ya compilado
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
