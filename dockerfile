
# develop stage
FROM node:16-alpine as develop-stage
# bind your app to the gateway IP
ENV HOST=0.0.0.0
WORKDIR /app
COPY package*.json ./
RUN npm install
RUN npm install canvas-confetti
RUN npm install @vue/cli@3.7.0 -g
COPY . .
CMD ["npm", "run", "serve"]


# FROM node:12.18.1-alpine as build-stage
# # make the 'app' folder the current working directory
# WORKDIR /app
# # copy both 'package.json' and 'package-lock.json' (if available)
# COPY package*.json ./
# # install project dependencies
# RUN npm install
# # copy project files and folders to the current working directory (i.e. 'app' folder)
# COPY . .
# # build app for production with minification
# RUN npm run build

# FROM nginx:1.19.0-alpine AS prod-stage
# #COPY --from=build /app/dist usr/share/nginx/html
# EXPOSE 80
# CMD  ["npm", "run", "serve"] 