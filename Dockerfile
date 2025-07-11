FROM node:18-alpine

# Install dependencies
RUN apk add --no-cache curl unzip

# Download and install specific D2 release
ENV D2_VERSION=v0.6.4
RUN curl -L -o d2.zip https://github.com/terrastruct/d2/releases/download/${D2_VERSION}/d2-alpine-amd64.zip && \
    unzip d2.zip -d /usr/local/bin && \
    rm d2.zip

WORKDIR /app
COPY . .

RUN npm install

EXPOSE 9090
CMD ["npm", "start"]
