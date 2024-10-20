# Use the Gitpod workspace base image
FROM gitpod/workspace-base

# Set user to root to perform administrative tasks
USER root

# Set environment variables
ENV TZ=Australia/Sydney
ENV DEBIAN_FRONTEND=noninteractive

# Set the timezone and install required utilities
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
  apt-get update --quiet && \
  apt-get install --quiet --yes \
    apt-transport-https \
    apt-utils \
    sudo \
    git \
    less \
    wget \
    curl \
    tree \
    graphviz \
    zip \
    unzip \
    default-jre \
    ca-certificates

# Download and install Nextflow, set appropriate persmissions for execution
RUN curl -s https://get.nextflow.io | bash && \
  chmod 755 ./nextflow && \
  mv ./nextflow /usr/local/bin
  
# Create .nextflow directory and set proper permissions
RUN mkdir -p /workspace/hello-nextflow/.nextflow && \
chown -R gitpod:gitpod /workspace/hello-nextflow/.nextflow

# Change user back to gitpod to avoid running as root
USER gitpod

# Set the entrypoint ensuring when the container starts it uses a bash shell
#ENTRYPOINT ["/bin/bash"]
