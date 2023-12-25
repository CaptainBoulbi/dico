#!/bin/bash

sed -n -e "/.*defbox.*/,/^ *<\/div>$/ p" personne

sed -n -e "/.*defbox.*/,/^ *<\/div>$/ p" herbe
