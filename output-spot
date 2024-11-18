# Data source to fetch instance details
data "aws_instance" "jenkins_instance" {
  instance_id = aws_spot_instance_request.jenkins-instance.spot_instance_id
}

# Output the public IP address of the Jenkins instance
output "jenkins_ip_address" {
  value = data.aws_instance.jenkins_instance.public_ip
}

