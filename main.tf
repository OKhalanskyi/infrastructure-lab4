terraform {
  cloud {
    organization = "rolex-iit"

    workspaces {
      name = "iit-lab6"
    }
  }
}


provider "aws" {
  region     = "us-east-1"
  access_key = "AKIARYNKRUTOYJCM7BH7"
  secret_key = "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"
}

resource "aws_default_vpc" "default_vpc" {
  tags = {
    Name = "default vpc"
  }
}

resource "aws_security_group" "security_group" {
  name = "security group lab4"
  description = "allow http ssh"

  ingress {
    description = "http"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ssh"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["95.67.77.242/32"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2_server" {
  ami = "ami-007855ac798b5175e"
  instance_type = "t2.micro"
  key_name = "lab6"
  vpc_security_group_ids = [aws_security_group.security_group.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install -y docker.io
              sudo docker pull okhalanskyi/lab4
              sudo docker run -d -p 80:3000 okhalanskyi/lab4
              EOF

  tags = {
    Name = "Lab6Tf"
  }
}

