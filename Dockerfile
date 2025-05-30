#stage1 install maven dependencies

FROM maven:3.8.6-openjdk-18 AS build

WORKDIR /src

COPY . /src/

RUN mvn clean install -DskipTests=true

#stage2 build the application

FROM openjdk:17-jdk-alpine

COPY  --from=build /src/target/*.jar /src/target/bankapp.jar

EXPOSE 8080

CMD [ "java", "-jar", "/src/target/bankapp.jar" ]
