# Creating External LoadBalancer in AWS
resource "aws_lb" "external-alb" {
  name               = "external-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg_allow_ssh_jenkins.id]
   
  subnet_mapping {
    subnet_id     = aws_subnet.public-subnet-1.id
  }

  subnet_mapping {
    subnet_id     = aws_subnet.public-subnet-2.id
  }
}

resource "aws_lb_target_group" "target-elb" {
  name     = "target-elb"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.development-vpc.id          
}

resource "aws_lb_target_group_attachment" "attachment" {
  target_group_arn = aws_lb_target_group.target-elb.arn
  target_id        = aws_spot_instance_request.jenkins-instance.id
  port             = 80

  depends_on = [
    aws_spot_instance_request.jenkins-instance,
  ]
}

resource "aws_lb_target_group_attachment" "attachment1" {
  target_group_arn = aws_lb_target_group.target-elb.arn
  target_id        = aws_spot_instance_request.jenkins-instance.id
  port             = 80

  depends_on = [
    aws_spot_instance_request.jenkins-instance,
  ]
}

resource "aws_lb_listener" "external-elb" {
  load_balancer_arn = aws_lb.external-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-elb.arn
  }
}
