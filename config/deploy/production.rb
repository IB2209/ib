
  # サーバの設定
server "ibwww.com", user: "deploy", roles: %w{web db app}

# ssh接続設定
set :ssh_options, {
  user: fetch(:user),
  port: ww,
  keys: %w(~/.ssh/ib.pem),
  forward_agent: true,
  auth_methods: %w[publickey]
}
