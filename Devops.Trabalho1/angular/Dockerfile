FROM node:18-alpine AS build

WORKDIR /app
COPY package*.json /app/

RUN yarn
COPY . /app

RUN yarn build:prod

FROM nginx:alpine
COPY anguar/dynamic-env.json /usr/share/nginx/html
COPY angular/nginx.conf  /etc/nginx/conf.d/default.conf

COPY --from=build /app/dist/Trabalho1 /usr/share/nginx/html
