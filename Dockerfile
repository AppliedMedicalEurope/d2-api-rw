FROM node:18-alpine

# Install required tools
RUN apk add --no-cache curl tar

# Use a stable D2 version
ENV D2_VERSION=v0.6.9

# Download and install D2 correctly
RUN curl -L -o /tmp/d2.tar.gz \
     https://github.com/terrastruct/d2/releases/download/${D2_VERSION}/d2-alpine-amd64.tar.gz \
  && tar -xzf /tmp/d2.tar.gz -C /tmp \
  && mv /tmp/d2 /usr/local/bin/d2 \
  && chmod +x /usr/local/bin/d2 \
  && rm /tmp/d2.tar.gz

WORKDIR /app
COPY . .
RUN npm install

EXPOSE 9090
CMD ["npm", "start"]
