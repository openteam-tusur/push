== Деплой приложения

=== Это первое приложение, которое использует recap для деплоймента

1. Как обычно нужно сделать симлинк файл deploy.yml в config/deploy.yml
2. Настроить ssh

vi ~/.ssh/config

Host push
  User SECRET_USER
  ForwardAgent yes
  ProxyCommand ssh SECRET_USER_NAME@SECRET_GATEWAY_HOST -W %h:%p

