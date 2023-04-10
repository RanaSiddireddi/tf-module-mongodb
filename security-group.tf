resource "aws_security_group" "allow_mongodb" {
  name        = "roboshop-${var.ENV}-mongodb-sg"
  description = "Allow 2717 inbound from intranet"
  vpc_id      = data.terraform_remote_state.vpc.outputs.VPC_ID

  ingress {
    description = "allow docdb from intranet"
    from_port   = 2717
    to_port     = 2717
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.vpc.outputs.VPC_CIDR]
  }
 
 ingress {
    description = "allow docdb from VPC network"
    from_port   = 2717
    to_port     = 2717
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.vpc.outputs.DEFAULT_VPC_CIDR]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "roboshop-${var.ENV}-mongodb-sg"
  }
}

