resource "aws_key_pair" "tf-key" {
  key_name   = "tfkey"
  public_key = file("tfprod.pub")
}


resource "aws_instance" "ansible_controller" {
  ami               = var.AMIS[var.REGION]
  instance_type     = "t2.micro"
  availability_zone = var.ZONE1
  key_name          = aws_key_pair.tf-key.key_name
  security_groups   = [aws_security_group.ansible_controller_sg.name]
  tags = {
    Name = "ansible-controller"
  }
  user_data = <<-EOF
              #!/bin/bash
              sudo -i
              apt update
              apt upgrade -y
              apt install software-properties-common -y
              add-apt-repository --yes --update ppa:ansible/ansible
              apt install -y ansible
              EOF
}

resource "aws_instance" "application" {
  ami               = var.AMIS[var.REGION]
  instance_type     = "t2.micro"
  availability_zone = var.ZONE1
  key_name          = aws_key_pair.tf-key.key_name
  security_groups   = [aws_security_group.application_sg.name]
  tags = {
    Name = "application"
  }
}

resource "aws_instance" "database" {
  ami               = var.AMIS[var.REGION]
  instance_type     = "t2.micro"
  availability_zone = var.ZONE1
  key_name          = aws_key_pair.tf-key.key_name
  security_groups   = [aws_security_group.backend_sg.name]
  tags = {
    Name = "database"
  }
}

resource "aws_instance" "redis" {
  ami               = var.AMIS[var.REGION]
  instance_type     = "t2.micro"
  availability_zone = var.ZONE1
  key_name          = aws_key_pair.tf-key.key_name
  security_groups   = [aws_security_group.backend_sg.name]
  tags = {
    Name = "redis"
  }
}


output "ansible_controller_ip" {
  value = aws_instance.ansible_controller.public_ip
}

output "application_ip" {
  value = aws_instance.application.private_ip
}

output "application_public_ip" {
  value = aws_instance.application.public_ip
}

output "database_ip" {
  value = aws_instance.database.private_ip
}

output "redis_ip" {
  value = aws_instance.redis.private_ip
}
