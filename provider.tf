terraform {
  backend "s3" {
    bucket = "terraform-state-devops-ahmed"
    key    = "env/dev/statefile.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}
