# Dockerfile

# Base image for the add-on
FROM codeberg.org/forgejo/forgejo:8

# Set environment variables for Forgejo
ENV USER=forgejo
ENV UID=1000
ENV GID=1000
ENV FORGEJO_HOME=/var/lib/forgejo
ENV GITEA_WORK_DIR=/var/lib/forgejo

# Create necessary directories for Forgejo
RUN mkdir -p /var/lib/forgejo /etc/forgejo /var/log/forgejo

# Set permissions for the Forgejo directories
RUN chown -R ${UID}:${GID} /var/lib/forgejo /etc/forgejo /var/log/forgejo

# Expose the HTTP and SSH ports
EXPOSE 3000 22

# Copy the run script to the container
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Define the entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]
