data "terraform_remote_state" "aws_state" {
  backend = "s3"
  config {
    bucket     = ""
    key        = ""
    access_key = ""
    secret_key = ""
    region     = ""
  }
}