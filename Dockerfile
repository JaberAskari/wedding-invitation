# Use the official Nginx image as the base
FROM nginx:alpine

# Copy website files to the Nginx html directory
COPY . /usr/share/nginx/html

# Expose port 80 to the outside world
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
