# updated image for java 17
FROM bellsoft/liberica-openjdk-alpine:11.0.20

RUN apk add curl jq

# Workspace
WORKDIR /usr/share/poc

# ADD .jar under target from host
# into this image
ADD target/selenium-docker.jar 			selenium-docker.jar
ADD target/selenium-docker-tests.jar 	selenium-docker-tests.jar
ADD target/libs							libs

# in case of any other dependency like .csv / .json / .xls
# please ADD that as well

# ADD suite files
ADD book-flight-module.xml				book-flight-module.xml
ADD search-module.xml					search-module.xml

# ADD health check script
#ADD healthcheck.sh                      healthcheck.sh

# ADD health check script
RUN wget https://s3.amazonaws.com/selenium-docker/healthcheck/healthcheck.sh

# BROWSER
# HUB_HOST
# MODULE

ENTRYPOINT sh healthcheck.sh
#ENTRYPOINT java -cp "selenium-docker.jar;selenium-docker-tests.jar;libs/*" -DBROWSER=$BROWSER org.testng.TestNG $MODULE