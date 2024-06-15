resource "aws_security_group" "beanstalk-elb-sg" {
  name = "beanstalk-elb-sg"  
  description = "SG for bean-elb"
  vpc_id = module.vpc.vpc_id
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "bastion-sg" {
    name = "bastion-sg"
    description = "SG for bastion host"
    vpc_id = module.vpc.vpc_id
    egress  {
      from_port = 0
      protocol = "-1"
      to_port = 0
      cidr_blocks = ["0.0.0.0/0"]
    }
    ingress  {
      from_port = 22
      protocol = "tcp"
      to_port = 22
      cidr_blocks = [var.MYIP]         
    }
}

resource "aws_security_group" "ec2-prod-sg" {
    name = "ec2-prod-sg"
    description = "SG for beanstalk instances"
    vpc_id = module.vpc.vpc_id
    egress  {
      from_port = 0
      protocol = "-1"
      to_port = 0
      cidr_blocks = ["0.0.0.0/0"]
    }
    ingress  {
      from_port = 22
      protocol = "tcp"
      to_port = 22
      cidr_blocks = [aws_security_group.bastion-sg.id]         
    }
}    

resource "aws_security_group" "backend-sg" {
    name = "backend-sg"
    description = "SG for backend instances'active mq, RDS, elastic cashe'"
    vpc_id = module.vpc.vpc_id
    egress  {
      from_port = 0
      protocol = "-1"
      to_port = 0
      cidr_blocks = ["0.0.0.0/0"]
    }
    ingress  {
      from_port = 0
      protocol = "-1"
      to_port = 0
      cidr_blocks = [aws_security_group.ec2-prod-sg.id]         
    }
    ingress  {
      from_port = 3306
      protocol = "tcp"
      to_port = 3306
      cidr_blocks = [aws_security_group.bastion-sg.id]         
    }
}  

resource "aws_security_group_rule" "sec_group_itself" {
  type = "ingress"
  from_port = 0
  to_port = 65535
  protocol = "tcp"
  security_group_id = aws_security_group.backend-sg.id
  source_security_group_id = aws_security_group.backend-sg.id
}