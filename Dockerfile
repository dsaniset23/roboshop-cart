FROM        redhat/ubi9
RUN         dnf module disable nodejs -y && \
            dnf module enable nodejs:20 -y && \
            dnf install nodejs -y && \
            dnf clean all
WORKDIR     /app
RUN         useradd -d /app roboshop && chown roboshop:roboshop /app
USER        roboshop
COPY        server.js package.json /app/
RUN         npm install
ENTRYPOINT  ["node", "/app/server.js"]