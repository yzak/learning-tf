#----------------------------------------
# Terraformバージョンの指定
# AWSプロバイダバージョンの指定
#----------------------------------------
terraform {
  required_version = "1.3.6"

  required_providers {
    aws = "4.45.0"
  }
}
