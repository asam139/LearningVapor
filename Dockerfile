# Download base image ubuntu 18.04
FROM ubuntu:18.04

# Update Ubuntu Software repository
# and install dependencies 
RUN apt-get update && \
apt-get install -y software-properties-common && \
apt-get install -y clang && \
apt-get install -y libcurl4 libpython2.7 libpython2.7-dev && \
apt-get install -y wget


# Add Vapor's APT repo
RUN /bin/bash -c "$(wget -qO- https://apt.vapor.sh)"

# Install Vapor
RUN apt-get install -y swift vapor
 