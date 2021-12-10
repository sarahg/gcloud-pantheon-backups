# syntax=docker/dockerfile:1

# Use Pantheon's PHP CI image.
FROM quay.io/pantheon-public/build-tools-ci:6.x

# Create and change to the app directory.
WORKDIR /app

# Install node dependencies.
COPY ["package.json", "package-lock.json*", "./"]
RUN npm install --production

# Add our source code into the image.
COPY . .

# Start the node server.
CMD [ "node", "index.js" ]