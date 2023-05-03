FROM node:17-alpine
LABEL authors="oleh_khalanskyi"
WORKDIR /app
COPY package.json .
RUN npm install
EXPOSE 3000
CMD ["npm","start"]


ENTRYPOINT ["top", "-b"]