resource "aws_ebs_volume" "jenkins-instance" {
     availability_zone = "${var.region}a"
     size             = 100
}

resource "aws_volume_attachment" "ebs_att" {
     device_name = "/dev/sdh"
     volume_id   = aws_ebs_volume.jenkins-instance.id
     instance_id = aws_instance.jenkins-instance.id
}
