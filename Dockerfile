FROM node:18-alpine

# Install curl and tar
RUN apk add --no-cache curl tar

# Set D2 version
ENV D2_VERSION=v0.6.4

# Download and install D2
RUN curl -L -o d2.tar.gz https://github.com/terrastruct/d2/releases/download/${D2_VERSION}/d2-alpine-amd64.tar.gz && \
    mkdir -p /tmp/d2 && \
    tar -xzf d2.tar.gz -C /tmp/d2 && \
    mv /tmp/d2/d2 /usr/local/bin/d2 && \
    chmod +x /usr/local/bin/d2 && \
    rm -rf d2.tar.gz /tmp/d2

WORKDIR /app
COPY . .

RUN npm install

EXPOSE 9090
CMD ["npm", "start"]
