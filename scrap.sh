#!/bin/bash

fr_words=$(cat /usr/share/dict/french)
en_words=$(cat /usr/share/dict/american-english)

sed -n -e "/.*defbox.*/,/^ *<\/div>$/ p" personne

sed -n -e "/.*defbox.*/,/^ *<\/div>$/ p" herbe
