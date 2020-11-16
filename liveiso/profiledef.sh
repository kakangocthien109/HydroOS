#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="HydroOS"
iso_label="HYDRO_$(date +%Y%m)"
iso_publisher="HydroOS"
iso_application="HydroOS Live ISO"
iso_version="$(date +%Y.%m.%d)"
install_dir="arch"
bootmodes=('bios.syslinux.mbr' 'bios.syslinux.eltorito' 'uefi-x64.systemd-boot.esp' 'uefi-x64.systemd-boot.eltorito')
arch="x86_64"
pacman_conf="pacman.conf"
