terraform {
  required_providers {
    aws = { source = "hashicorp/aws" }
  }
}

provider "aws" {
  region = var.region
}

variable "region" {
  default = "ap-south-1"
}

variable "prefix" {
  default = "Akshay_Kumar"
}

# Data: AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Create key pair local file (optional): you can create a key in console manually and update this
resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "deployer" {
  key_name   = "${var.prefix}_key"
  public_key = tls_private_key.key.public_key_openssh
}

resource "local_file" "private_key" {
  content  = tls_private_key.key.private_key_pem
  filename = "${path.module}/private_key.pem"
  file_permission = "0600"
}

# Security Group: allow HTTP from anywhere and SSH from your IP only (replace with your IP if needed)
data "http" "myip" {
  url = "https://checkip.amazonaws.com/"
}

resource "aws_security_group" "web_sg" {
  name        = "${var.prefix}_web_sg"
  description = "Allow HTTP and SSH"
  vpc_id = var.vpc_id # pass VPC id or create a VPC here; this assumes you created VPC in Task1 and know id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance in public subnet
resource "aws_instance" "web" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name               = aws_key_pair.deployer.key_name
  associate_public_ip_address = true
  tags = { Name = "${var.prefix}_ec2_web" }

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install -y nginx1
              systemctl enable nginx
              systemctl start nginx
              cat > /usr/share/nginx/html/index.html <<'EOM'
              <html>
                <head><title>Akshay Kumar - Resume</title></head>
                <body>
                  <h1>Akshay Kumar - Resume</h1>
                  <p>Put your resume HTML or link here.</p>
                </body>
              </html>
              EOM
              # basic hardening: allow only updates via yum-cron
              yum install -y yum-cron
              systemctl enable yum-cron
              EOF
}

output "public_ip" {
  value = aws_instance.web.public_ip
}
