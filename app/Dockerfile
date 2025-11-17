# https://docs.nodesource.com/docs/nsolid/quickstart/docker
# Interesting search: https://github.com/search?q=nodesource%2Fnsolid&type=code
FROM nodesource/nsolid:alpine-latest

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm ci --omit=dev

COPY server.js ./

EXPOSE 3000
CMD ["nsolid", "server.js"]
