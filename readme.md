### Деплой приложения

#### Это первое приложение, которое использует [recap](https://github.com/tomafro/recap) для деплоймента

1. Как обычно нужно сделать симлинк файла deploy.yml в config/deploy.yml
2. Настроить ssh (подробнее в [issue](https://github.com/tomafro/recap/issues/105))

vi ~/.ssh/config

```bash
Host push
    User SECRET_USER
    ForwardAgent yes
    ProxyCommand ssh SECRET_USER_NAME@SECRET_GATEWAY_HOST -W %h:%p
```

3. В /etc/hosts добавить ip-адрес сервера на котором запущено приложение push

sudo vi /etc/hosts

```bash
SECRET_IP  push
```
