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

## Common terminology

- `#` before a command (ie. `# pacman -S linux-zen`)
  - The command needs to be run either as the root user or through `sudo`
- `$` before a command (ie. `$ wget https://wiki.archlinux.org/`)
  - The command can (and should) be run without root privileges
- Enable (of a systemd Unit) see [systemd](https://wiki.archlinux.org/title/systemd#Using_units)
  - Autostart a systemd Unit. This can be done through:
    - `# systemctl enable my-unit.service` (For things that should always run (ie. Networking))
    - `$ systemctl enable --user my-unit.service` (For user spacific things (ie. Cloud Sync))
  - Autostart and run now:
    - `# systemctl enable --now my-unit.service`
    - `$ systemctl enable --now --user my-unit.service`
- Start (of a systemd Unit) see [systemd](https://wiki.archlinux.org/title/systemd#Using_units)
  - Run a systemd Unit. This can be done through:
    - `# systemctl start my-unit.service` (For things that should always run (ie. Networking))
    - `$ systemctl start --user my-unit.service` (For user spacific things (ie. Cloud Sync))

## Post Setup

- Enable `fstrim.timer` (Only necessary if you are using [SSDs](https://wiki.archlinux.org/title/Solid_state_drive))

```console
# systemctl enable --now fstrim.timer
Created symlink /etc/systemd/system/timers.target.wants/fstrim.timer → /usr/lib/systemd/system/fstrim.timer
```
