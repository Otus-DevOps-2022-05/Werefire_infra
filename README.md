# Werefire_infra
Werefire Infra repository

---
## HW №7

* Созданы базовые образы app.json и db.json в директории /packer
* Подкорректированы скрипты в /packer
* Добавлены модули terraform/modules
* Перенесен Terraform в terraform/stage и terraform/prod

___

## HW №6

* Используя переменные в variables.tf, которые забирают данные из terraform.tfvars - заполнил main.tf
* Запушил пример terraform.tfvars.example

___

## HW №5

Сборка загрузочного диска Packer-ом

Последовательность действий.

1. Изменить имя файла с `packer/variables.json.example` на `packer/variables.json`
2. Актуализировать значения переменных в файле packer/variables.json
3. Убедиться в актульности файла key.json ~~(в репе фейко-ключ Yandex Cloud)~~
4. Выполнить команду в директории packer: `packer build ./ubuntu16.json`

---

## HW №4

    testapp_IP = 51.250.80.244
    testapp_port = 9292

Строчный ~~(ОС Windows)~~ startup script для дополнительного задания. Инвенторка скрипта в файле _auto_startup.yaml_

`yc compute instance create --name reddit-app-auto --hostname reddit-app-auto --memory=4 --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 --metadata serial-port-enable=1 --metadata-from-file user-data=auto_startup.yaml`

Mongo из дефолтного репозитория https://mirror.yandex.ru/ самого инстанса

---

## HW №3

***SSH Agent Forwarding***

готовим агента в Windows

    get-service ssh*
    Set-Service -Name ssh-agent -StartupType Manual
    Start-Service ssh-agent
    ssh-add <path_to_private_key>

подключаемся к хосту

`ssh -i <path_to_public_key> -A <username>@<bastion_IP>`

подключаемся с него к хостам, не имеющим публичные адреса

`ssh someinternalhost_IP`

***ProxyJump ssh - подключение в одну строчку***

`ssh -i ~/.ssh/appuser -J <username>@<bastion_IP> <username>@<someinternalhost_IP>`

***Подключаемся по алиасу***

Создаем\правим в локальном каталоге `~\.ssh` файл `config`
Указываем блок коннекта

    Host someinternalhost
      Hostname <someinternalhost_IP>
      User appuser
      ForwardAgent yes
      ProxyJump appuser@<bastion_IP>

подключаемся `ssh someinternalhost`
