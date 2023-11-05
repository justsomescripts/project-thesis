## Implementation of a mobile charging device that automatically creates backups of iOS-devices

This repo contains a project thesis (German) I wrote during my studies in mechatronics. It includes a PoC for fully automated iOS backups using the open source library [libimobiledevice](https://libimobiledevice.org/).

The service can run on a Raspberry Pi Zero that's integrated
into a charging device using a custom 3D-printed case.

### 📜 Abstract

> The following thesis describes the implementation of a mobile charging device that automatically 
> creates backups of iOS-devices during each charging process. In contrast to comparable
> products, it does not focus on file synchronization or media backups, but full system backups as
> a secure alternative for cloud-backups. This prevents data loss if the device is damaged or lost
> without the need of additional effort. To create these backups, a single-board computer with a
> Linux system and open-source software is used to store all data on a USB stick.

### 📁 Files

- [thesis.pdf](docs/thesis.pdf) Final document
- [iosbackup.service](systemd/iosbackup.service) Systemd service for automated backup
- [restore.sh](scripts/restore.sh) Restore backups directly from the backup device
- [backup.sh](scripts/backup.sh) Run the actual backup (started by systemd service, triggered by udev)
- [firstbackup.sh](scripts/firstbackup.sh) Manual backup (optional, can be used to activate encryption)
- [restore.sh](scripts/restore.sh)
- [presentation.pdf](docs/presentation.pdf) Powerpoint presentation
