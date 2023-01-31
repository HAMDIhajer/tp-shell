#!/bin/bash

################################################
# Script: ROTATION DE LOG
###############################################
#**** Config ****

function usage {
        echo -e "\nCe script est a lancer avec un seul parametre ou sans parametre"
        echo -e "\nUsage: ./logrotate.sh [argument] \n"
}

#Vérification de nombre de parametre

if [ $# -gt 1 ]
then
        usage
        exit 1
fi

#Chargement de la configuration
source initlogrotate.sh

#Traitement en utilisant le fichier de configuration fourni

while read ligne
do
	# on saute les lignes vides ou commentées
	echo "$ligne" | grep -E "^$" > /dev/null && continue
	echo "$ligne" | grep -E "^#" > /dev/null && continue

# Pour chaque consigne on parse afin d'obtenir les infos sur les champs
        REP=$(echo "$ligne" | cut -d";" -f1)
	FIC_PATTERN=$(echo "$ligne" | cut -d";" -f2)
	RETENTION=$(echo "$ligne" | cut -d";" -f3)
	PROFONDEUR=$(echo "$ligne" | cut -d";" -f4)

if [ "x$PROFONDEUR" = "x" ]
then 
	PROFONDEUR=1
fi
#echo "$REP"
#echo "$FIC_PATTERN"
#echo "$RETENTION"

#check repertoire
if test ! -d $REP -o -z $REP
then
        echo "[WARNING] $REP n'existe pas. Merci de corriger $FIC_PARAM"
        continue
fi

#affichage de la configuration pour la ligne de paramétrage
 #on purge
 #on peut tomber sur une erreur si la liste de fichier à supprimer est trop grande à cause du ls
 #dans ce cas, supprimer ceci de la commande find: -exec ls -ltd "{}" +

find $REP -name "$FIC_PATTERN" -mtime "+$RETENTION" -maxdepth "$PROFONDEUR" -exec ls "{}" + | while read findLine

do
       #obtenir la taille du fichier qu'on va supprimer
       taille=$(wc -c $findLine | awk '{print $1}')
       #on supprimer le fichier
        if rm -f $findLine
      then  echo "$findLine $taille SUPPRIME" >> $LIST_FIC
      else  echo "$findLine $taille ERROR" >> $LIST_FIC
      fi
done
done < $FIC_PARAM
