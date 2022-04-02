FROM node:lts-alpine3.14
    
RUN mkdir /app
WORKDIR   /app

COPY ./devops-challenge/* /app

RUN npm install

EXPOSE 3000

ENTRYPOINT ["npm","start"]