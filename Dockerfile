# Etapa 1: Compilación (Build)
# CAMBIO AQUÍ: Usamos la imagen oficial de Maven que incluye JDK 17
FROM maven:3.9-openjdk-17 AS build 

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia los archivos de Maven
COPY pom.xml .
COPY src /app/src

# Ejecuta la compilación de Maven
RUN mvn clean install -DskipTests

# --- Etapa 2: Ejecución (Runtime) ---
# Mantenemos esta imagen ligera que ya funcionó para la ejecución
FROM eclipse-temurin:17-jre-alpine

# Establece el puerto de tu aplicación (Spring Boot default)
EXPOSE 8080

# Copia el JAR ejecutable de la etapa de 'build'
COPY --from=build /app/target/vhao-system-0.0.1-SNAPSHOT.jar app.jar

# Comando para ejecutar la aplicación Spring Boot
CMD ["java", "-jar", "/app.jar"]