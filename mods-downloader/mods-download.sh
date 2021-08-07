#!/bin/sh

CSV_FILE='/mods.csv'
if [ ! -e "$CSV_FILE" ]; then
  exit 0
fi

mods_csv=`cat $CSV_FILE | sed '1d'`

for line in ${mods_csv}; do
  mod_url=`echo ${line} | cut -d, -f2`
  mod_name=`echo ${line} | cut -d, -f3`

  if [ -e "$mod_name" ]; then
    echo "${mod_name} already exists"

  else
    echo "${mod_name} doesn't exist yet"
    wget $mod_url -O $mod_name
  fi

done

exit 0
