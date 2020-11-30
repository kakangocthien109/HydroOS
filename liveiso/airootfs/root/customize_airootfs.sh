
#!/usr/bin/env bash
#
# SPDX-License-Identifier: GPL-3.0-or-later

set -e -u

# Warning: customize_airootfs.sh is deprecated! Support for it will be removed in a future archiso version.

sed -i 's/#\(vi_VN\.UTF-8\)/\1/' /etc/locale.gen

echo "LANG=vi_VN.UTF-8" >> /etc/locale.conf
echo "LANGUAGE=vi_VN.UTF-8" >> /etc/locale.conf
echo "LC_COLLATE=C" >> /etc/locale.conf
echo "LC_ALL=C" 
locale-gen

# virtual console
echo "KEYMAP=us" > /etc/vconsole.conf

# Time and clock
ln -sf /usr/share/zoneinfo/UTC /etc/localtime
hwclock --systohc --utc

sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist
ln -sf /usr/share/zoneinfo/UTC /etc/localtime

usermod -s /usr/bin/zsh root
cp -aT /etc/skel/ /root
chmod 700 /root

useradd -m -p "" -g users -G "adm,audio,floppy,log,network,rfkill,scanner,storage,optical,power,wheel" -s /bin/zsh liveuser
usermod -a  -G "adm,audio,video,floppy,log,network,rfkill,scanner,storage,optical,power,wheel" liveuser




sed -i 's/#\(PermitRootLogin \).\+/\1yes/' /etc/ssh/sshd_config
sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist
sed -i 's/#\(Storage=\)auto/\1volatile/' /etc/systemd/journald.conf

sed -i 's/#\(HandleSuspendKey=\)suspend/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleHibernateKey=\)hibernate/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleLidSwitch=\)suspend/\1ignore/' /etc/systemd/logind.conf


systemctl enable pacman-init.service choose-mirror.service
systemctl set-default multi-user.target
systemctl enable lightdm.service
systemctl enable NetworkManager.service

passwd root
passwd liveuser

visudo


chown -R liveuser:users /home/liveuser/.config
chown -R liveuser:users /home/liveuser


pacman -Sy
pacman-key --init
pacman-key --populate archlinux
ibus-daemon -drx
ibus-setup
kodepas setup
