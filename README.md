# Werefire_infra
Werefire Infra repository

___

## HW №11

* Локальная разработка при помощи Vagrant, доработка ролей для провижининга в Vagrant
* Тестирование ролей при помощи Molecule и Testinfra
* Переключение сбора образов пакером на использование ролей


* Настройка гибридной среды wsl2+win11pro
  * Настройка окружения
    * wsl2: Vagrant, Molecule, Ansible, Packer
    * win11pro: VirtualBox


_Vagrant должен знать где в win находится VirtualBox_

_Vagrant/Molecule должен разворачивать (.vagrant.d и .vagrant) директории юзера в wsl2 для успешного подключения по SSH (паранойя 0600)_

    export VAGRANT_DOTFILE_PATH="/home/ubuntu/.vagrant"
    export VAGRANT_WSL_WINDOWS_ACCESS_USER_HOME_PATH="/home/ubuntu/"
    export PATH="$PATH:/mnt/c/Program Files/Oracle/VirtualBox:/mnt/c/Windows/System32:/mnt/c/Windows/system32/WindowsPowerShell/v1.0"

_VirtualBox не знает пути для записи логов wsl2 и не может запуститься - поэтому и в Vagrant и в Molecule отключаем COM_

    "modifyvm", :id, "--uartmode1", "disconnected"

---

## HW №10

* Перенесены созданные плейбуки в раздельные роли
* Описано два окружения
* Используется коммьюнити роль nginx
* Используется Ansible Vault для окружений

---

## HW №9

* прогнал сценарии с один плейбуком и одним\несеколькими сценариями
* повторил с несколькими плейбуками
* сгорел от табуляции
* перенесен билд пакера с win11 на wsl2 ввиду отсутствия ансибля здорового человека в win11
* используя Packer&Ansible добавлены новые базовые образы app и db
* проверена раскатка ансибля главным плейбуком на новых хостах

---
## HW №8

* установлен Ansible (wsl2)
* в файл ansible.cfg добавлена информация об подключении к хостам
* добавлена инвенторка inventory и inventory.yml
* проверены команды на хостах
* добавлен прейбук для git

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
