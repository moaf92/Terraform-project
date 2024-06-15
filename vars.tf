variable "AWS_REGION" {
  default = "us-east-1"
}

variable "AMIS" {
  type = map(any)
  default = {
    us-east-1 = "ami-04b70fa74e45c3917"
  }
}

variable "PRIV_KEY_PATH" {
  default = "projectkey"
}

variable "PUB_KEY_PATH" {
  default = "projectkey.pub"
}

variable "USERNAME" {
  default = "ubuntu"
}

variable "MYIP" {
  default = "0.0.0.0/0"
}
variable "rmquser" {
  default = "rabbit"
}

variable "rmqpass" {
  default = "rabbit@12345678"
}

variable "dbuser" {
  default = "admin"
}

variable "dbpass" {
  default = "admin123"
}

variable "dbname" {
  default = "accounts"
}

variable "instance_count" {
  default = "1"
}

variable "VPC_NAME" {
  default = "project-VPC"
}

variable "Zone1" {
  default = "us-east-1a"
}

variable "Zone2" {
  default = "us-east-1b"
}

variable "Zone3" {
  default = "us-east-1c"
}

variable "VPC_CIDR" {
  default = "172.21.0.0/16"
}

variable "pubsub1CIDR" {
  default = "172.21.1.0/24"
}

variable "pubsub2CIDR" {
  default = "172.21.2.0/24"
}

variable "pubsub3CIDR" {
  default = "172.21.3.0/24"
}

variable "prisub1CIDR" {
  default = "172.21.4.0/24"
}

variable "pivsub2CIDR" {
  default = "172.21.5.0/24"
}

variable "pivsub3CIDR" {
  default = "172.21.6.0/24"
}