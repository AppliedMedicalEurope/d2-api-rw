FROM node:18-alpine

# Install tools and glibc compatibility (required for D2 binary)
RUN apk add --no-cache curl tar libc6-compat

# Set version + filename
ENV D2_VERSION=v0.7.0
ENV D2_FILENAME=d2-${D2_VERSION}-linux-amd64.tar.gz
ENV D2_DIR=d2-${D2_VERSION}-linux-amd64

# Download and install D2 properly
RUN curl -L -o d2.tar.gz https://github.com/terrastruct/d2/releases/download/${D2_VERSION}/${D2_FILENAME} && \
    tar -xzf d2.tar.gz && \
    mv ${D2_DIR}/d2 /usr/local/bin/d2 && \
    chmod +x /usr/local/bin/d2 && \
    rm -rf d2.tar.gz ${D2_DIR}

# App setup
WORKDIR /app
COPY . .
RUN npm install

EXPOSE 9090
CMD ["npm", "start"]
