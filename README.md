# learning-tf

## Terraform
[What is Terraform?](https://developer.hashicorp.com/terraform/intro)

[GetStarted - AWS](https://developer.hashicorp.com/terraform/tutorials/aws-get-started)

[AWS Provider Document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

[The for_each Meta-Argument](https://developer.hashicorp.com/terraform/language/meta-arguments/for_each)

[Google Cloud 環境ディレクトリを使用する](https://cloud.google.com/docs/terraform/best-practices-for-terraform#environment-directories)

## 作るもの
![image](/img/learning-tf.png)

### 今回やること
- `main.tf`
  - 開発用と本番用では、設定内容やリソースの数が異なることがあります
  - 開発用は、サブネット２つ。本番用は、３つといったように各環境の定義を分けます
  - `environments/dev/main.tf`にファイルを移動
  - `environments/prd/main.tf`にファイルを移動し、サブネットを3つにする
- `provider.tf`
  - `environments/dev/provider.tf`にファイルを移動
  - `environments/prd/provider.tf`にファイルを移動
- `versions.tf`
  - `environments/dev/versions.tf`にファイルを移動
  - `environments/prd/versions.tf`にファイルを移動

## 1. Cloud9を起動する
- AWSマネジメントコンソールで、cloud9と入力し、cloud9を開く
- 前回作成したCloud9を、`Open`する

## 2. 今回の実施内容を行う
- 今回やることを反映する

## 3. Terraformを実行する
- 画面下部のターミナルで、コマンドを実行する
- `cd environments/dev`
- `terraform init`
- `terraform plan`
- `terraform apply`
  - `yes`を入力する
- AWSマネジメントコンソールで、AWSリソースが作成されていることを確認する
- `terraform destroy`
  - `yes`を入力する
- AWSマネジメントコンソールで、AWSリソースが消えたことを確認する
- `cd ../../`して、ディレクトリを戻り
- `cd environments/prd`して、同じコマンドを実行
