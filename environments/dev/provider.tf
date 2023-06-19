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

provider "aws" {
  region = "us-east-1"
  alias  = "virginia"
  default_tags {
    tags = {
      Env       = "dev"
      Project   = "myproject"
      ManagedBy = "Terraform"
    }
  }
}

#----------------------------------------
# my-ip取得用
#----------------------------------------
provider "http" {
}
