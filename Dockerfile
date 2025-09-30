# Use nginx as base image for serving static HTML
FROM nginx:alpine

# Remove default nginx website
RUN rm -rf /usr/share/nginx/html/*

# Copy the survey application files to nginx html directory
COPY index.html /usr/share/nginx/html/
COPY survey.html /usr/share/nginx/html/
COPY error.html /usr/share/nginx/html/
COPY image_swe.jpg /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]