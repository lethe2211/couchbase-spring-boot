FROM gradle:jdk11 AS builder
WORKDIR /usr/src/couchbase-spring-boot
COPY couchbase-spring-boot/ .
RUN ./gradlew clean build

FROM openjdk:11
EXPOSE 8080
WORKDIR /opt/app
COPY --from=builder /usr/src/couchbase-spring-boot/build/libs/demo-0.0.1-SNAPSHOT.jar ./app.jar
ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "./app.jar"]