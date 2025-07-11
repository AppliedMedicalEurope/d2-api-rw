FROM node:18-alpine

RUN apk add --no-cache curl tar libc6-compat

ENV D2_VERSION=v0.6.9
ENV D2_DIR=d2-${D2_VERSION}

RUN curl -L -o d2.tar.gz https://github.com/terrastruct/d2/releases/download/${D2_VERSION}/d2-${D2_VERSION}-linux-amd64.tar.gz && \
    tar -xzf d2.tar.gz && \
    mv ${D2_DIR}/d2 /usr/local/bin/d2 && \
    chmod +x /usr/local/bin/d2 && \
    rm -rf d2.tar.gz ${D2_DIR}

WORKDIR /app
COPY . .
RUN npm install

EXPOSE 9090
CMD ["npm", "start"]
