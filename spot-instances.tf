# Ubuntu Server AMI
data "aws_ami" "ubuntu_server" {
  most_recent = true

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# Spot Instance Requests

resource "aws_spot_instance_request" "ansible_instance" {
  ami             = data.aws_ami.ubuntu_server.id
  instance_type   = "t2.small"
  key_name        = var.keyname
  spot_price      = "0.020" # Adjust to a reasonable spot price
  subnet_id       = aws_subnet.public_subnet_1.id
  user_data       = file("Software-Applications-CI-CD.sh")

  associate_public_ip_address = true

  tags = {
    Name = "ansible-instance"
  }
}

resource "aws_spot_instance_request" "jenkins_instance" {
  ami             = data.aws_ami.ubuntu_server.id
  instance_type   = "t2.medium"
  key_name        = var.keyname
  spot_price      = "0.0325" # 70% of the on-demand price
  subnet_id       = aws_subnet.public_subnet_1.id

  associate_public_ip_address = true

  tags = {
    Name = "jenkins-instance"
  }
}

resource "aws_spot_instance_request" "sonarqube_instance" {
  ami             = data.aws_ami.ubuntu_server.id
  instance_type   = "t2.medium"
  key_name        = var.keyname
  spot_price      = "0.0325" # 70% of the on-demand price
  subnet_id       = aws_subnet.public_subnet_1.id

  associate_public_ip_address = true

  tags = {
    Name = "sonarqube-instance"
  }
}

resource "aws_spot_instance_request" "prometheus_instance" {
  ami             = data.aws_ami.ubuntu_server.id
  instance_type   = "t2.medium"
  key_name        = var.keyname
  spot_price      = "0.0325" # 70% of the on-demand price
  subnet_id       = aws_subnet.public_subnet_1.id

  associate_public_ip_address = true

  tags = {
    Name = "prometheus-instance"
  }
}

resource "aws_spot_instance_request" "grafana_instance" {
  ami             = data.aws_ami.ubuntu_server.id
  instance_type   = "t2.medium"
  key_name        = var.keyname
  spot_price      = "0.0325" # 70% of the on-demand price
  subnet_id       = aws_subnet.public_subnet_1.id

  associate_public_ip_address = true

  tags = {
    Name = "grafana-instance"
  }
}

resource "aws_spot_instance_request" "jenkins_agent_1" {
  ami             = data.aws_ami.ubuntu_server.id
  instance_type   = "t2.medium"
  key_name        = var.keyname
  spot_price      = "0.0325" # 70% of the on-demand price
  subnet_id       = aws_subnet.public_subnet_1.id

  associate_public_ip_address = true

  tags = {
    Name = "jenkins-agent-1"
  }
}

# Security Group for SSH, Jenkins, SonarQube, Prometheus, and Grafana

resource "aws_security_group" "sg_allow_ssh_jenkins" {
  name        = "allow_ssh_jenkins"
  description = "Allow SSH, Jenkins, SonarQube, Prometheus, and Grafana inbound traffic"
  vpc_id      = aws_vpc.development_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9092
    to_port     = 9092
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
