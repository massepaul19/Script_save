#!/bin/bash


SOURCE_DIR="/home/paolo/Téléchargements/Mes cours"
BACKUP_DIR="/home/paolo/Téléchargements/Windows/Sauvegarde"

DATE=$(date +%Y-%m-%d_%H-%M-%S)
SNAPSHOT_DIR="$BACKUP_DIR/Save_complete-$DATE"

# Création du dossier de sauvegarde

mkdir -p "$SNAPSHOT_DIR"

# Options rsync

RSYNC_OPTIONS="-av --progress"

# Sauvegarde complète

echo "Debut de la sauvegarde"

rsync $RSYNC_OPTIONS "$SOURCE_DIR/" "$SNAPSHOT_DIR/" >> "$BACKUP_DIR/rsync_log.txt" 2>&1

echo "Sauvegarde complète terminée : $(date)" >> "$BACKUP_DIR/rsync_log.txt"

