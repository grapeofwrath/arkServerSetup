## Finding Engrams
I've only found one guide for actually finding engrams from the base game and mods so I'm making this for redundancy.

This line of bash is to be run in either the mod directory or the respective vanilla directory (more on this below).


Full
```bash
find . -iname EngramEntry_* | xargs -n1 basename | sed 's/EngramEntry_/OverrideNamedEngramEntries=(EngramClassName=EngramEntry_"/' | sed 's/.uasset/_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False)/' > outputfile
```
> __Output:__ OverrideNamedEngramEntries=(EngramClassName=EngramEntry_"EngrameName_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False)


Simplified
```bash
find . -iname EngramEntry_* | xargs -n1 basename | sed 's/EngramEntry_//' | sed 's/.uasset/_C/' > outputfile
```
> __Output:__ EngramName_C
