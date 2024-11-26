locals{
  sgName=0
}

resource "aws_security_group" "sg8080$${locals.sgName+1}"
  name = "terraform-learn-state-sg-8080$${locals.sgName+1}"
  ingress {
    from_port   = "8080"
    to_port     = "8080"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "all"
    cidr_blocks = ["0.0.0.0/0"]
  }
}