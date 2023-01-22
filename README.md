# learning-tf

## Terraform
[What is Terraform?](https://developer.hashicorp.com/terraform/intro)

[GetStarted - AWS](https://developer.hashicorp.com/terraform/tutorials/aws-get-started)

[AWS Provider Document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

[The for_each Meta-Argument](https://developer.hashicorp.com/terraform/language/meta-arguments/for_each)

[Google Cloud 環境ディレクトリを使用する](https://cloud.google.com/docs/terraform/best-practices-for-terraform#environment-directories)

[Configure Default Tags for AWS Resources](https://developer.hashicorp.com/terraform/tutorials/aws/aws-default-tags)

[Modules Development Overview](https://developer.hashicorp.com/terraform/language/modules/develop)

- [AWS VPC Terraform module](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest)

### やってみよう
- Web検索を駆使して色々とやってみよう
- tfstateをS3に保管してみよう
  - https://developer.hashicorp.com/terraform/language/settings/backends/s3
- 構成図を書いてみよう
  - `draw.io aws 構成図`などで検索してみよう
- コスト見積もりをしてみよう
  - https://calculator.aws/#/
  - 1年運用した場合のコストを見積もってみよう
    - EC2はオンデマンドと前払いした場合で見積もってみよう
- EC2やRDSを冗長化してみよう
