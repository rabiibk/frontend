FROM node:14.17.6-buster-slim AS builder 
# Set working directory
WORKDIR /app
# Copy all files from current directory to working dir in image
COPY  .  .
#COPY package*.json /app

# install node modules and build assets
#RUN npm cache clean -force
#RUN npm i -g @angular/cli@16.0.0-next.4  --no-package-lock  
RUN  npm install  -g @angular/cli@13.3.8     
#RUN  npm install --save-dev @angular-devkit/build-angular
##RUN npm install  &&  npm run ng  build 
# nginx state for serving content
FROM nginx:1.17.6
# Set working directory to nginx asset directory
WORKDIR /usr/share/nginx/html
# Remove default nginx static assets
RUN rm -rf ./*
# Copy static assets from builder stage
COPY --from=builder app/dist/angular-final /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/conf/default.conf

 # Containers run nginx with global directives and daemon off
EXPOSE 80 
ENTRYPOINT ["nginx", "-g", "daemon off;"]
