# Use the Gitpod base image for Python projects with 3.11
FROM gitpod/workspace-python:3.11

# Switch to root user to install system-level dependencies
USER root

# Install additional system dependencies
RUN apt-get update && apt-get install -y \
    git \
    graphviz \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
    && apt-get clean

# Switch back to the Gitpod user to maintain good security practices
USER gitpod

# Set the working directory to the juxtorpus project
WORKDIR /workspace/juxtorpus

# Preinstall pip dependencies to speed up builds
COPY requirements.txt /workspace/juxtorpus/requirements.txt
RUN pip install --upgrade pip && pip install -r requirements.txt

# Set bash as the default shell
ENTRYPOINT ["/bin/bash"]
