# Use the official Jenkins LTS image as base
FROM jenkins/jenkins:lts

# Switch to root to install packages
USER root

# Install Node.js 24.x and npm
RUN apt-get update && \
    apt-get install -y curl && \
    curl -fsSL https://deb.nodesource.com/setup_24.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Firebase CLI globally
RUN npm install -g firebase-tools

# Verify installations
RUN node --version && npm --version && firebase --version

# Install Jenkins plugins during build (so they are ready on first start)
RUN jenkins-plugin-cli --plugins \
    git \
    workflow-aggregator \
    pipeline-stage-view \
    github \
    github-branch-source \
    nodejs \
    credentials \
    credentials-binding

# Switch back to jenkins user for security
USER jenkins