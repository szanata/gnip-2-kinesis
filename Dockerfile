FROM node:12.7.0-alpine

COPY index.js config.js package-lock.json package.json .npmrc /app/

WORKDIR /app

RUN npm install --production

CMD ["npm run start"]
