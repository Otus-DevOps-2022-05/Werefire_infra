# Werefire_infra
Werefire Infra repository

---

## HW №4

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
