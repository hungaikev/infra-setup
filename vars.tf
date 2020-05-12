variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  default = "eu-central-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}