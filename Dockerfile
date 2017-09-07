FROM debian:9
MAINTAINER Daniel Jensen
ENV VERSION 3.2.1.Final
RUN apt-get update && apt-get install -y openjdk-8-jdk maven git
RUN git clone https://github.com/keycloak/keycloak.git keycloak-source
WORKDIR /keycloak-source
RUN git checkout $VERSION
RUN mvn install -Pdistribution
RUN mkdir /keycloak && cp distribution/server-dist/target/keycloak-*/ /keycloak
WORKDIR /keycloak
RUN ls -la /keycloak
RUN exit 1
CMD ["bash"]
