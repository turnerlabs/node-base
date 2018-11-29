FROM node:8.12.0-alpine
LABEL maintainer="ISO Engineering <isoengineering@turner.com>"

# Perform some setup
RUN apk --no-cache add ca-certificates shadow

# Supress error about no mailbox when adding user
RUN sed -i 's/^CREATE_MAIL_SPOOL=yes/CREATE_MAIL_SPOOL=no/' /etc/default/useradd

RUN find / -perm +6000 -type f -exec chmod a-s {} \; || true

# Add nonroot user 
RUN /usr/sbin/groupadd webuser && \
      useradd -K MAIL_DIR=/dev/null -g webuser -m -s /sbin/nologin -c "Docker image user" webuser

# Clean Up
RUN rm -rf /var/cache/apk/*

# Set user
USER webuser

# Start up 
CMD [ "node" ]

