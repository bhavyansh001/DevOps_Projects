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
# Get Terraform outputs
APP_HOST=$(terraform output -raw application_ip)
DB_HOST=$(terraform output -raw database_ip)
REDIS_HOST=$(terraform output -raw redis_ip)

# Save the variables to a file
cat <<EOF > env_vars.sh
export APP_NAME='$APP_NAME'
export RUBY_VERSION='$RUBY_VERSION'
export POSTGRES_DEPLOY_PASSWORD='$POSTGRES_DEPLOY_PASSWORD'
export SECRET_KEY_BASE='$SECRET_KEY_BASE'
export RAILS_MASTER_KEY='$RAILS_MASTER_KEY'
export APP_HOST='$APP_HOST'
export DB_HOST='$DB_HOST'
export REDIS_HOST='$REDIS_HOST'
export ANSIBLE_USER='ubuntu'
export ANSIBLE_SSH_PRIVATE_KEY_FILE='../tfprod'
export POSTGRESQL_VERSION='14'
export POSTGRESQL_USER='deploy'
EOF

echo "Variables collected and saved to env_vars.sh. Now initiating transfer"

# Get the Ansible controller public IP from Terraform output
ANSIBLE_CONTROLLER_IP=$(terraform output -raw ansible_controller_ip)

# Ensure the playbook folder exists
PLAYBOOK_FOLDER_PATH="./ansible-playbook"

if [[ ! -d "$PLAYBOOK_FOLDER_PATH" ]]; then
  echo "Playbook folder not found at $PLAYBOOK_FOLDER_PATH"
  exit 1
fi

# Copy the tfprod key to the Ansible controller first
scp -i "tfprod" "tfprod" ubuntu@"$ANSIBLE_CONTROLLER_IP":~

# Transfer env_vars.sh and the playbook folder to the Ansible controller
scp -i "tfprod" "./env_vars.sh" ubuntu@"$ANSIBLE_CONTROLLER_IP":~
scp -ri "tfprod" "$PLAYBOOK_FOLDER_PATH" ubuntu@"$ANSIBLE_CONTROLLER_IP":~

# SSH into the Ansible controller and run the playbook
ssh -i "tfprod" ubuntu@"$ANSIBLE_CONTROLLER_IP" << EOF
  source ~/env_vars.sh
  cd ansible-playbook/
  ansible-playbook app_prod.yml
EOF
