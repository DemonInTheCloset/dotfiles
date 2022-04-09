# dotfiles

My (@DemonInTheCloset) configuration files.

## System Requirements

- ArtixLinux (with dinit) **(I personally recommend the linux-zen kernel)**
  - Might work with Arch Linux, but you'd need to somehow get dinit as you user
    services manager.
- Configure rclone acording to the [documentation](https://rclone.org/docs/)
  It doesn't matter which service you use as long as you name it `Drive`

### Pass

Look at the directory `pass_example` in this repository:

1. Copy the directory structure
2. Populate files with data using `pass edit` or `pass insert`
<!-- TODO: Improve documentation/add shellscript to create a base password
database -->

## Common terminology

- `#` before a command (ie. `# pacman -S linux-zen`)
  - The command needs to be run either as the root user or through `sudo`
- `$` before a command (ie. `$ wget https://wiki.archlinux.org/`)
  - The command can (and should) be run without root privileges
- Enable (of a systemd Unit) see [systemd](https://wiki.archlinux.org/title/systemd#Using_units)
  - Autostart a systemd Unit. This can be done through:
    - `# systemctl enable my-unit.service` (For things that should always run
      (ie. Networking))
    - `$ systemctl enable --user my-unit.service` (For user spacific things (ie.
      Cloud Sync))
  - Autostart and run now:
    - `# systemctl enable --now my-unit.service`
    - `$ systemctl enable --now --user my-unit.service`
- Start (of a systemd Unit) see [systemd](https://wiki.archlinux.org/title/systemd#Using_units)
  - Run a systemd Unit. This can be done through:
    - `# systemctl start my-unit.service` (For things that should always run (ie.
      Networking))
    - `$ systemctl start --user my-unit.service` (For user spacific things (ie.
      Cloud Sync))

## Setup

1. Prepare passwords database (see [Pass](#Pass))
2. Install `chezmoi`, `pass`, and optionally an aur helper (`paru` in my case)
3. Run `chezmoi init DemonInTheCloset` (clones this git repo)
4. Run `chezmoi apply` (copies these dotfiles)
5. Run `cat pkglist_headless.txt | pacman -S -` (optionally run
   `cat pkglist_headless.txt pkglist_gui.txt pkglist_aur.txt | paru -S -` instead)

## Post Setup

- Enable `fstrim.timer` (Only necessary if you are using [SSDs](https://wiki.archlinux.org/title/Solid_state_drive))

```console
# systemctl enable --now fstrim.timer
Created symlink /etc/systemd/system/timers.target.wants/fstrim.timer → /usr/lib/systemd/system/fstrim.timer
```
