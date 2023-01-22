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
※外部からの通信をHTTPS化します

### 今回やること
- `modules/blog/acm/main.tf`
  - `blog`サービスの`ACM`にSSL証明書の定義を記載します
  - `variable.tf`,`output.tf`も記載します
- `modules/blog/elb/main.tf`
  - `blog`サービスの`ELB`にHTTPSのインバウンドを許可し、SSL証明書を定義します
  - `variable.tf`も記載します
- `modules/blog/route53/main.tf`
  - `blog`サービスの`ACM`の検証用DNSレコードを記載します
  - `variable.tf`,`output.tf`も記載します
- `modules/blog/main.tf`
  - `blog`サービスの[ドメインを定義](./environments/dev/main.tf#L29)します
  - `blog`サービスに`ACM`を構築する定義を記載します

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
- ブラウザで、https://`fqdn`で出力されたURLへアクセス
- WordPressはデフォルトではHTTPSに対応していないため、画面が崩れます
  - WordPressのHTTPS化には`WordPress HTTPS化`などでWeb検索し、プラグインなどを導入することでできます（ここでは割愛します）
- [前回同様](https://github.com/yzak/learning-tf/tree/10-elb#3-terraform%E3%82%92%E5%AE%9F%E8%A1%8C%E3%81%99%E3%82%8B)に、WordPressの初期設定を行います
- サンプルページが表示されること
- Cloud9のターミナルに戻り
- `terraform destroy`
  - `yes`を入力する
- AWSマネジメントコンソールで、AWSリソースが消えたことを確認する

