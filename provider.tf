provider "aws" {
  region = var.region

  assume_role {
    role_arn     = "arn: aws:iam::448214416067:role/terraform-execution-role"
    session_name = "terraform"
  }
}
