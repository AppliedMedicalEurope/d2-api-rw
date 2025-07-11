FROM node:18-alpine

# Install curl, tar, and libc compatibility (required for some binaries)
RUN apk add --no-cache curl tar libc6-compat

# Set D2 version and architecture
ENV D2_VERSION=v0.7.0
ENV D2_FILENAME=d2-${D2_VERSION}-linux-amd64.tar.gz

# Download and install D2 binary
RUN curl -L -o d2.tar.gz https://github.com/terrastruct/d2/releases/download/${D2_VERSION}/${D2_FILENAME} && \
    tar -xzf d2.tar.gz && \
    mv d2 /usr/local/bin/d2 && \
    chmod +x /usr/local/bin/d2 && \
    rm d2.tar.gz

WORKDIR /app
COPY . .

RUN npm install

EXPOSE 9090
CMD ["npm", "start"]
