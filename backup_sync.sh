# MASSE MASSE Paul-Basthylle
# 22U2001

#!/bin/bash

# Je définis les variables

SOURCE_DIR="/home/paolo/Téléchargements/A Sauvegarder/student_room_search"
BACKUP_DIR="/home/paolo/Téléchargements/Windows/Sauvegarde/backup1"
LOG_FILE="/home/paolo/Téléchargements/Windows/Sauvegarde/backup1/rsync_log.txt"

# Mon cours Paul-Basthylle Masse Masse :

# -a : Archive
# -v : Affiche les fichiers copiés
# --delete : Supprime les fichiers dans le dossier de sauvegarde qui n'existent plus dans la source
# --progress : Affiche la progression des transferts
RSYNC_OPTIONS="-av --delete --progress"

# Je crée le dossier de destination s'il n'existe pas

mkdir -p "$BACKUP_DIR"

# J'effectue la synchronisation
echo "Début de la synchronisation : $(date)" >> "$LOG_FILE"
if rsync $RSYNC_OPTIONS "$SOURCE_DIR/" "$BACKUP_DIR/"; then
    echo "Synchronisation réussie : $(date)" >> "$LOG_FILE"
else
    echo "Erreur pendant la synchronisation : $(date)" >> "$LOG_FILE"
fi
echo "Fin de la synchronisation : $(date)" >> "$LOG_FILE"

