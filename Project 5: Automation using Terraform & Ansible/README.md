# Terraform SSH Key Setup and Deployment
## Steps to Deploy

### 1. Generate SSH Keys
Update your public IP in vars.tf file (include cidr block)

### 2. Generate SSH Keys
Generate SSH keys using the following command:
```bash
    ssh-keygen
```
Use name to be `tfprod`. If you use a different name, update it in `./instance.tf`.

### 3. Initialize Terraform
Initialize Terraform in the project directory:
```bash
   terraform init
```

### 4. Plan Infrastructure
Generate an execution plan and see what changes Terraform will make:
```bash
   terraform plan
```

### 5. Apply Changes
Apply the Terraform execution plan to provision infrastructure:
```bash
   terraform apply
```

Follow the prompts and confirm with `yes` when ready.

### 6. Set Environment Variables
After provisioning, set environment variables using the provided script:
```bash
    ./set_vars.sh
```

This script will configure necessary environment variables for your application.

