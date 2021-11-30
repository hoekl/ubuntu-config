#!/bin/bash
apt-get update
apt-get upgrade -y
sed -i '/daemon/a InitialSetupEnable = false' /etc/gdm3/custom.conf
sed -i 's/SystemAccount=false/SystemAccount=true/' /var/lib/AccountsService/users/it-services
apt-get install unattended-upgrades
echo -e "APT::Periodic::Update-Package-Lists \"1\";\nAPT::Periodic::Unattended-Upgrade \"1\";\n" > /etc/apt/apt.conf.d/20auto-upgrades
sed -i 's|//Unattended-Upgrade::Remove-Unused-Dependencies "false"|Unattended-Upgrade::Remove-Unused-Dependencies "true"|' /etc/apt/apt.conf.d/50unattended-upgrades
printf "\n\nAdding new LUKS key...\n"
cryptsetup -y luksAddKey -S 1 /dev/nvme0n1p3
