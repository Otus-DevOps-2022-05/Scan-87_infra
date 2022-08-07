provider "yandex" {
  token	= "AQAAAAAkLu5JAATuwe4IgMx3P0BgrDMR6SLeLS8"
  cloud_id = "b1gf8rebqqmf1rvc0lpe"
  folder_id = "b1ghir7l32lnuum8gn9m"
  zone = "ru-central1-a"
}

resource "yandex_compute_instance" "app" {
metadata = {
ssh-keys = "ubuntu:${file("~/Nextcloud/OTUS/DevOps/homework/ssh/appuser.pub")}"
	}
name = "reddit-app"

resources {
cores = 2
memory = 2
}

boot_disk {
initialize_params {
# Указать id образа созданного в предыдущем домашнем задании
image_id = "fd8i34tjvlcjl496tra5"
}
}

connection {
type = "ssh"
host = yandex_compute_instance.app.network_interface.0.nat_ip_address
user = "ubuntu"
agent = false
# путь до приватного ключа
private_key = file("~/Nextcloud/OTUS/DevOps/homework/ssh/appuser")
}

provisioner "file" {
source = "files/puma.service"
destination = "/tmp/puma.service"
}
provisioner "remote-exec" {
script = "files/deploy.sh"
}

network_interface {
# Указан id подсети default-ru-central1-a
subnet_id = "e9bd9qeu31grb7k10dpn"
nat = true
}
}
