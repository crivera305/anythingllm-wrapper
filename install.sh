#!/bin/bash

# Exit the script if any command fails
set -e

# Update the package index
echo "Updating package index..."
sudo apt update

# Install required dependencies
echo "Installing required dependencies..."
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common gnupg jq

# Add Docker's official GPG key
echo "Adding Docker's official GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Set up the Docker stable repository
echo "Setting up Docker repository..."
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the package index again after adding the Docker repository
echo "Updating package index again..."
sudo apt update

# Install Docker CE (Community Edition)
echo "Installing Docker..."
sudo apt install -y docker-ce

# Start and enable Docker service
echo "Starting and enabling Docker service..."
sudo systemctl start docker
sudo systemctl enable docker

echo "Verifying Docker installation..."
sudo docker --version

# Optionally add the current user to the Docker group for non-root access
echo "Adding the current user to the 'docker' group..."
sudo usermod -aG docker $USER
echo "Please log out and log back in for the Docker group changes to take effect."

# Install Docker Compose
echo "Installing Docker Compose..."
DOCKER_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | jq -r .tag_name)
sudo curl -L "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Verify Docker Compose installation
echo "Verifying Docker Compose installation..."
docker-compose --version


# Final message
echo "Prerequisites have been installed successfully!"

# End of script
