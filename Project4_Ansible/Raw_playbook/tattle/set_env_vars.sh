#!/bin/bash

# Prompt for variables
read -p "Enter the app name: " APP_NAME
read -p "Enter the Ruby version: " RUBY_VERSION
read -sp "Enter the PostgreSQL deploy password: " POSTGRES_DEPLOY_PASSWORD
echo
read -sp "Enter the secret key base: " SECRET_KEY_BASE
echo
read -sp "Enter the Rails master key: " RAILS_MASTER_KEY
echo
read -p "Enter the Ansible host (IP): " ANSIBLE_HOST
read -p "Enter the Ansible user: " ANSIBLE_USER
read -p "Enter the Ansible SSH private key file path: " ANSIBLE_SSH_PRIVATE_KEY_FILE

# Export variables to ~/.bashrc
echo "export APP_NAME='$APP_NAME'" >> ~/.bashrc
echo "export RUBY_VERSION='$RUBY_VERSION'" >> ~/.bashrc
echo "export POSTGRES_DEPLOY_PASSWORD='$POSTGRES_DEPLOY_PASSWORD'" >> ~/.bashrc
echo "export SECRET_KEY_BASE='$SECRET_KEY_BASE'" >> ~/.bashrc
echo "export RAILS_MASTER_KEY='$RAILS_MASTER_KEY'" >> ~/.bashrc
echo "export ANSIBLE_HOST='$ANSIBLE_HOST'" >> ~/.bashrc
echo "export ANSIBLE_USER='$ANSIBLE_USER'" >> ~/.bashrc
echo "export ANSIBLE_SSH_PRIVATE_KEY_FILE='$ANSIBLE_SSH_PRIVATE_KEY_FILE'" >> ~/.bashrc

# Source ~/.bashrc
source ~/.bashrc

echo "Environment variables have been set and sourced."

# Echo the command to run Ansible playbook
echo "To run the Ansible playbook, use the following command:"
echo "ansible-playbook tattle-prod.yaml"

