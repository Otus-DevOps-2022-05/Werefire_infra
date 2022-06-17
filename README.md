# Выполнено ДЗ № 3

 - [ ] Основное ДЗ
 - [ ] Дополнительно: подключение ssh someinternalhost из локальной консоли рабочего устройства по алиасу someinternalhost
 - [ ] Дополнительно: использование валидного сертификата для панели управления VPN-сервера

## В процессе сделано:
 - Создание учетной записи в Yandex.Cloud
 - Создание в веб-интерфейсе инстансов ВМ и подключение к ним по SSH
 - Рассмотрел варианты подключения к хостам через бастион-хост и VPN

Взаимодействие с `repo.mongodb.org` отбивает 403 ошибкой при использовании скрипта `setupvpn.sh`. Поэтому из скрипта были исключены шаги для использования этого репозитория. Mongo пулится из доверенного и проверенного репозитория `mirror.yandex.ru`.

### Реквизиты инстансов.
    bastion_IP = 51.250.86.19
    someinternalhost_IP = 10.128.0.15
### Задания
> Исследовать способ подключения к someinternalhost в одну команду из вашего рабочего устройства, проверить работоспособность найденного решения и внести его в README.md в вашем репозитории

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


> С помощью сервисов sslip.io/xip.io и Let’s Encrypt реализуйте спользование валидного сертификата для панели управления VPN-сервера
* url: https://51.250.86.19.sslip.io

## PR checklist
 - [x] Выставил label с номером домашнего задания
 - [x] Выставил label с темой домашнего задания
