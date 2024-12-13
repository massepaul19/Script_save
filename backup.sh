#MASSE MASSE Paul-Basthylle
#22U2001


#!/bin/bash

#je définis les variables

SOURCE_DIR="/home/paolo/Téléchargements/A Sauvegarder/student_room_search"
BACKUP_DIR="/home/paolo/Téléchargements/Windows/Sauvegarde/backup1"
LOG_FILE="/home/paolo/Téléchargements/Windows/Sauvegarde/backup1/rsync_log.txt"

#Mon cours Paul-Basthylle Masse Masse:

#-a : Archive
#-v : affiche les fichiers copiés
#--delete : supprime les fichiers dans le dossier de sauvegarde qui n'existent plus dans la source
#-- progress: Affiche la progression des transferts


RSYNC_OPTIONS="-av --delete --progress"

#je créé le dossier s'il n'existe pas

mkdir -p "$BACKUP_DIR"

#j'effectue la synchronisation

echo "Début de la sauvegarde: $(date)" >> "$LOG_FILE"

if rsync $RSYNC_OPTIONS "$SOURCE_DIR/" "$BACKUP_DIR/"; then
    	echo "Sauvegarde réussie : $(date)" >> "$LOG_FILE"
else
	echo "Erreur pendant la sauvegarde : $(date)" >> "$LOG_FILE"
fi

echo "Fin de la sauvegarde : $(date)" >> "LOG_FILE"
