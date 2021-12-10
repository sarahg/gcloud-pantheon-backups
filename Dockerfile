# syntax=docker/dockerfile:1

# Use an official PHP runtime as a parent image
FROM php:7.4-cli

# Create and change to the app directory.
WORKDIR /app

# Copy local code to the container image.
COPY pan-sandbox-backups.sh ./

# Collect the components we need for this image
RUN apt-get update
RUN apt-get install -y curl

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Terminus
RUN mkdir -p /usr/local/share/terminus
RUN /usr/bin/env COMPOSER_BIN_DIR=/usr/local/bin composer -n --working-dir=/usr/local/share/terminus require pantheon-systems/terminus

# Run the backup service on container startup.
CMD ["./pan-sandbox-backups.sh"]