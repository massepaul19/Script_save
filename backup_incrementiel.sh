#!/bin/bash

SOURCE_DIR="/home/paolo/Téléchargements/Mes cours"
BACKUP_DIR="/home/paolo/Téléchargements/Windows/Sauvegarde/backup2"

# Dossiers pour les snapshots

TODAY_BACKUP="$BACKUP_DIR/$(date +%Y-%m-%d)"
LATEST_LINK="$BACKUP_DIR/latest"

# Création du dossier de sauvegarde

mkdir -p "$TODAY_BACKUP"

# Options rsync

RSYNC_OPTIONS="-av --progress --link-dest=$LATEST_LINK"

# Sauvegarde incrémentale
rsync $RSYNC_OPTIONS "$SOURCE_DIR/" "$TODAY_BACKUP/" >> "$BACKUP_DIR/rsync_log.txt" 2>&1

# Mise à jour du lien "latest" pour pointer vers la dernière sauvegarde
rm -f "$LATEST_LINK"
ln -s "$TODAY_BACKUP" "$LATEST_LINK"

echo "Sauvegarde incrémentale terminée : $(date)" >> "$BACKUP_DIR/rsync_log.txt"

