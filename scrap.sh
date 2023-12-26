#!/bin/bash
# https://www.le-dictionnaire.com/definition/personne
# https://www.synonymes.com/synonyme.php?mot=personne

fr_words=$(cat /usr/share/dict/french)
en_words=$(cat /usr/share/dict/american-english)

dicodir="."
langdir="fr"
mkdir -p $dicodir/$langdir

word="personne"

echo ".TH $word 1 $word\-1.0" > $dicodir/$langdir/$word.1

sed -n -e "/.*defbox.*/,/^ *<\/div>$/ p" $word \
  | sed "s/.*extraboxinfo.*/.SH/g"             \
  | sed "s/.*defbox.*/.SH/g"                   \
  | sed "s/.*motboxinfo\">/.I\n/g"             \
  | sed "s/.*<li>/.P\n- /g"                    \
  | sed "s/<[^>]*>//g"                         \
  | sed "s/^ *//g"                             \
  | sed "/^$/d"                                >> $dicodir/$langdir/$word.1

# sed cmd in order:

# get only defbox divs
# extra box info title
# definition title
# definition info: genre, pluriel...
# def liste
# rm html balise
# rm wild indentation
# rm empty line
