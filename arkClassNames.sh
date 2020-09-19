#!/bin/bash
#September 18, 2020

echo "Select which names to find:"
select vname in Engrams Items
do
    if [ $vname == Engrams ]; then
    	#sets var for save location, must be full filepath
        read -p "Save to (full filepath): " vpath
        #looks in current dir recusively for specified filenames, edit-outs non-important details
        find . -iname EngramEntry_* | xargs -n1 basename | sed 's/EngramEntry_//' | sed 's/.uasset//' > $vpath
    else
        echo "Select which items:"
        select vitem in All Ammo Armor Consumable Costumes-Skins Structure Dye Resource Weapon
        do
            read -p "Save to: " vpath
            if [ $vitem == "All" ]; then
                find . -iname PrimalItem* | xargs -n1 basename | sed 's/PrimalItem//' | sed 's/.uasset//' > $vpath
            elif [ $vitem == "Costumes-Skins" ]; then
                find . -iname PrimalItemSkin* | xargs -n1 basename | sed 's/PrimalItem//' | sed 's/.uasset//' > $vpath
                find . -iname PrimalItemCostume* | xargs -n1 basename | sed 's/PrimalItem//' | sed 's/.uasset//' >> $vpath
            elif [ $vitem == "Weapon" ]; then
                find . -iname PrimalItem$vitem* | xargs -n1 basename | sed 's/PrimalItem//' | sed 's/.uasset//' > $vpath
                find . -iname PrimalItem_Weapon* | xargs -n1 basename | sed 's/PrimalItem//' | sed 's/.uasset//' >> $vpath
            else
                find . -iname PrimalItem$vitem* | xargs -n1 basename | sed 's/PrimalItem//' | sed 's/.uasset//' > $vpath
            fi
        break
        done
    fi
    break
done
