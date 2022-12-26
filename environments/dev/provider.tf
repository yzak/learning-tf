#----------------------------------------
# AWSのリージョン指定
#----------------------------------------
provider "aws" {
  region = "ap-northeast-1"
  default_tags {
    tags = {
      Env       = "dev"
      Project   = "myproject"
      ManagedBy = "Terraform"
    }
  }
}

