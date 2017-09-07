FROM debian:9
MAINTAINER Daniel Jensen
ENV VERSION 3.2.1.Final
RUN apt-get update && apt-get install -y openjdk-8-jdk maven git
RUN git clone https://github.com/keycloak/keycloak.git keycloak-source
WORKDIR /keycloak-source
RUN git checkout $VERSION
RUN mvn install -Pdistribution
RUN tar xfz distribution/server-dist/target/keycloak-*.tar.gz -C /
RUN ls -la /
WORKDIR /
RUN rm -rf /keycloak-source
RUN mv /keycloak-* /keycloak
WORKDIR /keycloak
RUN apt-get remove -y git maven openjdk-8-jdk && apt-get install -y openjdk-8-jre && apt-get autoremove -y
EXPOSE 80

CMD ["bin/standalone.sh"]
