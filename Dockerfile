# Usa una imagen base que ya tiene Java y Maven preinstalados
FROM maven:3.8.6-openjdk-17 AS build

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia los archivos de Maven para descargar las dependencias
COPY pom.xml .
COPY src /app/src

# Ejecuta la compilación de Maven
RUN mvn clean install -DskipTests

# --- Segunda etapa: Imagen de ejecución ligera ---
# Usa una imagen solo con Java, sin Maven, para un tamaño más pequeño
FROM openjdk:17-jdk-slim

# Establece el puerto de tu aplicación
EXPOSE 8080

# Copia el JAR ejecutable de la etapa 'build'
COPY --from=build /app/target/*.jar app.jar

# Comando para ejecutar la aplicación Spring Boot
CMD ["java", "-jar", "/app.jar"]