# Stage 1: Build the Angular application
FROM node:14.17.6-buster-slim AS builder

# Set the working directory
WORKDIR /app

# Copy the package.json and package-lock.json files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application files
COPY . .

# Build the Angular application
RUN npm run build

# Stage 2: Create the final image with NGINX
FROM nginx:1.17.6

# Set the working directory to the NGINX asset directory
WORKDIR /usr/share/nginx/html

# Remove the default NGINX static assets
RUN rm -rf ./*

# Copy the built Angular app from the builder stage to the NGINX HTML directory
COPY --from=builder /app/dist/angular-frontend .

# Copy the NGINX configuration file
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80 (default HTTP port)
EXPOSE 80

# Start NGINX with daemon off
CMD ["nginx", "-g", "daemon off;"]
