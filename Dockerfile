FROM archlinux:latest

# Make sure pacman has the latest data
RUN pacman -Syu --noconfirm

# Install arch ISO packages
RUN pacman -S --noconfirm alsa-utils amd-ucode arch-install-scripts archinstall b43-fwcutter base bind-tools brltty broadcom-wl btrfs-progs clonezilla cloud-init crda cryptsetup darkhttpd ddrescue dhclient dhcpcd diffutils dmraid dnsmasq dosfstools e2fsprogs edk2-shell efibootmgr espeakup ethtool exfatprogs f2fs-tools fatresize fsarchiver gnu-netcat gpart gpm gptfdisk grml-zsh-config grub hdparm intel-ucode ipw2100-fw ipw2200-fw irssi iw iwd jfsutils kitty-terminfo less lftp libfido2 libusb-compat linux linux-atm linux-firmware livecd-sounds lsscsi lvm2 lynx man-db man-pages mc mdadm memtest86+ mkinitcpio mkinitcpio-archiso mkinitcpio-nfs-utils modemmanager mtools nano nbd ndisc6 nfs-utils nilfs-utils nmap ntfs-3g nvme-cli openconnect openssh openvpn partclone parted partimage pcsclite ppp pptpclient pv qemu-guest-agent refind reflector reiserfsprogs rp-pppoe rsync rxvt-unicode-terminfo screen sdparm sg3_utils smartmontools sof-firmware squashfs-tools sudo syslinux systemd-resolvconf tcpdump terminus-font testdisk tmux tpm2-tss udftools usb_modeswitch usbmuxd usbutils vim virtualbox-guest-utils-nox vpnc wireless-regdb wireless_tools wpa_supplicant wvdial xfsprogs xl2tpd zsh

# Install devel packages
RUN pacman -S --noconfirm base-devel python3 python-pip nodejs npm neovim vim vi nano ed emacs code git

# Generate SSH keys
RUN ssh-keygen -A

# Fetch ssh keys and add to authorized_keys
RUN mkdir /root/.ssh
RUN curl -fsSL https://github.com/fredi-68.keys >> /root/.ssh/authorized_keys
RUN curl -fsSL https://github.com/marnixah.keys >> /root/.ssh/authorized_keys

# Set ZSH as default shell
RUN chsh -s /bin/zsh

# Set root password to a 16 character random password
RUN echo "root:$(openssl rand -base64 16)" | chpasswd

# Start SSH server
CMD ["/usr/sbin/sshd", "-D"]