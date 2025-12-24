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


#FROM redhat/ubi9
#
## Install Node.js 20
#RUN dnf module disable nodejs -y \
#    && dnf module enable nodejs:20 -y \
#    && dnf install -y nodejs \
#    && dnf clean all
#
## Create app directory and user
#RUN useradd -m -d /app roboshop
#
#WORKDIR /app
#USER roboshop
#
## Copy dependency files first (better caching)
#COPY --chown=roboshop:roboshop package*.json ./
#
## Install dependencies
#RUN npm install --production
#
## Copy application code
#COPY --chown=roboshop:roboshop server.js run.sh ./
#
## Optional: expose port (e.g., 8080)
#EXPOSE 8080
#
## Use CMD for flexibility (ENTRYPOINT is also fine if fixed)
#CMD ["bash", "/app/run.sh"]
