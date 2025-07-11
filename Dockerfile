FROM node:18-alpine AS builder

# Install Go and Git
RUN apk add --no-cache git go

# Clone D2 source at v0.7.0
RUN git clone --depth 1 --branch v0.7.0 https://github.com/terrastruct/d2.git /d2-src

# Build D2 CLI from proper path
WORKDIR /d2-src
RUN go build -o /usr/local/bin/d2 ./cmd/d2

# Final container
FROM node:18-alpine

# Copy built D2 binary
COPY --from=builder /usr/local/bin/d2 /usr/local/bin/d2
RUN chmod +x /usr/local/bin/d2

# Node app setup
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY src/ ./src/

EXPOSE 9090
CMD ["npm", "start"]
