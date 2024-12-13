#MASSE MASSE Paul-Basthylle
#22U2001


#!/bin/bash

#je définis les variables

#SOURCE_DIR="/home/paolo/Téléchargements/TP en C/Blason-EB"
#BACKUP_DIR="/home/paolo/Téléchargements/Windows/Sauvegarde/backup2"


#SOURCE_DIR="/home/paolo/Téléchargements/payement"
#BACKUP_DIR="/home/paolo/Téléchargements/Windows/Sauvegarde/backup2"

SOURCE_DIR="/home/paolo/Téléchargements/Mes cours" #autre test
BACKUP_DIR="/media/paolo/Disk_Raoul/Users/Mes cours" #chemin autre

#DATE=$(date +"Y-%m-%d_%H-%M-%S")
SNAPSHOT_DIR="$BACKUP_DIR"
LATEST_LINK="$BACKUP_DIR/latest"
LOG_FILE="$BACKUP_DIR/rsync_log.txt"

#Mon cours Paul-Basthylle Masse Masse:

#-a : Archive
#-v : affiche les fichiers copiés
#--delete : supprime les fichiers dans le dossier de sauvegarde qui n'existent plus dans la source
#-- progress: Affiche la progression des transferts


RSYNC_OPTIONS="-av --progress"

 #ici je préfère retirer --delete à cause des fichiers que j'utilise sur windows et qui ne sont pas dans mon ubuntu sinon ca va supprimer cela

#je créé le dossier s'il n'existe pas

mkdir -p "$BACKUP_DIR"

#je commence la sauvegarde

echo "Début de la sauvegarde: $(date)" >> "$LOG_FILE"

#synchronisation avec hard links pour les fichiers inchangés

if [ -d "$LATEST_LINK" ]; then
	
	#sauvegarde differentielle

     rsync $RSYNC_OPTIONS --link-dest="$LATEST_LINK" "$SOURCE_DIR/" "$SNAPSHOT_DIR/"
else
	#je fais la save complete initiale
	
	rsync $RSYNC_OPTIONS "$SOURCE_DIR/" "$SNAPSHOT_DIR/"
	echo "Erreur pendant la sauvegarde : $(date)" >> "$LOG_FILE"
fi

if [ $? -eq 0 ]; then
	echo "Sauvegarde réussie : $SNAPSHOT_DIR" >> "$LOG_FILE"
	
	#je mets a jour le lien symbolique vers le dernier snapshot
	ln -sfn "$SNAPSHOT_DIR" "$LATEST_LINK"
else

	echo "Erreur pendant la sauvegarde : $(date)" >> "$LOG_FILE"
fi

echo "Fin de la sauvegarde : $(date)" >> "$LOG_FILE"
echo "Sauvegarde terminée"
