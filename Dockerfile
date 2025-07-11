FROM node:18-alpine AS builder

# Install Go and Git
RUN apk add --no-cache git go

# Clone the D2 source code
RUN git clone --depth 1 --branch v0.7.0 https://github.com/terrastruct/d2.git /d2-src

# Build D2 CLI
WORKDIR /d2-src/cmd/d2
RUN go build -o /usr/local/bin/d2

# Final image
FROM node:18-alpine

# Copy D2 binary
COPY --from=builder /usr/local/bin/d2 /usr/local/bin/d2
RUN chmod +x /usr/local/bin/d2

# App setup
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install

COPY src/ ./src/

EXPOSE 9090
CMD ["npm", "start"]
