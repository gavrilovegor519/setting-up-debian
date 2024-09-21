# Гайд по настройке Debian

## Самое необходимое

### Лимитирование объёма журнала systemd-journald

Используйте скрипт `journald-limit.sh` в папке `scripts`.

Разрешить юзеру доступ к journald:

```shell
sudo usermod -aG systemd-journal $USER
```

### Нужные пакеты

Используйте скрипт `base-setup.sh` в папке `scripts`.

Также можно установить расширения для GNOME: `Blur my Shell`, `Appindicator` (<https://extensions.gnome.org/>).

### Сброс MOK в UEFI

```shell
sudo mokutil --reset
```

## Менее необходимые программы

### KeepassXC

```shell
flatpak install flathub org.keepassxc.KeePassXC
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

### VLC

```shell
sudo snap install vlc
fc-cache -r -v
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

```shell
flatpak install flathub org.kde.kdenlive
```

#### Audacity

```shell
flatpak install flathub org.audacityteam.Audacity
```

### Мессенджеры

#### Telegram

```shell
flatpak install flathub org.telegram.desktop
```

#### Discord

```shell
flatpak install flathub com.discordapp.Discord
```

### Виртуализация

#### Docker

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

Сначала ставим DKMS:

```shell
sudo apt install dkms
```

Потом (если включён Secure Boot):

```shell
sudo mkdir -p /var/lib/shim-signed/mok
sudo openssl req -nodes -new -x509 -newkey rsa:2048 -outform DER -addext "extendedKeyUsage=codeSigning" -keyout /var/lib/shim-signed/mok/MOK.priv -out /var/lib/shim-signed/mok/MOK.der
sudo mokutil --import /var/lib/shim-signed/mok/MOK.der
sudo usermod -aG vboxusers $USER
```

И ребутимся.

Потом ставим VBox по данному гайду: <https://www.virtualbox.org/wiki/Linux_Downloads>

### Разработка

#### Настройка Git

```shell
sudo apt install git
# здесь вписать ваше имя и фамилию
git config --global user.name "Egor Gavrilov"
# здесь вписать ваш E-Mail
git config --global user.email gavrilovegor519@gmail.com
```

#### Postman

```shell
sudo snap install postman
```

#### DBeaver

```shell
flatpak install flathub io.dbeaver.DBeaverCommunity
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
flatpak install flathub com.ugetdm.uGet
```

#### Transmission

```shell
flatpak install flathub com.transmissionbt.Transmission
```

### Flatseal

```shell
flatpak install flathub com.github.tchx84.Flatseal
```
