FROM php:7.1-fpm

# Install Python 2.7 and pip
RUN apt-get update && apt-get install -y \
    python2.7 \
    python-pip \
    && pip install --upgrade pip \
    && ln -sf /usr/bin/python2.7 /usr/bin/python \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 13.x and npm
RUN curl -sL https://deb.nodesource.com/setup_13.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g webpack webpack-dev-server

# Install Composer 1.10.26
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=1.10.26

# Set the working directory to /app
WORKDIR /srv

COPY ./app WORKDIR

# Mount the application directory as a volume
VOLUME /app

# Start a shell with TTY enabled
CMD ["/bin/bash", "-i", "-t"]