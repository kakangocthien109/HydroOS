#!/usr/bin/env bash
#
# SPDX-License-Identifier: GPL-3.0-or-later

set -e -u

# Warning: customize_airootfs.sh is deprecated! Support for it will be removed in a future archiso version.
#Set locale
sed -i 's/#\(vi_VN\.UTF-8\)/\1/' /etc/locale.gen
echo "LANG=vi_VN.UTF-8" > /etc/locale.conf
echo "LANGUAGE=vi_VN.UTF-8" > /etc/locale.conf
echo "LC_COLLATE=C" > /etc/locale.conf
echo "LC_ALL=C" > /etc/locale.conf
locale-gen
#Set Keyboard
echo "KEYMAP=us" > /etc/vconsole.conf

# Time and clock
timedatectl set-timezone Asia/Ho_Chi_Minh
ln -sf /usr/share/zoneinfo/Asia/Ho_Chi_Minh  /etc/localtime
hwclock --systohc --utc

#Add user
usermod -s /usr/bin/zsh root
cp -aT /etc/skel/ /root
chmod 700 /root

useradd -m -p ""  -g users -G "adm,audio,floppy,log,network,rfkill,scanner,storage,optical,power,wheel" -s /bin/zsh liveuser
usermod -a  -G "adm,audio,video,floppy,log,network,rfkill,scanner,storage,optical,power,wheel" liveuser
#Set permission
sed -i 's/#\(PermitRootLogin \).\+/\1yes/' /etc/ssh/sshd_config
sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist
sed -i 's/#\(Storage=\)auto/\1volatile/' /etc/systemd/journald.conf

sed -i 's/#\(HandleSuspendKey=\)suspend/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleHibernateKey=\)hibernate/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleLidSwitch=\)suspend/\1ignore/' /etc/systemd/logind.conf
#Set services
systemctl enable pacman-init.service choose-mirror.service
systemctl enable lightdm.service
systemctl set-default graphical.target
systemctl enable bluetooth.service
rm -r /etc/systemd/system/getty@tty1.service.d/autologin.conf
systemctl enable NetworkManager.service
#Set password
passwd root
passwd liveuser

visudo


chown -R liveuser:users /home/liveuser/.config
chown -R liveuser:users /home/liveuser


sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist
pacman -Sy
pacman-key --init
kodepas setup
