# Use the official NGINX image
FROM nginx:1.17.6

# Set the working directory to NGINX's HTML directory
WORKDIR /usr/share/nginx/html

# Remove the default NGINX static assets
RUN rm -rf ./*

# Copy your built Angular application to the NGINX HTML directory
COPY app/dist/angular-frontend/ .

# Copy the NGINX configuration file
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80 (default HTTP port)
EXPOSE 80

# Start NGINX with daemon off
CMD ["nginx", "-g", "daemon off;"]
