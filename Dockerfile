# JMeter based on Java 11
FROM eclipse-temurin:11-jre-focal

# Arguments
ARG JMETER_VERSION="5.6.2"
ARG JMETER_URL="https://dlcdn.apache.org/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz"

# Download and extract
RUN mkdir -p /opt/jmeter && \
    curl -sSLf "${JMETER_URL}" | tar -xzvf - --directory=/opt/jmeter --strip-components=1 --exclude=*/docs --exclude=*/printable_docs

# Create user
RUN groupadd jmeter &&\
    useradd -d /opt/jmeter -g jmeter -s /bin/bash jmeter &&\
    chown -R jmeter:jmeter /opt/jmeter

# Execution
USER jmeter
WORKDIR /opt/jmeter
ENTRYPOINT [ "/opt/jmeter/bin/jmeter", "-n" ]
