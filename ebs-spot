# Define the EBS volume
resource "aws_ebs_volume" "jenkins_instance" {
  availability_zone = "${var.region}a"
  size              = 100
}

# Attach the EBS volume to the Spot instance
resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.jenkins_instance.id   
  instance_id = aws_spot_instance_request.jenkins-instance.id
}

