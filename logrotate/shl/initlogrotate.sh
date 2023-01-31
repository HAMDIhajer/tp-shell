#!/bin/bash


#Declaration variables

#Horodatage
HORODATAGE=$(date '+%Y%m%d%H%M')
DIR_SHL=`pwd`
DIR_HOME="${DIR_SHL%/*}"
DIR_WRK="$DIR_HOME/wrk"
DIR_LOG="$DIR_HOME/log"
DIR_TMP="$DIR_HOME/tmp"
DIR_CFG="$DIR_HOME/cfg"
FIC_LOG="$DIR_LOG/logrotate_$HORODATAGE.log"
LIST_FIC="$DIR_WRK/logrotate_$HORODATAGE.lst"

echo "initLogrotate [INFO] : 0. Debut programme $0" | tee -a $FIC_LOG

# Check de parametrage passé au programme
# si rien passe en parametrage dans le programme principale

if [ $# -eq 0 ]
then
       	echo "initLogrotate [INFO] : Aucun nom de fichier de configuration passe en paramètre" | tee -a $FIC_LOG

     echo "initLogrotate [INFO] : FIC_PARAM=$DIR_CFG/logrotate.cfg (Valeur par defaut)" | tee -a $FIC_LOG

     FIC_PARAM="$DIR_CFG/logrotate.cfg"
#Si un valeur a été passé en paramètre dans le programme principale
else FIC_PARAM=$1
     echo "initLogrotate [INFO] : FIC_PARAM=$1" | tee -a $FIC_LOG

fi

# Creation des environnement de travail pour le script de rotation de log ( Premier fois)
mkdir -p $DIR_WRK
mkdir -p $DIR_LOG
mkdir -p $DIR_TMP

if ! test -s "$FIC_PARAM"
then
	echo "initLogrotate [ERROR] : Fichier $FIC_PARAM vide ou inexistante" | tee -a $FIC_LOG

	exit 1
fi

#creation liste log

touch $LIST_FIC

#Recapitulatif parametrage

echo "initLogrotate [INFO] : ####################################" | tee -a $FIC_LOG

echo "initLogrotate [INFO] : 1. Detail des variables du programme" | tee -a $FIC_LOG

echo "initLogrotate [INFO] : ####################################" | tee -a $FIC_LOG

echo "initLogrotate [INFO] :" | tee -a $FIC_LOG

echo "initLogrotate [INFO] : HORODATAGE = $HORODATAGE" | tee -a $FIC_LOG

echo "initLogrotate [INFO] : DIR_HOME   = $DIR_HOME" | tee -a $FIC_LOG

echo "initLogrotate [INFO] : DIR_SHL    = $DIR_SHL" | tee -a $FIC_LOG

echo "initLogrotate [INFO] : DIR_WRK    = $DIR_WRK" | tee -a $FIC_LOG

echo "initLogrotate [INFO] : DIR_LOG    = $DIR_LOG" | tee -a $FIC_LOG

echo "initLogrotate [INFO] : DIR_TMP    = $DIR_TMP" | tee -a $FIC_LOG

echo "initLogrotate [INFO] : DIR_CFG    = $DIR_CFG" | tee -a $FIC_LOG

echo "initLogrotate [INFO] : LIST_FIC   = $LIST_FIC" | tee -a $FIC_LOG

echo "initLogrotate [INFO] :" | tee -a $FIC_LOG

echo "initLogrotate [INFO] :" | tee -a $FIC_LOG

echo "initLogrotate [INFO] : Fin de initLogrotate" | tee -a $FIC_LOG


