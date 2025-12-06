# Etapa 1: Compilación (Build)
# Usa imagen con JDK
FROM maven:3.9-jdk-17 AS build

# Establece el directorio de trabajo
WORKDIR /app

# Copia archivo pom y descarga dependencias
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copia el resto del código
COPY src ./src

# Compila
RUN mvn clean package -DskipTests

# Etapa 2: Ejecutable
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
