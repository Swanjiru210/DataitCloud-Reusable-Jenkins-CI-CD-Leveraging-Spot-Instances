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

# Ansible Instance

resource "aws_instance" "ansible-instance" {
  ami             = "${data.aws_ami.ubuntu_server.id}"
  instance_type   = "t2.micro"
  key_name        = "${var.keyname}"
  vpc_security_group_ids = ["${aws_security_group.sg_allow_ssh_jenkins.id}"]
  subnet_id          = "${aws_subnet.public-subnet-1.id}"
  user_data = "${file("Software-Applications-CI-CD.sh")}"

  associate_public_ip_address = true
  tags = {
    Name = "ansible-instance"
  }
}

# Jenkins Instance

resource "aws_instance" "jenkins-instance" {
  ami             = "${data.aws_ami.ubuntu_server.id}"
  instance_type   = "t2.micro"
  key_name        = "${var.keyname}"
  vpc_security_group_ids = ["${aws_security_group.sg_allow_ssh_jenkins.id}"]
  subnet_id          = "${aws_subnet.public-subnet-1.id}"
  associate_public_ip_address = true
  tags = {
    Name = "jenkins-instance"
  }
}

# SonarQube Instance

resource "aws_instance" "sonarqube-instance" {
  ami             = "${data.aws_ami.ubuntu_server.id}"
  instance_type   = "t2.micro"
  key_name        = "${var.keyname}"
  vpc_security_group_ids = ["${aws_security_group.sg_allow_ssh_jenkins.id}"]
  subnet_id          = "${aws_subnet.public-subnet-1.id}"
  associate_public_ip_address = true
  tags = {
    Name = "sonarqube-instance"
  }
}

# Prometheus Instance

resource "aws_instance" "prometheus-instance" {
  ami             = "${data.aws_ami.ubuntu_server.id}"
  instance_type   = "t2.micro"
  key_name        = "${var.keyname}"
  vpc_security_group_ids = ["${aws_security_group.sg_allow_ssh_jenkins.id}"]
  subnet_id          = "${aws_subnet.public-subnet-1.id}"
  associate_public_ip_address = true
  tags = {
    Name = "prometheus-instance"
  }
}

# Grafana Instance

resource "aws_instance" "grafana-instance" {
  ami             = "${data.aws_ami.ubuntu_server.id}"
  instance_type   = "t2.micro"
  key_name        = "${var.keyname}"
  vpc_security_group_ids = ["${aws_security_group.sg_allow_ssh_jenkins.id}"]
  subnet_id          = "${aws_subnet.public-subnet-1.id}"
  associate_public_ip_address = true
  tags = {
    Name = "grafana-instance"
  }
}

# Jenkins-Agent-1

resource "aws_instance" "jenkins-agent-1" {
  ami             = "${data.aws_ami.ubuntu_server.id}"
  instance_type   = "t2.micro"
  key_name        = "${var.keyname}"
  vpc_security_group_ids = ["${aws_security_group.sg_allow_ssh_jenkins.id}"]
  subnet_id          = "${aws_subnet.public-subnet-1.id}"
  associate_public_ip_address = true
  tags = {
    Name = "jenkins-agent-1"
  }
}

# Security Group for SSH, Jenkins, SonarQube, Prometheus, and Grafana

resource "aws_security_group" "sg_allow_ssh_jenkins" {
  name        = "allow_ssh_jenkins"
  description = "Allow SSH, Jenkins, SonarQube, Prometheus, and Grafana inbound traffic"
  vpc_id      = "${aws_vpc.development-vpc.id}"

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
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

