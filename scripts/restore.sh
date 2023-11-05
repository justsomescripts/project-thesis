#!/bin/bash

## Programm zum Wiederherstellen eines gespeicherten Backups über das Ladegerät

# Speicherort der Sicherung
DIR="/backup.tmp"
DEV="/dev/sda1"

# Auslesen des UDID des iOS-Geräts
ID=$(/home/iosback/usr/bin/idevice_id | awk '{print $1}') 

# USB-stick unter Backup-Speicherort einhängen
sudo mount $DEV $DIR

# Überprüfen, ob ein USB-Stick vorhanden ist, welcher eine Sicherung des angeschlossenen Geräts enthält
if [ -d $DIR/$ID ] && [ -a $DEV ]; then

	# Wiederherstellung der Sicherung starten
	idevicebackup2 --source $ID restore --system --settings $DIR -i

# Fehlermeldung, wenn keine Sicherung des Geräts vorhanden ist
elif [ -a $DEV ]; then
	printf "Keine Sicherung für das angeschlossene Gerät vorhanden!\n"

# Fehlermeldung, wenn kein USB-Stick angeschlossen ist
else
	printf "Bitte schließen sie einen USB-Stick an\n"
fi

# Aushängen des USB-Sticks
sleep 20 && sudo umount $DIR

