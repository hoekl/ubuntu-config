# ubuntu-config

Script to simplify configuration of UoB Ubuntu 20.04 Laptops.


All setup tasks are handled automatically apart from creating the user account of the end user. This can be done via the command line as outlined in the wiki, or via the settings GUI (Users -> Add user).

The script needs to run with ```sudo``` privileges since it is modifying files in protected directories.

User interaction is only required at the end of the script when adding another key to the LUKS keychain.

The script is setup for Laptops with an NVME SSD. For Laptops with a SATA drive the last line will need to be amended from ```/dev/nvme0n1p3``` to ```dev/sda3```.

*This script comes with absolutely no warranties and is used at your own risk.*




