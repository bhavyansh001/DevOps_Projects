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
read -p "Enter the Ansible app server host (Private IP): " APP_HOST
read -p "Enter the Ansible database server host (Private IP): " DB_HOST
read -p "Enter the Ansible Redis server host (Private IP): " REDIS_HOST
read -p "Enter the Ansible user: " ANSIBLE_USER
read -p "Enter the Ansible SSH private key file path: " ANSIBLE_SSH_PRIVATE_KEY_FILE
read -p "Enter the PostgreSQL version: " POSTGRESQL_VERSION
read -p "Enter the PostgreSQL user: " POSTGRESQL_USER

# Define the environment variable names
VARIABLES=("APP_NAME" "RUBY_VERSION" "POSTGRES_DEPLOY_PASSWORD" "SECRET_KEY_BASE" "RAILS_MASTER_KEY" "APP_HOST" "DB_HOST" "REDIS_HOST" "ANSIBLE_USER" "ANSIBLE_SSH_PRIVATE_KEY_FILE" "POSTGRESQL_VERSION" "POSTGRESQL USER")

# Remove existing entries from ~/.bashrc
for VAR in "${VARIABLES[@]}"; do
  sed -i "/^export $VAR=/d" ~/.bashrc
done

# Export variables to ~/.bashrc
echo "export APP_NAME='$APP_NAME'" >> ~/.bashrc
echo "export RUBY_VERSION='$RUBY_VERSION'" >> ~/.bashrc
echo "export POSTGRES_DEPLOY_PASSWORD='$POSTGRES_DEPLOY_PASSWORD'" >> ~/.bashrc
echo "export SECRET_KEY_BASE='$SECRET_KEY_BASE'" >> ~/.bashrc
echo "export RAILS_MASTER_KEY='$RAILS_MASTER_KEY'" >> ~/.bashrc
echo "export APP_HOST='$APP_HOST'" >> ~/.bashrc
echo "export DB_HOST='$DB_HOST'" >> ~/.bashrc
echo "export REDIS_HOST='$REDIS_HOST'" >> ~/.bashrc
echo "export ANSIBLE_USER='$ANSIBLE_USER'" >> ~/.bashrc
echo "export ANSIBLE_SSH_PRIVATE_KEY_FILE='$ANSIBLE_SSH_PRIVATE_KEY_FILE'" >> ~/.bashrc
echo "export POSTGRESQL_VERSION='$POSTGRESQL_VERSION'" >> ~/.bashrc
echo "export POSTGRESQL_USER='$POSTGRESQL_USER'" >> ~/.bashrc

# Source ~/.bashrc
source ~/.bashrc

echo "Environment variables have been set and sourced."

# Echo the command to run Ansible playbook
echo "To run the Ansible playbook, use the following command:"
echo "source ~/.bashrc"
echo "ansible-playbook app_prod.yml"

