FROM maven:3.5.4-jdk-8 As Builder
WORKDIR /usr/build
COPY . .
RUN mvn clean package

FROM openjdk:8-jre-alpine3.7
WORKDIR /app
COPY --from=Builder /usr/build/target/dependency/webapp-runner.jar .
COPY --from=Builder /usr/build/target/*.war .
EXPOSE 8080
RUN ls -lart
#ENTRYPOINT ["/bin/sh"]
ENTRYPOINT ["java","-jar","webapp-runner.jar","java-tomcat-maven-example.war"]
