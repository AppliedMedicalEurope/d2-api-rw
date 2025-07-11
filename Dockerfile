FROM node:18-alpine

# Install dependencies needed for D2 CLI
RUN apk add --no-cache curl tar libc6-compat

# Set version and file names
ENV D2_VERSION=v0.7.0
ENV D2_FILENAME=d2-${D2_VERSION}-linux-amd64.tar.gz
ENV D2_FOLDER=d2-${D2_VERSION}

# Download, extract, and install D2
RUN curl -L -o d2.tar.gz https://github.com/terrastruct/d2/releases/download/${D2_VERSION}/${D2_FILENAME} && \
    tar -xzf d2.tar.gz && \
    mv ${D2_FOLDER}/d2 /usr/local/bin/d2 && \
    chmod +x /usr/local/bin/d2 && \
    rm -rf d2.tar.gz ${D2_FOLDER}

# App setup
WORKDIR /app
COPY . .
RUN npm install

EXPOSE 9090
CMD ["npm", "start"]
