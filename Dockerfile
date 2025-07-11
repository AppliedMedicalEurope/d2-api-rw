FROM node:18-alpine AS builder

# Install Go
RUN apk add --no-cache go

# Build D2 CLI directly using Go install
RUN go install oss.terrastruct.com/d2@v0.7.0

# Final image
FROM node:18-alpine

# Copy the built d2 binary from builder
COPY --from=builder /root/go/bin/d2 /usr/local/bin/d2
RUN chmod +x /usr/local/bin/d2

# App setup
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY src/ ./src/

EXPOSE 9090
CMD ["node", "src/index.js"]
