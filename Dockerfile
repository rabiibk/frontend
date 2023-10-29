FROM nginx:1.17.6
# Set working directory to nginx asset directory
WORKDIR /usr/share/nginx/html
# Remove default nginx static assets
RUN rm -rf ./*
# Copy static assets from builder stage
COPY --from=builder app/dist/angular-frontend /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/conf/default.conf

 # Containers run nginx with global directives and daemon off
EXPOSE 80 
ENTRYPOINT ["nginx", "-g", "daemon off;"]
