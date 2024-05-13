# Use an existing base image with Alpine Linux
FROM alpine:latest

# Set working directory to /app
WORKDIR /app

# Install necessary packages (rsync, nfs-utils) and update package lists
RUN apk add --no-cache rsync nfs-utils busybox-extras docker-cli  && \
    rm -rf /var/cache/apk/*

# Add the startup script to the container
ADD start-cron.sh /app/start-cron.sh

# Make the script executable
RUN chmod +x /app/start-cron.sh

# Start cron service in the foreground
CMD ["/app/start-cron.sh"]