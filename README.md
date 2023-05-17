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

## 作るもの
![image](/img/learning-tf.png)

### トライ1
- 上記の`作るもの`の構成を`environments/dev/main.tf`の1ファイルに書いて作ってみよう
- 各リソースの属性はお任せします

## 1. Cloud9を起動する
- AWSマネジメントコンソールで、cloud9と入力し、cloud9を開く
- 前回作成したCloud9を、`Open`する

## 2. 今回の実施内容を行う
- 今回やることを反映する

## 3. Terraformを実行する
- 画面下部のターミナルで、コマンドを実行する
- `cd environments/dev`
- EC2に登録するキーペアを事前に作成する
  - `ssh-keygen -t rsa -b 4096 -f myproject-dev-ec2.pem`
    - パスフレーズは、未入力でENTERキーを押す
- `terraform plan`
- `terraform apply`
  - `yes`を入力する
- AWSマネジメントコンソールで、AWSリソースが作成されていることを確認する
- EC2にSSH接続できることを確認する
  - `ssh -i myproject-dev-ec2.pem ec2-user@xxx.xxx(EC2のパブリックIP)`
  - `exit`
- 確認後、作成したリソースを削除するコマンドを実行する
- `terraform destroy`
  - `yes`を入力する
- AWSマネジメントコンソールで、AWSリソースが消えたことを確認する

## トライ2
- `environments/dev/main.tf`に、以下を実装してみよう（各リソースの属性はお任せします）
- S3バケットを追加してみよう
- EC2からS3バケットにAWS CLIを使ってアクセスできるように、EC2にIAMロールを付与してみよう

