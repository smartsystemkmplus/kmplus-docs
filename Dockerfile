# Use official Node.js image
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Install dependencies
COPY . ./
RUN yarn install --frozen-lockfile

# Copy the rest of the app
COPY . .

# Build the Docusaurus site
RUN yarn build

# Use Nginx to serve the static site
FROM nginx:alpine

# Copy built files to Nginx public directory
COPY --from=builder /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
