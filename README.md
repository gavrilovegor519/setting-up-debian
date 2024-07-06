# Гайд по настройке Debian

## Самое необходимое

### Лимитирование объёма журнала systemd-journald

```shell
sudo nano /etc/systemd/journald.conf
```

В файле `journald.conf` прописываем:

```text
[Journal]
SystemMaxUse=50M
```

А дальше перезагружаем systemd-journald:

```shell
sudo systemctl restart systemd-journald.service
```

### Нужные пакеты

```shell
# Удаляем ненужное ПО
sudo apt purge gnome-games gnome-remote-desktop transmission-gtk zutty
sudo apt autoremove --purge

# Настроить zram
sudo apt install systemd-zram-generator
sudo systemctl daemon-reload

# Настраиваем systemd-oomd
sudo apt install systemd-oomd

# Дать пользователю права на просмотр логов
sudo usermod -a -G systemd-journal $USER

# Установить шрифты
sudo apt install ttf-mscorefonts-installer
```

Также можно установить расширения для GNOME: `Blur my Shell`, `Appindicator` (<https://extensions.gnome.org/>).

### Сброс MOK в UEFI

```shell
sudo mokutil --reset
```

## Менее необходимые программы

### neofetch

```shell
sudo apt install neofetch
```

### WireGuard

```shell
sudo -i
apt install wireguard
cd /etc/wireguard/
umask 077; wg genkey | tee privatekey | wg pubkey > publickey
nano wg0.conf
systemctl start wg-quick@wg0
systemctl enable wg-quick@wg0
ip a show wg0
```

### Snap

```shell
sudo apt install snapd
sudo snap install core

# 2 раза вводим команду
sudo snap install hello-world

# Проверяем
hello-world
```

### Google Chrome

<https://www.google.com/intl/ru_ru/chrome/>

### VLC

```shell
sudo snap install vlc
fc-cache -r -v
```

### RAR

```shell
sudo apt install unrar
```

### plocate

```shell
sudo apt install plocate
```

### Создание видео

#### OBS Studio

```shell
flatpak install flathub com.obsproject.Studio
```

#### Kdenlive

<https://kdenlive.org/en/download/>

#### Audacity

<https://www.audacityteam.org/download/>

### Мессенджеры

#### Telegram

<https://desktop.telegram.org/>

#### Discord

<https://discord.com/download>

### Виртуализация

#### Docker

**Docker Hub разблокирован в России 3 июня 2024**

```shell
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker $USER
```

#### VirtualBox

Сначала ставим VBox по данному гайду: <https://www.virtualbox.org/wiki/Linux_Downloads>

Потом (если включён Secure Boot):

```shell
sudo mkdir -p /var/lib/shim-signed/mok
sudo openssl req -nodes -new -x509 -newkey rsa:2048 -outform DER -addext "extendedKeyUsage=codeSigning" -keyout /var/lib/shim-signed/mok/MOK.priv -out /var/lib/shim-signed/mok/MOK.der
sudo mokutil --import /var/lib/shim-signed/mok/MOK.der
```

Дальше ребутимся, потом:

```shell
sudo rcvboxdrv setup
sudo usermod -aG vboxusers $USER
```

И опять ребут.

### Разработка

#### Настройка Git

```shell
# здесь вписать ваше имя и фамилию
git config --global user.name "Egor Gavrilov"
# здесь вписать ваш E-Mail
git config --global user.email gavrilovegor519@gmail.com
```

#### Postman

```shell
sudo snap install postman
```

#### Intellij IDEA

<https://www.jetbrains.com/help/idea/installation-guide.html>

#### Java (разработка)

Сначала ставим через APT:

```shell
sudo apt install openjdk-17-jdk
```

Если нужен Java 11:

```shell
sudo apt install openjdk-11-jdk
```

Если нужен Java 8:

```shell
sudo apt install openjdk-8-jdk
```

Eclipse/Intellij IDEA/VS Code/NetBeans - официальный сайт разработчика.

#### VS Code

<https://code.visualstudio.com/docs/setup/linux>

Лучше всего его ставить в формате DEB, а не в Snap.

##### XAMPP (если вам не хочется Docker'а)

Качаем XAMPP с официального сайта (<https://www.apachefriends.org/ru/index.html>),
и устанавливаем его:

```shell
chmod 755 xampp-linux-*-installer.run
sudo ./xampp-linux-*-installer.run
```

И запускаем:

```shell
sudo /opt/lampp/lampp start
```

Остановка:

```shell
sudo /opt/lampp/lampp stop
```

Для удобной работы с ним, делаем следующие команды:

```shell
cd /opt/lampp
sudo chown $USER:$USER htdocs
chmod 775 htdocs
cd
ln -s /opt/lampp/htdocs/ ~/htdocs
```

#### Node.js

<https://nodejs.org/en/download/package-manager>

#### MongoDB Compass

<https://www.mongodb.com/try/download/compass>

### Загрузка файлов

#### Uget

```shell
sudo apt install uget
```

#### Transmission

<https://transmissionbt.com/download>

### Flatseal

```shell
flatpak install flathub com.github.tchx84.Flatseal
```
