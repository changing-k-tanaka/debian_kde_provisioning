#!/bin/bash

# for Debian 12.8 (Bookwarm) With KDE

#====================================================================
# aptのアップデート
#====================================================================
yes | sudo apt update
yes | sudo apt upgrade

#====================================================================
# 『デスクトップ』『音楽』などの日本語フォルダー名を英語表記にする
#====================================================================
yes | sudo apt install xdg-user-dirs-gtk
LANG=C xdg-user-dirs-gtk-update

#====================================================================
# ソフトウェアインストール
#====================================================================

# IME
sudo apt remove ibus
sudo apt install im-config fcitx5-mozc fcitx5-configtool
im-config -n fcitx5

# 様々なツール ======================================================
yes | sudo apt install yakuake # guake like terminal for kde
#yes | sudo apt install chromium-browser
#yes | sudo apt install chromium-browser-l10n
yes | sudo apt install filezilla
yes | sudo apt install clamtk
yes | sudo apt install plasma-firewall
yes | sudo apt install ntp

# docker ===========================================================
# dockerの公式ページを見て、ちゃんとレポジトリをインストールしようとするディストリビューション・バージョンに合わせること
# https://docs.docker.com/engine/install/debian/
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done

# Add Docker's official GPG key:
sudo apt-get update
yes | sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
yes | sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# # vivaldi ===========================================================
# wget http://repo.vivaldi.com/stable/linux_signing_key.pub
# sudo apt-key add linux_signing_key.pub
# echo deb http://repo.vivaldi.com/stable/deb/ stable main | sudo tee /etc/apt/sources.list.d/vivaldi.list
# yes | sudo apt update
# yes | sudo apt install vivaldi-stable

# caffeine ==========================================================
#yes | sudo add-apt-repository ppa:caffeine-developers/ppa
#yes | sudo apt update
#yes | sudo apt install caffeine


# snapd ===================================================
yes | sudo apt install snapd

# Bitwarden ===============================================
sudo snap install bitwarden

# phpstorm ================================================
# wget https://download-cf.jetbrains.com/webide/PhpStorm-2016.1.2.tar.gz  # confirm ver
# tar xvf PhpStorm-2016.1.2.tar.gz
# sudo mv PhpStorm-145.1616.3/ /opt/phpstorm/
# sudo ln -s /opt/phpstorm/bin/phpstorm.sh /usr/local/bin/phpstorm

snap install phpstorm --classic
sudo ln -s /snap/bin/phpstorm /usr/local/bin/phpstorm

# rubymine ================================================
snap install rubymine --classic
sudo ln -s /snap/bin/rubymine /usr/local/bin/rubymine


# fingerprint =============================================
#yes | sudo apt-add-repository -y ppa:fingerprint/fingerprint-gui
#yes | sudo apt update
#yes | sudo apt install libbsapi policykit-1-fingerprint-gui fingerprint-gui

# but now 2017/08/05, there is not fingerprint device driver for linux

# iphone 有線USBテザリング =================================
yes | sudo apt install ipheth-utils
sudo modprobe ipheth
yes | sudo bash -c 'echo ipheth >> /etc/modules'

# tmux =======================================
yes | sudo apt install tmux
cp ./assets/_.tmux.conf ~/.tmux.conf

# vim 8 ======================================================
sudo add-apt-repository -y ppa:jonathonf/vim
yes | sudo apt update
yes | sudo apt install vim

# dein
mkdir ~/.vim/
sh -c "$(wget -O- https://raw.githubusercontent.com/Shougo/dein-installer.vim/master/installer.sh)"
cp ./assets/_.vimrc ~/.vimrc
cp ./assets/colors ~/.vim/ -r

# vscode ====================================================
echo "code code/add-microsoft-repo boolean true" | sudo debconf-set-selections
yes | sudo apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
yes | sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg
yes | sudo apt install apt-transport-https
sudo apt update
yes | sudo apt install code


# docker user settngs =======================================
# dockerグループがなければ作る
sudo groupadd docker

# 現行ユーザをdockerグループに所属させる
sudo gpasswd -a $USER dockersss

# dockerデーモンを再起動する (CentOS7の場合)
sudo systemctl restart docker

# Windows との時刻のズレを解消 =================================
sudo timedatectl set-local-rtc 1

# powertop and tlp =============================================
yes | sudo apt install powertop
yes | sudo powertop --auto-tune

yes | sudo add-apt-repository ppa:linrunner/tlp
yes | sudo apt update
yes | sudo apt install tlp tlp-rdw


# zsh ==========================================================
yes | sudo apt install zsh
chsh -s /bin/zsh

# end ==========================================================
echo 'need restart for complete install'

# after restart

# 以下は手動

# zsh の設定
# zimのインストール
# KDEの設定
# IMEの設定
