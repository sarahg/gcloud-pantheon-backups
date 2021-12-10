# syntax=docker/dockerfile:1

# Use Pantheon's PHP CI image.
FROM quay.io/pantheon-public/php-ci:4.x

# Create and change to the app directory.
WORKDIR /app

# Copy local code to the container image.
COPY pan-sandbox-backups.sh ./

# Run the backup service on container startup.
CMD ["./pan-sandbox-backups.sh"]