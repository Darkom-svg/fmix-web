# Use a Debian base image
FROM debian:10

# Set environment variables for non-interactive installations
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages: Apache, PHP, and necessary extensions
RUN apt-get update && apt-get install -y \
  apache2 \
  php7.3 \
  libapache2-mod-php7.3 \
  && apt-get clean

# Enable Apache mods
RUN a2enmod php7.3 && a2enmod rewrite

# Set up the application directory
WORKDIR /var/www/html

# Copy application files to the container
COPY ./src/index.html /var/www/html
COPY ./src/registration.php /var/www/html
COPY ./src/submission.php /var/www/html
COPY ./src/scripts.js /var/www/html/scripts.js
COPY ./src/output.css /var/www/html/output.css


# Remove the default Apache index.html file
# RUN rm /var/www/html/index.html

# Ensure proper permissions
RUN chown -R www-data:www-data /var/www/html && chmod -R 775 /var/www/html

# Expose the web server's default port
EXPOSE 80

# Start Apache in the foreground
CMD apachectl -D FOREGROUND
