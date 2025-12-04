# Etapa 1: Compilación (Build)
# Usamos una imagen de Maven más robusta que ya incluye JDK 17
FROM eclipse-temurin:17-jdk-alpine AS build

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia los archivos de Maven
COPY pom.xml .
COPY src /app/src

# Ejecuta la compilación de Maven
RUN mvn clean install -DskipTests

# --- Etapa 2: Ejecución (Runtime) ---
# Usamos una imagen más ligera (solo JRE, no JDK) para el servidor final
FROM eclipse-temurin:17-jre-alpine

# Establece el puerto de tu aplicación (Spring Boot default)
EXPOSE 8080

# Copia el JAR ejecutable de la etapa 'build'
# Usamos el nombre exacto de tu artefacto que obtuvimos del pom.xml
COPY --from=build /app/target/vhao-system-0.0.1-SNAPSHOT.jar app.jar

# Comando para ejecutar la aplicación Spring Boot
CMD ["java", "-jar", "/app.jar"]