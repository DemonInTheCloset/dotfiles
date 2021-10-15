# dotfiles

My (@DemonInTheCloset) configuration files.

## System Requirements

- ArchLinux __(I personally recommend the linux-zen kernel)__
- The packages in ./pkglist.txt
  - It is recomended to first install `yay` from the [AUR](https://aur.archlinux.org/packages/yay)
  - Then use `cat pkglist.txt | yay -S -` to install all packages
- Configure rclone acording to the [documentation](https://rclone.org/docs/)
It doesn't matter which service you use as long as you name it `Drive`
- Configure KeePassXC
  - Your Password Database should be called Passwords.kdbx and be in your home directory

### KeePassXC

You need the following entries:
- `GnuPG GitHub`:
  - UserName should be your GitHub UserName
  - It should have the following attributes:
    - `UserEmail` __(Your GitHub Email)__
    - `UserKey` __(Your GitHub PGP Key)__
- `GnuPG University`:
  - UserName your University git UserName
  - It should have the following attributes:
    - `UserEmail` __(Your University Email)__
    - `UserKey` __(Your University PGP Key)__
- `RClone`:
  - It should have the following attributes:
    - `client_id` __(Your rclone client_id)__
    - `client_secret` __(Your rclone client_secret)__
    - `root_folder_id` __(Your rclone root folder id (can be empty))__
    - `access_token` __(Your rclone access token)__
    - `refresh_token` __(Your rclone refresh token)__
- `RaspberryPi`:
  - UserName the username for ssh to log in to 
  - URL the IP/URL of the RaspberryPi
