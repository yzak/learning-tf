# learning-tf

## Terraform
[What is Terraform?](https://developer.hashicorp.com/terraform/intro)

[GetStarted - AWS](https://developer.hashicorp.com/terraform/tutorials/aws-get-started)

[AWS Provider Document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

## 作るもの
![image](/img/learning-tf.png)

## 1. Cloud9を動かすVPCを作成
- AWSマネジメントコンソールで、VPCと入力し、VPCを開く
- `VPCを作成`を実行し、以下の内容でVPCを作成する

項目 | 値
-- | --
作成するリソース | VPCなど
名前タグの自動生成 | learning-tf
IPv4CIDRブロック | 10.0.0.0/16
IPv6 CIDRブロック | なし
テナンシー | デフォルト
AZの数 | 2
パブリックサブネットの数 | 2
プライベートサブネットの数 | 0
NATゲートウェイ | なし
VPCエンドポイント | なし
DNSホスト名を有効化 | チェック
DNS解決を有効化 | チェック

## 2. Cloud9を構築する
- AWSマネジメントコンソールで、cloud9と入力し、cloud9を開く
- `Create envrionment`を実行して、以下の内容で環境作成を行う

大分類 | 項目 | 値
-- | -- | --
Details | Name | learning-tf-c9
|  | Description | learning-tf-c9
|  | Environment type | New EC2 instance
New EC2 instance | Instance type | t2.micro
|  | Platform | Amazon Linux 2
|  | Timeout | 30 minutes
Network settings | Connection | Secure Shell(SSH)
|  | VPC settings(VPC) | 1で作成したVPCを選択
|  | VPC settings(Subnet) | 1で作成したパブリックサブネット1aを選択

## 3. Terraformを実行する
- 作成したCloud9の環境を選択し、`Open`を実行する
- 左側のフォルダツリーのトップ`learning-tf-c9`を右クリックして`New File`
  - `main.tf`と入力
- `main.tf`に、[main.tf](./main.tf)の内容を貼り付けて保存する
- 画面下部のターミナルで、コマンドを実行する
- `terraform init`
- `terraform plan`
- `terraform apply`
  - `yes`を入力する
- AWSマネジメントコンソールで、VPCを確認し、`myproject-vpc`が作成されていることを確認する
- `terraform destroy`
  - `yes`を入力する
- AWSマネジメントコンソールで、VPCを確認し、`myproject-vpc`が消えたことを確認する
