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
- `modules/blog/ec2/output.tf`
  - `blog`サービスの`TargetGroup`にEC2インスタンスを所属させるため、必要な情報を返却します
- `modules/blog/elb/main.tf`
  - `blog`サービスに`elb`に関する各リソースを作成する定義を記載します
  - `variable.tf`,`output.tf`も記載します
- `modules/blog/main.tf`
  - `blog`サービスに`elb`を構築する定義を記載します
  - `output.tf`も記載します
- `modules/blog/ec2/main.tf`
  - `blog`サービスの`ec2`のセキュリティグループに、ELBからのインバウンドを許可する定義を記載します
  - `variable.tf`も記載します
- `environments/dev/main.tf`
  - `blog`サービスで作成したELBのDNS名を出力します

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
  - wordpressをインストールします
    ```
    sudo su - 
    yum -y update

    amazon-linux-extras install php7.2 -y
    yum -y install mysql httpd php-mbstring php-xml gd php-gd

    systemctl enable httpd.service
    systemctl start httpd.service

    wget http://ja.wordpress.org/latest-ja.tar.gz ~/
    tar zxvf ~/latest-ja.tar.gz
    cp -r ~/wordpress/* /var/www/html/
    chown apache:apache -R /var/www/html
    echo "ok" >> /var/www/html/healthcheck.html
    exit
    exit
    ```
- ターゲットグループを確認し、EC2インスタンスが`healthy`になっていることを確認
- ブラウザで、`elb_dns_name`で出力されたURLへアクセス
  - 以下でwordpressを初期設定します
    | 項目名 | 値 |
    | -- | -- |
    | データベース名 | wordpress |
    | ユーザー名 | wordpress |
    | パスワード | wordpress |
    | データベースのホスト名 | `rds_address`の出力値 |
    | テーブル接頭辞	 | wp_ |
  - インストール実行後、以下の必要情報を設定します
    | 項目名 | 値 |
    | -- | -- |
    | サイトのタイトル | myblog |
    | ユーザー名 | 任意の値 |
    | パスワード | 任意の値 |
    | メールアドレス | ご自身のメールアドレス |
    | 検索エンジンでの表示 | チェックON |
  - 登録したユーザー名、パスワードでログインし、画面左上の`myblog`の`サイトを表示`を選択
  - サンプルページが表示されること
- Cloud9のターミナルに戻り
- `terraform destroy`
  - `yes`を入力する
- AWSマネジメントコンソールで、AWSリソースが消えたことを確認する

