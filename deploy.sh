#!/bin/bash

# デプロイ前に必要な準備作業を実行する
echo "Preparing for deployment..."
# 例: ローカルでのテストを実行する
bundle exec rspec

# デプロイする
echo "Deploying..."
# 例: サーバーにコードを転送する
scp -r /Users/ib./ema/ib root@x162-43-22-125.static.xvps.ne.jp:/var/www/ib.

# デプロイ後の後処理を実行する
echo "Post-deployment tasks..."
# 例: サーバー上で必要なコマンドを実行する
ssh root@x162-43-22-125.static.xvps.ne.jp 'cd /var/www/ib. && bundle install && rake db:migrate && systemctl restart ib.'

echo "Deployment completed successfully."
