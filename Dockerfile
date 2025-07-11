FROM node:18-alpine

# Install D2 CLI
RUN apk add --no-cache curl unzip && \
    curl -LO https://github.com/terrastruct/d2/releases/latest/download/d2-alpine-amd64.zip && \
    unzip d2-alpine-amd64.zip -d /usr/local/bin && \
    rm d2-alpine-amd64.zip

WORKDIR /app
COPY . .

RUN npm install

EXPOSE 9090
CMD ["npm", "start"]
