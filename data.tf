# fetching information of remote state file

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
        bucket = "b52-s3"
        key    = "vpc/${var.ENV}/terraform.tfstate"
        region = "us-east-1"
  }
}