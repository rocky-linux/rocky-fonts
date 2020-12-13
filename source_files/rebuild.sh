#!/bin/bash
set -e

echo "====================="
echo "ROCKY REBRAND UTILITY"
echo "_____________________"

#families=("Display" "Text")
families=("Display")
#variants=("Bold" "Medium" "Regular")
variants=("Black")

pwd=$PWD

for family in "${families[@]}"
do
  for base_variant in "${variants[@]}"
  do
    fm_vr=("$base_variant" "`echo $base_variant`Italic")

    for variant in "${fm_vr[@]}"
    do
      cd "$pwd/$family/$variant"

      title="RedHat$family-$variant"
      new_title="Rocky$family-$variant"
      
      if [ $variant == 'RegularItalic' ]; then
        title="RedHat$family-Italic"
        new_title="Rocky$family-Italic"
      fi

      echo "'$title' -> '$new_title'"

      sed -i "s/RedHat/Rocky/g" './features'
      sed -i "s/RedHat/Rocky/g" './current.fpr'

      [[ -d "$title.ufo" ]] && mv "$title.ufo" "$new_title.ufo"
      sed -i "s/RedHat/Rocky/g" "$new_title.ufo/fontinfo.plist"
      sed -i "s/RedHat/Rocky/g" "$new_title.ufo/lib.plist"
      sed -i "s/Red Hat/Rocky/g" "$new_title.ufo/fontinfo.plist"
      sed -i "s/Red Hat/Rocky/g" "$new_title.ufo/lib.plist"

      [[ -f "$title kern.fea" ]] && mv "$title kern.fea" "$new_title kern.fea"
      sed -i "s/RedHat/Rocky/g" "$new_title kern.fea"

      [[ -f "`echo $title`_source.ttf" ]] && mv "`echo $title`_source.ttf" "`echo $new_title`_source.ttf"

      ttx "`echo $new_title`_source.ttf"
      sed -i "s/RedHat/Rocky/g" "`echo $new_title`_source.ttx"
      sed -i "s/Red Hat/Rocky/g" "`echo $new_title`_source.ttx"
      rm "`echo $new_title`_source.ttf"
      ttx "`echo $new_title`_source.ttx"
    done
  done
done
