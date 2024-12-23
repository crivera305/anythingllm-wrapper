#!/bin/bash

# Exit the script if any command fails
set -e

# Pull the Ollama Docker Image
echo '#########################'
echo "# 1. Pulling Ollama image from Docker..."
sudo docker pull ollama/ollama

# Set up storage location for Ollama
echo '#########################'
echo "# 2. Setting up storage location for Ollama..."
export OLLAMA_STORAGE_LOCATION=$HOME/ollama && mkdir -p $OLLAMA_STORAGE_LOCATION && chmod 777 $OLLAMA_STORAGE_LOCATION

# Run the Ollama Docker container
echo '#########################'
echo "# 3. Running Ollama Docker container..."
export OLLAMA_STORAGE_LOCATION=$HOME/ollama && sudo docker run -d -p 11434:11434 --name ollama -v ${OLLAMA_STORAGE_LOCATION}:/mnt/ollama/storage ollama/ollama

# Run  Ollama llama3.2
echo '#########################'
echo "# 4. Run Ollama llama3.2..."
sudo docker exec ollama ollama run llama3.2

# Pull the AnythingLLM Docker Image
echo '#########################'
echo "# 5. Pulling AnythingLLM image from Docker..."
sudo docker pull mintplexlabs/anythingllm

# Set up storage location and environment file for AnythingLLM
echo '#########################'
echo "# 6. Setting up storage location for AnythingLLM..."
export STORAGE_LOCATION=$HOME/anythingllm && mkdir -p $STORAGE_LOCATION && chmod 777 $STORAGE_LOCATION && touch "$STORAGE_LOCATION/.env" && chmod 666 "$STORAGE_LOCATION/.env"

# Run the AnythingLLM Docker container
echo '#########################'
echo "# 7. Running AnythingLLM Docker container..."
export STORAGE_LOCATION=$HOME/anythingllm && sudo docker run -d -p 3001:3001 --name anythingllm  --cap-add SYS_ADMIN -v ${STORAGE_LOCATION}:/app/server/storage -v ${STORAGE_LOCATION}/.env:/app/server/.env -e STORAGE_DIR="/app/server/storage" mintplexlabs/anythingllm

# Final message
echo "Docker, Docker Compose, AnythingLLM, and Ollama (llama3.2) have been successfully installed and the containers are running!"

# End of script
