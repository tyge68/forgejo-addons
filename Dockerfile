# Dockerfile

# Base image for the add-on
FROM codeberg.org/forgejo/forgejo:8

# Set environment variables
ENV USER=forgejo
ENV UID=1000
ENV GID=1000
ENV FORGEJO_HOME=/var/lib/forgejo

# Check if the group exists, if not, create it
RUN getent group ${GID} || addgroup -g ${GID} forgejo \
  && getent passwd ${UID} || adduser -u ${UID} -G forgejo -h ${FORGEJO_HOME} -D forgejo

# Create directories and set permissions
RUN mkdir -p /var/lib/forgejo /etc/forgejo /var/log/forgejo \
  && chown -R forgejo:forgejo /var/lib/forgejo /etc/forgejo /var/log/forgejo

# Switch to the newly created user
USER forgejo

# Expose the necessary ports
EXPOSE 3000 22

# Copy your run script (if needed) and set the correct permissions
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

RUN setcap 'cap_net_bind_service=+ep' /usr/local/bin/gitea

# Set the entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]