FROM node:18-alpine
LABEL authors="oleh_khalanskyi"
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
EXPOSE 3000
CMD ["npm","start"]