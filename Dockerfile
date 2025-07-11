FROM node:18-alpine

# Install required tools
RUN apk add --no-cache curl tar

# Install D2 from .tar.gz
ENV D2_VERSION=v0.6.4
RUN curl -L -o d2.tar.gz https://github.com/terrastruct/d2/releases/download/${D2_VERSION}/d2-alpine-amd64.tar.gz && \
    tar -xzf d2.tar.gz -C /usr/local/bin && \
    rm d2.tar.gz

WORKDIR /app
COPY . .

RUN npm install

EXPOSE 9090
CMD ["npm", "start"]
