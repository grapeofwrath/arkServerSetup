## Finding Engrams
Using an engram whitelist is a pain to curate but a lifesaver for lag when you want to customize them. Unfortunately, I've only found one guide for actually finding engrams from the base game and mods so I'm making this for redundancy. Currently this guide is for Linux using bash; I'll probably get around to adding Windows instructions later. Hopefully it will help out:)

This line of bash is to be run in either the mod directory or the respective vanilla directory (more on this below).


Full: This adds the correct syntax and arguments such as cost, prereq, etc.
```bash
find . -iname EngramEntry_* | xargs -n1 basename | sed 's/EngramEntry_/OverrideNamedEngramEntries=(EngramClassName=EngramEntry_"/' | sed 's/.uasset/_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False)/' > outputfile
```
> __Output:__ OverrideNamedEngramEntries=(EngramClassName=EngramEntry_"EngrameName_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False)


Simplified: This outputs the name of each engram.
```bash
find . -iname EngramEntry_* | xargs -n1 basename | sed 's/EngramEntry_//' | sed 's/.uasset/_C/' > outputfile
```
> __Output:__ EngramName_C


The directories are located in differing locations depending on whether or not you're configuring a server. Server directories stem from the arkserver (/arkserver/ShooterGame/Content/) while local directories stem from ARK (/steamapps/common/ARK/ShooterGame/Content/).


Vanilla dirs: /Content/directory [Aberration, Extinction, Genesis, PrimalEarth(base game), ScorchedEarth]


Mod dirs: /Content/Mods/modnumber
