# Configure the AWS Provider
provider "aws" {
  region = "us-west-1"
}

# Create default VPC if one does not exist
resource "aws_default_vpc" "default_vpc" {
    
}

# Create Security Group for Docker
resource "aws_security_group" "web-sg" {
  name        = "docker-SG"
  description = "Allow SSH, HTTP, and custom inbound traffic"
  vpc_id      = aws_default_vpc.default_vpc.id

  ingress {
    description = "Allow ports 8000-8100"
    from_port   = 8000
    to_port     = 8100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "docker-lab-SG"
  }
}

# Generate SSH Key Pair
resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "ec2_key" {
  key_name   = "docker-keypair-estephe"
  public_key = tls_private_key.ec2_key.public_key_openssh
}

resource "local_file" "ssh_key" {
  filename        = "${aws_key_pair.ec2_key.key_name}.pem"
  content         = tls_private_key.ec2_key.private_key_pem
  file_permission = "400"
}

# Get the latest Ubuntu 22.04 LTS AMI
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = ["099720109477"]
}

# Create an IAM role
resource "aws_iam_role" "ecr_access_role" {
  name = "ecr-access-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

# Attach an ECR policy
resource "aws_iam_policy" "ecr_policy" {
  name        = "ECRAccessPolicy"
  description = "Policy to allow access to ECR"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:*"
        ]
        Resource = "*"
      }
    ]
  })
}

# Attach policy to the role 
resource "aws_iam_role_policy_attachment" "ecr_policy_attachment" {
  policy_arn = aws_iam_policy.ecr_policy.arn
  role       = aws_iam_role.ecr_access_role.name
}

# Attach the Role to an EC2 Instance Profile
resource "aws_iam_instance_profile" "ecr_instance_profile" {
  name = "ecr-instance-profile"
  role = aws_iam_role.ecr_access_role.name
}

# Create EC2 instance with Docker installation
resource "aws_instance" "DockerDebian" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.medium"
  vpc_security_group_ids = [aws_security_group.web-sg.id]
  key_name               = aws_key_pair.ec2_key.key_name 
  iam_instance_profile   = aws_iam_instance_profile.ecr_instance_profile.name
  user_data              = file("install.sh")

  root_block_device {
    volume_size = 30
    volume_type = "gp2"
  }

  tags = {
    Name = "docker-instance-ubuntu"
  }
}

# Outputs
output "ssh-command" {
  value = "ssh -i ${aws_key_pair.ec2_key.key_name}.pem ubuntu@${aws_instance.DockerDebian.public_dns}"
}

output "public-ip" {
  value = aws_instance.DockerDebian.public_ip
}
