# FROM openjdk:8
# EXPOSE 8082
# ADD target/petclinic.war petclinic.war
# ENTRYPOINT ["java","-jar","/petclinic.war"]


# FROM openjdk:8-jre-alpine

# ENV JAVA_OPTS="-Xms256m -Xmx512m"

# RUN addgroup -S petclinic && adduser -S petclinic -G petclinic

# EXPOSE 8082
# ADD target/petclinic.war /petclinic.war

# RUN chown petclinic:petclinic /petclinic.war && \
#     chmod 644 /petclinic.war
# USER petclinic

# ENTRYPOINT ["java", "-jar", "/petclinic.war"]

FROM openjdk:8-jre-alpine
ENV JAVA_OPTS="-Xms256m -Xmx512m"
RUN addgroup -S petclinic && adduser -S petclinic -G petclinic
EXPOSE 8082

ADD target/petclinic.war /petclinic.war
ADD petclinic.war.sha256 /petclinic.war.sha256
RUN echo "$(cat /petclinic.war.sha256)  /petclinic.war" | sha256sum -c - && \
    rm /petclinic.war.sha256

RUN chown petclinic:petclinic /petclinic.war && \
    chmod 644 /petclinic.war
USER petclinic

ENTRYPOINT ["java", "-jar", "/petclinic.war"]
