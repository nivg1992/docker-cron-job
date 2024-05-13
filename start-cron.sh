#!/bin/sh

# Check if both COMMAND and SCRIPT_CONTENT are set
if [ -n "$COMMAND" ] && [ -n "$SCRIPT_FILE" ]; then
    echo "Error: Only one of COMMAND or SCRIPT_CONTENT environment variables should be set."
    exit 1
fi

# Check if neither COMMAND nor SCRIPT_CONTENT is set
if [ -z "$COMMAND" ] && [ -z "$SCRIPT_FILE" ]; then
    echo "Error: Either COMMAND or SCRIPT_CONTENT environment variable must be set."
    exit 1
fi

# Write the command passed as an environment variable to a file
if [ -n "$COMMAND" ]; then
    echo "$COMMAND" > /app/script.sh
    chmod +x /app/script.sh
    echo "$CRON_FREQ /app/script.sh > /dev/stdout" >> /etc/crontabs/root
fi

# Write the script content passed as an environment variable to a script file
if [ -n "$SCRIPT_FILE" ]; then
    echo "$CRON_FREQ $SCRIPT_FILE > /dev/stdout" >> /etc/crontabs/root
fi

# Start cron service in the foreground
crond -f
