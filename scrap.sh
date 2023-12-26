#!/bin/bash
# https://www.le-dictionnaire.com/definition/personne
# https://www.synonymes.com/synonyme.php?mot=personne

defurl="https://www.le-dictionnaire.com/resultats.php?mot="
synurl="https://www.synonymes.com/resultats.php?mot="

fr_words=$(cat /usr/share/dict/french)
#TODO
#en_words=$(cat /usr/share/dict/american-english)

dicodir="/usr/local/dico"
langdir="fr"
sudo mkdir -p $dicodir/$langdir
sudo chown $USER:$USER -R $dicodir

dwldir="./dwl"
sudo mkdir -p $dwldir
sudo chown $USER:$USER -R $dwldir

for word in $fr_words; do

  wget $defurl$word -O $dwldir/$word
  wget $synurl$word -O $dwldir/$word.syn

  echo ".TH $word 1 $word\-1.0" > $dicodir/$langdir/$word

  sed -n -e "/.*defbox.*/,/^ *<\/div>$/ p" $dwldir/$word \
    | sed "s/.*extraboxinfo.*/.SH/g"                     \
    | sed "s/.*defbox.*/.SH/g"                           \
    | sed "s/.*motboxinfo\">/.I\n/g"                     \
    | sed "s/.*<li>/.P\n- /g"                            \
    | sed "s/<[^>]*>//g"                                 \
    | sed "s/^ *//g"                                     \
    | sed "/^$/d"                                        >> $dicodir/$langdir/$word

  # sed cmd in okrder:

  # get only defbox divs
  # extra box info title
  # definition title
  # definition info: genre, pluriel...
  # def liste
  # rm html balise
  # rm wild indentation
  # rm empty line

  echo -e ".SH\nSynonymes" >> $dicodir/$langdir/$word

  sed -n -e "/.*defbox.*/,/^ *<\/div>$/ p" $dwldir/$word.syn \
    | sed "s/^ *<li>/.P\n/g"                                   \
    | sed "s/<li>/, /g"                                      \
    | sed "s/<[^>]*>//g"                                     \
    | sed "s/^ *//g"                                         \
    | sed "/^$/d"                                            >> $dicodir/$langdir/$word

  rm $dwldir/$word $dwldir/$word.syn

done
