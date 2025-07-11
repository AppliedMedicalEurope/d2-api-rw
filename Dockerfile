FROM node:18-alpine

# Install required tools
RUN apk add --no-cache curl tar

# Use a valid D2 version
ENV D2_VERSION=v0.6.9

# Install D2
RUN curl -L -o d2.tar.gz https://github.com/terrastruct/d2/releases/download/${D2_VERSION}/d2-alpine-amd64.tar.gz && \
    tar -xzf d2.tar.gz -C /usr/local/bin && \
    chmod +x /usr/local/bin/d2 && \
    rm d2.tar.gz

WORKDIR /app
COPY . .
RUN npm install

EXPOSE 9090
CMD ["npm", "start"]
