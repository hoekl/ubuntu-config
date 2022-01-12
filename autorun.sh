#!/bin/bash
check=0
function get_pw {
  printf "Enter new password: "
  read pass1
  printf "Verify password: "
  read pass2
  if [ "$pass1" = "$pass2" ]
  then
  password=$pass1
  check=1
  fi
}

printf "\nSelect which OS you are setting up:\n\n1: Ubuntu 20.04 LTS\n2: CentOS 7\n\n:"
read choice
printf "\n"
if [ $choice = "1" ]
then
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
while [ $check = 0 ];
do
  get_pw
done
echo "$username:$password" | chpasswd
usermod -a -G sudo $username
elif [ $choice = "2" ]
then
  yum update -y
  yum install -y yum-cron
  sed -i 's/apply_updates = no/apply_updates = yes/' /etc/yum/yum-cron.conf
  service yum-cron start
  touch /etc/dconf/db/gdm.d/00-login-screen
  echo -e "[org/gnome/login-screen]\ndisable-user-list=true" > /etc/dconf/db/gdm.d/00-login-screen
  dconf update
  cryptsetup -y luksAddKey -S 1 /dev/nvme0n1p3
  printf "Enter UoB username of user: "
  read username
  printf "Enter full name of user: "
  read fullname
  useradd $username -U -G wheel -c "$fullname"
  while [ $check = 0 ];
  do
    get_pw
  done
  echo $password | passwd $username --stdin
fi
printf "Reboot now to apply all changes? (y/n): "
read rebootchoice
if [ $rebootchoice = "y" ] || [ $rebootchoice = "Y" ]
then
  reboot
else
  exit
fi
