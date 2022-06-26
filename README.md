# Scan-87_infra
Scan-87 Infra repository
## Bastion_homework

### SSH with single line
Что бы подключиться к внутреннему серверу через бастион в одну команду можно использовать аргумент **-J** (Jump хост - точка входа)
```
$ ssh -i ssh/appuser -A -J appuser@51.250.70.112  appuser@10.128.0.27
```
### SSH jump via alias
Добавим **alias** для автоматического подключения к внутреннему серверу
```
$ echo "
Host someinternalhost
User appuser
HostName 10.128.0.27
ProxyJump appuser@51.250.70.112
ForwardAgent yes" >> ~/.ssh/config
```

### Network
```
bastion_IP = 51.250.70.112
someinternalhost_IP = 10.128.0.27
```

### SSL
Перейти к панели усправления pritunl с использованием доверенного сертификата можно по адресу
https://51-250-70-112.sslip.io
