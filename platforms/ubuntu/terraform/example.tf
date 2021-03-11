provider "aws" {
  region     = "us-east-2"
}

resource "aws_instance" "terra-example" {
  	ami 		= "ami-0663c8300ef945e88"
  	key_name	= "terra-example-key"
  	instance_type	= "t2.nano"
	security_groups = ["allow_ssh"]
	tags = {
		Name = "terra-example-host"
	}
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    description = "SSH"
    from_port   = 0
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
    Name = "allow_ssh"
  }
}

