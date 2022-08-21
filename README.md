# Scan-87_infra
Scan-87 Infra repository
## 02 Bastion_homework

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

## 03 Cloud-testapp_homework

### mongodb block bypass
В процессе установки возникли сложности с mongodb - рессурс заблокирован. Для обхода был развернут http прокси на VPS в Нидерландах. В дальнейшем все обращения через apt производились через прокси. Конфигурация осуществляется в первых двух строчках скрипта **deploy_full.sh**.

Примечание: в целях безопасности, учетные данные для личного proxy сервера были отредактированы

### Startup Script
Итоговый скрипт конфигурации был создан с именем **deploy_full.sh**

Создание конфигурации происходит по команде
```
$ yc compute instance create \ 
--name reddit-app \     
--hostname reddit-app \     
--memory=4 \ 
--create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \                                                                        
--network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
--metadata serial-port-enable=1 \
--metadata ssh-keys="user:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC/TArowZH5ef3PAjjJoJPi+OqcY9Pu/dSKppTB8AYmEX/rE/HgtvNrunV3Zj62x68H0gXEkXH+y5ng4WLL8mWHAxIch5dTY1n9GQ6GIaIG1w8gKjoSvX7evdlA9PJVJmMAG7SyU4P62k4Qw/OY4vc/oNwa0GtQU9RAdKRbBgfpm6XSvxi3+mAlr7PBkaRzF2LON5FRXgyqXYFwaq3v2vg/k8fE7NrbqdISdlA4FS8qmx6SVb3GfOl3nSx3IAlePQHDXyTHfUXRL6dlVKVvgWsEoO+kAA6SNdXvk2Vm/0n/mdbUgfTFlqueO6X5DHc64bU87pnfXizz5mQrwR3VHBVgyHN7VVUBNeFZLqC8sGydrUpxtY8cRBoKjtyQUiY1Ri65uTrWp/N44LP2MPGvORhyj3J16TmeZT0hYbzTatWltckvSlkAU5BFpQmoiN4gu5V7MycZFLha9Gl0CCgkQ9WEWuanPj5LnoLTu0RBaTYEr+cN9cYGkTlOI7htBQUvX78= appuser" \
--metadata-from-file user-data=deploy_full.sh
```

### Network
```
testapp_IP = 51.250.87.216
testapp_port = 9292
```

## 05 Terraform-1
Для выполнения задания нужна версия 0.12.8
```
$ wget https://releases.hashicorp.com/terraform/0.12.8/terraform_0.12.8_linux_amd64.zip
```

Создаем директорию **terraform-1**, в ней файл **main.tf**

Описываем провайдер, инициализируем, добавляем созданный рессурс
Проверив информацию можем создать инстанс командой 
```
$ terraform apply

...
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

Узнаем адрес сервера
```
$ ../../../terraform-0-12-8/terraform show | grep ip
ip_address         = "10.128.0.9"
ipv4               = true
ipv6               = false
nat_ip_address     = "51.250.0.130"
nat_ip_version     = "IPV4"
```
Пробуем подключиться по **ssh** - nope!
Почему? Мы не указали ключ!

Добавим его в **main.tf**
```
resource "yandex_compute_instance" "app" {
metadata = {
ssh-keys = "ubuntu:${file("~/Nextcloud/OTUS/DevOps/homework/ssh/appuser.pub")}"
}
...
}
```

Сносим машину и собираем ее заново
```
$ ../../../terraform-0-12-8/terraform destroy
...
$ ../../../terraform-0-12-8/terraform apply
```
### Provisioners
Provisioner в terraform вызываются в момент создания / удаления рессурсов и позволяют выполнять команды на удаленной или локальной машине. Их используют для управления конфигурацией или начлаьной настройки системы. Используем провижинер для деплоя последней версии приложения на ВМ.

Вставим в resource в **main.tf** 
```
provisioner "file" {  
source = "files/puma.service"  
destination = "/tmp/puma.service"  
}
```

Теперь создадим директорию **files**, в которую добавим файл **puma.service**
```
[Unit]
Description=Puma HTTP Server
After=network.target

[Service]
Type=simple
User=ubuntu
WorkingDirectory=/home/ubuntu/reddit
ExecStart=/bin/bash -lc 'puma'
Restart=always

[Install]
WantedBy=multi-user.target
```

Проверяем работу и настраиваем файл с переменными **variables.tf**

Проверяем все на работоспособность и добавляем баллансировщик нагрузки в файле **lb.tf** 
Note: баллансировщик работает так себе, поскольку нет синхронизации базы данных


