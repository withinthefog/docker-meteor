# DOCKER-VERSION 1.8.1
# METEOR-VERSION 1.2.1
FROM debian:jessie

# change apt-get source to 163 mirror
RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak
COPY sources.list.jessie /etc/apt/sources.list

# Install git, curl
RUN apt-get update && \
   apt-get install -y git curl build-essential python && \
   (curl https://deb.nodesource.com/setup_4.x | sh) && \
   apt-get install -y nodejs jq && \
   apt-get clean && \
   rm -Rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install cnpm
RUN npm i -g cnpm

# Make sure we have a directory for the application
RUN mkdir -p /var/www
RUN chown -R www-data:www-data /var/www

RUN npm install -g semver

# Install entrypoint
COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

# Add known_hosts file
COPY known_hosts /root/.ssh/known_hosts

EXPOSE 80

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
CMD []
