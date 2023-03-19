# learning-tf

## Terraform
[What is Terraform?](https://developer.hashicorp.com/terraform/intro)

[GetStarted - AWS](https://developer.hashicorp.com/terraform/tutorials/aws-get-started)

[AWS Provider Document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

[The for_each Meta-Argument](https://developer.hashicorp.com/terraform/language/meta-arguments/for_each)

[Google Cloud 環境ディレクトリを使用する](https://cloud.google.com/docs/terraform/best-practices-for-terraform#environment-directories)

[Configure Default Tags for AWS Resources](https://developer.hashicorp.com/terraform/tutorials/aws/aws-default-tags)

## 作るもの
![image](/img/learning-tf.png)

### 今回やること
- `environments/dev/provider.tf`
  - Terraformで作成するリソース全てに共通のタグ(default_tags)を設定
- `environments/prd/provider.tf`
  - Terraformで作成するリソース全てに共通のタグ(default_tags)を設定
- `environments/dev/main.tf`
  - タグの`Name`を`プロジェクト名`-`環境名`-`サービス名`に設定
  - localに、タグの先頭文字列（プレフィックス）をを定義([参考](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/default_tags))
- `environments/prd/main.tf`
  - タグの`Name`を`プロジェクト名`-`環境名`-`サービス名`に設定
  - localに、タグの先頭文字列（プレフィックス）をを定義([参考](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/default_tags))

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
- AWSマネジメントコンソールで、AWSリソースが作成されていることを確認する
- `terraform destroy`
  - `yes`を入力する
- AWSマネジメントコンソールで、AWSリソースが消えたことを確認する
- `cd ../../`して、ディレクトリを戻り
- `cd environments/prd`して、同じコマンドを実行
