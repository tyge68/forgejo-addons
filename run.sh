#!/bin/bash
set -e

# Check if this is the first run
if [ ! -f /var/lib/forgejo/.setup_done ]; then
  echo "First time setup..."
  
  # Run the setup or any other necessary initializations
  su-exec forgejo /usr/local/bin/gitea migrate
  
  touch /var/lib/forgejo/.setup_done
fi

# Start Forgejo service
echo "Starting Forgejo service..."
exec su-exec forgejo /usr/local/bin/gitea web
