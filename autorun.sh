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
printf "Enter UoB username of new user: "
read username
printf "Enter full name of user: "
read fullname
adduser --gecos "" --disabled-password $username
usermod -c "$fullname" $username
check=0
while [ $check = 0 ];
do
  printf "Enter new password: "
  read pass1
  printf "Verify password: "
  read pass2
  if [ "$pass1" = "$pass2" ]
  then
  check=1
  fi
done
echo "$username:$pass1" | chpasswd
usermod -a -G sudo $username

