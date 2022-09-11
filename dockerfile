
# # develop stage
# FROM node:16-alpine as develop-stage
# # bind your app to the gateway IP
# ENV HOST=0.0.0.0
# WORKDIR /app
# COPY package*.json ./
# RUN npm install
# RUN npm install canvas-confetti
# RUN npm install @vue/cli@3.7.0 -g
# COPY . .
# CMD ["npm", "run", "serve"]




FROM node:latest as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
RUN npm install @vue/cli@3.7.0 -g
RUN npm install canvas-confetti
COPY ./ .
RUN npm run build

FROM nginx as production-stage
RUN mkdir /app
EXPOSE 8080
COPY --from=build-stage /app/dist /app
COPY nginx.conf /etc/nginx/nginx.conf