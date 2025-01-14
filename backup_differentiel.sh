# MASSE MASSE Paul-Basthylle
# 22U2001

#!/bin/bash

# Je définis les variables

SOURCE_DIR="/home/paolo/Téléchargements/Mes cours" # autre test
BACKUP_BASE_DIR="/home/paolo/Téléchargements/Windows/Sauvegarde/Save_work_diff"

FULL_BACKUP_DIR="$BACKUP_BASE_DIR/backup_full"
DIFF_BACKUP_DIR="$BACKUP_BASE_DIR/backup_differentiel_$(date +'%Y-%m-%d_%H-%M-%S')"
LOG_FILE="$BACKUP_BASE_DIR/rsync_log.txt"

# Mon cours Paul-Basthylle Masse Masse :

# -a : Archive
# -v : Affiche les fichiers copiés
# --progress : Affiche la progression des transferts
RSYNC_OPTIONS="-av --progress"

# Je vérifie si une sauvegarde complète existe

if [ ! -d "$FULL_BACKUP_DIR" ]; then
    echo "Aucune sauvegarde complète trouvée. Création de la sauvegarde complète initiale." >> "$LOG_FILE"
    mkdir -p "$FULL_BACKUP_DIR"
    if rsync $RSYNC_OPTIONS "$SOURCE_DIR/" "$FULL_BACKUP_DIR/"; then
        echo "Sauvegarde complète initiale réussie : $(date)" >> "$LOG_FILE"
    else
        echo "Erreur pendant la création de la sauvegarde complète : $(date)" >> "$LOG_FILE"
        exit 1
    fi
fi

# Création du répertoire pour la sauvegarde différentielle

mkdir -p "$DIFF_BACKUP_DIR"

# Je commence la sauvegarde différentielle

echo "Début de la sauvegarde différentielle : $(date)" >> "$LOG_FILE"
if rsync $RSYNC_OPTIONS --link-dest="$FULL_BACKUP_DIR" "$SOURCE_DIR/" "$DIFF_BACKUP_DIR/"; then
    echo "Sauvegarde différentielle réussie : $(date)" >> "$LOG_FILE"
else
    echo "Erreur pendant la sauvegarde différentielle : $(date)" >> "$LOG_FILE"
    exit 1
fi

echo "Fin de la sauvegarde : $(date)" >> "$LOG_FILE"


