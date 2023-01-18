# learning-tf

## Terraform
[What is Terraform?](https://developer.hashicorp.com/terraform/intro)

[GetStarted - AWS](https://developer.hashicorp.com/terraform/tutorials/aws-get-started)

[AWS Provider Document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

[The for_each Meta-Argument](https://developer.hashicorp.com/terraform/language/meta-arguments/for_each)

## 作るもの
![image](/img/learning-tf.png)

### 今回やること
- `main.tf`
  - PublicSubnetを作っている箇所を[foreach](https://developer.hashicorp.com/terraform/language/meta-arguments/for_each)を用いて管理しやすくする
  - CIDRブロックをlocalsに定義したので、VPCのCIDRブロックも同じく定義する

## 1. Cloud9を起動する
- AWSマネジメントコンソールで、cloud9と入力し、cloud9を開く
- 前回作成したCloud9を、`Open`する

## 2. 今回の実施内容を行う
- 今回やることを反映する

## 3. Terraformを実行する
- 画面下部のターミナルで、コマンドを実行する
- `terraform plan`
- `terraform apply`
  - `yes`を入力する
- AWSマネジメントコンソールで、AWSリソースが作成されていることを確認する
- `terraform destroy`
  - `yes`を入力する
- AWSマネジメントコンソールで、AWSリソースが消えたことを確認する
