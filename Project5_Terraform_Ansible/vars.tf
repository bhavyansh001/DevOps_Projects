variable "REGION" {
  default = "us-east-1"
}

variable "ZONE1" {
  default = "us-east-1b"
}

variable "AMIS" {
  type = map(any)
  default = {
    us-east-1 = "ami-0e001c9271cf7f3b9"
  }
}

variable "USER" {
  default = "ubuntu"
}

variable "MYIP" {
  default = "157.38.21.142/32"
}