FROM ubuntu:18.10

RUN apt-get update \
  && apt-get install -y software-properties-common \
  && add-apt-repository -y ppa:maarten-fonville/protobuf \
  && apt-get install -y openjdk-11-jdk protobuf-compiler curl

ENV JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"

RUN curl https://letsencrypt.org/certs/lets-encrypt-x3-cross-signed.pem.txt -o lets-encrypt-x3-cross-signed.pem.txt
RUN keytool -trustcacerts -keystore "$JAVA_HOME/lib/security/cacerts" -storepass changeit -noprompt -importcert -file lets-encrypt-x3-cross-signed.pem.txt

RUN export JAVA_OPTS="-Djavax.net.ssl.trustStore=$JAVA_HOME/lib/security/cacerts -Djavax.net.ssl.trustStorePassword=changeit"
