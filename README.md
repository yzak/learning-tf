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
- ※RDS構築時にAZを指定していないため、1a または 1cのどちらかに配置されますが、どちらでも問題ありません

### 今回やること
- `modules/blog/ec2/output.tf`
  - `blog`サービスの`rds`のインバウンド通信をEC2に限定するため、必要な情報を返却します
- `modules/blog/rds/main.tf`
  - `blog`サービスに`rds`に関する各リソースを作成する定義を記載します
  - `variable.tf`,`output.tf`も記載します
- `modules/blog/main.tf`
  - `blog`サービスに`rds`を構築する定義を記載します
  - `variable.tf`,`output.tf`も記載します
- `environments/dev/main.tf`
  - `blog`サービスにプライベートサブネットの情報を追加して呼び出します
  - `blog`サービスで作成したRDSのアドレス情報を出力します

## 1. Cloud9を起動する
- AWSマネジメントコンソールで、cloud9と入力し、cloud9を開く
- 前回作成したCloud9を、`Open`する

## 2. 今回の実施内容を行う
- 今回やることを反映する

## 3. Terraformを実行する
- 画面下部のターミナルで、コマンドを実行する
- `cd environments/dev`
- `terraform plan`
- `terraform apply`
  - `yes`を入力する
  - RDSの構築は5分ほどかかります
- AWSマネジメントコンソールで、AWSリソースが作成されていることを確認する
- EC2にSSH接続できることを確認する(Teratermなど)
  - `ssh -i myproject-dev-ec2.pem ec2-user@xxx.xxx(EC2のパブリックIP)`
  - mysqlをインストールし、RDSへ接続します
  - `sudo su -`
  - `yum install -y mysql`
  - `mysql -u wordpress -pwordpress -h xxx.xxxx(RDSのエンドポイント) `
  - `exit`
  - `exit`
- Cloud9のターミナルに戻り
- `terraform destroy`
  - `yes`を入力する
- AWSマネジメントコンソールで、AWSリソースが消えたことを確認する

