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
- CloudFrontを利用します

### 今回やること
- `environments/dev/main.tf`
  - `cdn_host_name`を追加し、CloudFront(CDN)のドメインを設定します
  - 関連して、ELB,CloudFrontのFQDNを`output`に出力しています
  - CloudFrontはグローバルに設置するため、CloudFrontのSSL証明書(ACM)はバージニア北部で登録する必要があるため、`provider`に追加します
- `modules/blog/main.tf`
  - ユーザーデータで作成する際に、CloudFront経由のHTTPSアクセスで動作させるために、CloudFrontのドメインの設定を追加します
  - CloudFront,CloudFrontのSSL証明書,Route53の登録を追加します
- `modules/blog/cloudfront/main.tf`
  - CloudFront+ELBの構成dえWordpressを提供するための定義を追加します
  - 関連して必要な情報を、`variable.tf`,`output.tf`に記載します
- `modules/blog/ec2/tpl/user_data.sh`
  - WordPressの初期構築時のドメインをCloudFrontに統一させるための設定を追加します
- `modules/blog/elb/main.tf`
  - CloudFront経由のリクエストのみを処理するように、CloudFrontで定めたHTTPヘッダがある場合のみEC2に転送し、それ以外は403を返すように設定します

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
  - CloudFrontも今回作成するため、さらに10分ほど待つ必要があります
  - ターゲットグループでオートスケーリングのEC2がhealthyになるまで待機します
- AWSマネジメントコンソールで、AWSリソースが作成されていることを確認する
- ブラウザで、https://`cdn_fqdn`へアクセスしWordPressのインストールを行います
- ブラウザの指示に沿って、WordPressの初期設定を行います
- サンプルページが表示されること
- Cloud9のターミナルに戻り
- `terraform destroy`
  - `yes`を入力する
- AWSマネジメントコンソールで、AWSリソースが消えたことを確認する

