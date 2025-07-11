FROM node:18-alpine AS builder

RUN apk add --no-cache git go make

RUN git clone https://github.com/terrastruct/d2.git /d2-src \
 && cd /d2-src \
 && git checkout v0.7.0 \
 && make build

FROM node:18-alpine

COPY --from=builder /d2-src/build/d2 /usr/local/bin/d2
RUN chmod +x /usr/local/bin/d2

WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install

COPY src/ ./src/

EXPOSE 9090
CMD ["npm", "start"]
