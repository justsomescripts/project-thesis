#!/bin/bash

## Programm zum manuellen Erstellen der ersten Sicherung und Aktivieren der Backup-Verschlüsselung

# Speicherort des Backups
DIR="/backup.tmp"
DEV="/dev/sda1"

# Auslesen des UDID des iOS-Geräts
ID=$(/home/iosback/usr/bin/idevice_id | awk '{print $1}')

# Überprüfen, ob bereits eine Sicherung des angeschlossenen Geräts auf dem Stick vorhanden ist
if [[ -d $DIR/$ID ]]; then
	printf "Ein Backup dieses Geräts existiert bereits!\n" 
else

# Starten des Backups und Aktivieren der Verschlüsselung, wenn keine Sicherung vorhanden ist
printf "Folgen Sie zum Erstellen des ersten Backups den folgenden Schritten. Somit wird eine Verschlüsselung sichergestellt.\nBitte nur ein iOS-Gerät anschließen\n"

idevicebackup2 -i encryption on && printf "\n" 

# USB-stick unter Backup-Speicherort einhängen
sudo mount $DEV $DIR

# Erstellen des Zielverzeichnisses
sudo mkdir $DIR/$ID

# Aushängen des USB-Sticks
sudo umount $DEV

printf "Trennen Sie das Gerät vom Ladekabel.\n"

fi

