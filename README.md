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

### 今回やること
- 自身でドメインを取得しRoute53に登録します
  - Route53でドメイン購入([公式を参考](https://docs.aws.amazon.com/ja_jp/Route53/latest/DeveloperGuide/domain-register.html#domain-register-procedure))、または、他のドメインサービスで購入します
  - 他サービスで購入した場合は、購入したドメインをRoute53に紐づける必要があります(`「ドメインを購入したサービス名 Route53」`などで検索してみるとやり方が見つかると思います)
- `modules/blog/route53/main.tf`
  - `blog`サービスの`Route53`にドメイン定義を記載します
  - `variable.tf`,`output.tf`も記載します
- `modules/blog/main.tf`
  - `blog`サービスに`Route53`を構築する定義を記載します
  - `variable.tf`,`output.tf`も記載します
- `environments/dev/main.tf`
  - `blog`サービスの[ドメインを定義](https://github.com/yzak/learning-tf/blob/e3cb982e0efffec1dc631b1fd6e9d5f03fbfff88/environments/dev/main.tf#L29)します
  - `blog`サービスに設定するドメイン情報を定義します

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
- [前回同様](https://github.com/yzak/learning-tf/tree/10-elb#3-terraform%E3%82%92%E5%AE%9F%E8%A1%8C%E3%81%99%E3%82%8B)に、EC2にSSH接続し、WordPressをインストールします
- ターゲットグループを確認し、EC2インスタンスが`healthy`になっていることを確認
- ブラウザで、`fqdn`で出力されたURLへアクセス
- [前回同様](https://github.com/yzak/learning-tf/tree/10-elb#3-terraform%E3%82%92%E5%AE%9F%E8%A1%8C%E3%81%99%E3%82%8B)に、WordPressの初期設定を行います
- サンプルページが表示されること
- Cloud9のターミナルに戻り
- `terraform destroy`
  - `yes`を入力する
- AWSマネジメントコンソールで、AWSリソースが消えたことを確認する

