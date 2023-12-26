#!/bin/bash

defaultlang="fr"
dicodir="/usr/local/dico"

if [[ $1 == "--fr" || $1 == "--en" ]]; then
  man $dicodir/${1#--}/$2*
else
  man $dicodir/$defaultlang/$1*
fi
