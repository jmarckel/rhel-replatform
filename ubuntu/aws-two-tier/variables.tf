#User Vars
variable "aws_region" {
  type = string
  default = "us-west-1"
}

variable "env" {
  type = string 
  default = "Analysts"
}

variable "size" {
  type = string
  default = "small"
}

#Module Vars
variable "aws_instance_sizes" {
  default = {
    small = "t2.small"
    medium = "t2.medium"
    large = "t2.large"
  }
}
