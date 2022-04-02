FROM node:lts-alpine3.14


RUN addgroup -S LAUNCHER && adduser -S LAUNCHER -G LAUNCHER

USER LAUNCHER

WORKDIR /home/LAUNCHER

COPY ./devops-challenge/* /home/LAUNCHER

RUN npm install

EXPOSE 3000

ENTRYPOINT ["npm","start"]