FROM node:18-alpine

# Install required tools
RUN apk add --no-cache curl tar

# Use a known working D2 version
ENV D2_VERSION=v0.6.4

# Download and install D2 binary directly
RUN curl -L -o d2.tar.gz https://github.com/terrastruct/d2/releases/download/${D2_VERSION}/d2-alpine-amd64.tar.gz && \
    tar -xzf d2.
