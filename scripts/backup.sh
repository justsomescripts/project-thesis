#!/bin/bash

## Hauptprogramm zum Erstellen eines iOS-Backups auf einem externen USB-Stick mittels "libimobiledevice"

# Speicherort der Sicherung
DIR="/backup.tmp"
DEV="/dev/sda1"

# Auslesen der Medienspeicherkapazität des iOS-Geräts und der Speicherkapazität des USB-Sticks
DISKIOS=$(/home/iosback/usr/bin/ideviceinfo -q com.apple.disk_usage | grep TotalDataCapacity | awk '{print $2}')
DISKUSB=$(blockdev --getsize64 /dev/sda1)

mkdir $DIR 

# Auslesen des UDID des iOS-Geräts
ID=$(/home/iosback/usr/bin/idevice_id | awk '{print $1}')

# USB-stick unter Backup-Speicherort einhängen
mount $DEV $DIR && mkdir $DIR/$ID

# Überprüfen, ob die Kapazität des USB-Sticks ausreicht
if [ $DISKUSB -ge $DISKIOS ] && [ -a $DEV ]; then

	# Starten des Sicherungsprozesses
	until /home/iosback/usr/bin/idevicebackup2 backup $DIR; do
		echo failed, retry in 10s
		sleep 10
	done

# Warnung, wenn der Speicherplatz des USB-Sticks nicht ausreicht
elif [ -a $DEV ]; then
	printf "Speicherplatz nicht ausreichend! Benötigt: $DISKIOS [Byte]; verfügbar: $DISKUSB [Byte]\n"
	exit 1

# Warnung, wenn kein USB-Stick vorhanden ist
else
	printf "Kein USB-Laufwerk vorhanden!\n"
	exit 1
fi

# Aushängen des USB-Sticks
sleep 20 && umount $DIR
