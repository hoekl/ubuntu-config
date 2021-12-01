# ubuntu-config

Script to simplify configuration of UoB Ubuntu 20.04 Laptops.


All setup tasks are handled automatically.

The script needs to run with ```sudo``` privileges since it is modifying files in protected directories.

User interaction is only required at the end of the script when adding another key to the LUKS keychain and when adding the new user account for the end user.

The script is set up for Laptops with an NVME SSD. For Laptops with a SATA drive the last line will need to be amended from ```/dev/nvme0n1p3``` to ```dev/sda3```.

*This script comes with absolutely no warranties and is used at your own risk.*


## Usage

- Open a terminal (Ctrl+Alt+T)
- Type ```wget https://raw.githubusercontent.com/hoekl/ubuntu-config/main/autorun.sh``` into the terminal and press enter
- Type ```chmod +x autorun.sh``` and press enter
- Type ```sudo ./autorun.sh``` and press enter and supply password when prompted
- Enter information into terminal as prompted by the script

