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
- EC2はオートスケーリングに対応します
- WordPressを冗長構成で動作できるようにインストール先をEFSにします

### 今回やること
- `environments/dev/main.tf`
  - オートスケーリングでEC2を作成するようになるため、`output`からec2のipを削除します
- `modules/blog/output.tf`
  - 上記同様に、outputからpublic_ipを削除します
- `modules/blog/ec2/main.tf`
  - オートスケーリングにするため`aws_instance`を削除し、起動テンプレート`aws_launch_template`に変更します
  - `aws_launch_template`では、ユーザーデータを用いてEC2の初期化を行うため、`modules/blog/ec2/tpl/user_data.sh`を実行するようにしている
- `modules/blog/ec2/variables.tf`
  - `aws_launch_template`のユーザーデータを用いて、`efs`をマウントするため、efsのidを追加します
  - 同様にユーザーデータで、WordPressのDB接続情報を設定するため、rdsの接続先を追加します
- `modules/blog/ec2/output.tf`
  - outputからpublic_ipを削除します
  - EC2のinstance_idではなく、起動テンプレートIDを返し、これをオートスケーリングで利用するようにします
- `modules/blog/ec2/tpl/user_data.sh`
  - オートスケーリング時のユーザーデータで実行する内容を記載します
- `modules/blog/efs/main.tf`
  - `blog`サービス(WordPress)をefs上に配置するために作成します
  - `variable.tf`,`output.tf`も記載します
- `modules/blog/elb/main.tf`
  - `blog`サービスの`TargetGroup`からEC2インスタンスの定義を削除し、代わりにオートスケーリングの設定を追加します
  - `TargetGroup`のヘルスチェック先を、`/healthcheck.html`から、`/wp-includes/images/blank.gif`に変更します
  - `variable.tf`からEC2のインスタンスIDを削除し、代わりに`aws_launch_template`のidに変更します

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
- ターゲットグループを確認し、EC2インスタンスがオートスケーリングで2台存在することを確認
-  5分ほど経過後に、`healthy`になっていることを確認(初回はWordPress本体をefsにコピーするなど時間を要します)
- ブラウザで、https://`fqdn`で出力されたURLへアクセス
- ブラウザの指示に沿って、WordPressの初期設定を行います
- サンプルページが表示されること
- Cloud9のターミナルに戻り
- `terraform destroy`
  - `yes`を入力する
- AWSマネジメントコンソールで、AWSリソースが消えたことを確認する

