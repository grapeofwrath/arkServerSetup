## Finding Engrams
Using an engram whitelist is a pain to curate but a lifesaver for lag when you want to customize them. Unfortunately, I've only found one guide for actually finding engrams from the base game and mods so I'm making this for redundancy. Currently this guide is for Linux using bash; I'll probably get around to adding Windows instructions later. Hopefully it will help out:)

#### TLDR:

This line of bash is to be run in either the mod directory or the respective vanilla directory (more on this below).

__Full:__ This adds the correct syntax and arguments for the game.ini, such as cost, prereq, etc.
```bash
find . -iname EngramEntry_* | xargs -n1 basename | sed 's/EngramEntry_/OverrideNamedEngramEntries=(EngramClassName=EngramEntry_"/' | sed 's/.uasset/_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False)/' > outputfile
```
> __Output:__ OverrideNamedEngramEntries=(EngramClassName=EngramEntry_"EngrameName_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False)

__Simplified:__ This outputs the name of each engram.
```bash
find . -iname EngramEntry_* | xargs -n1 basename | sed 's/EngramEntry_//' | sed 's/.uasset/_C/' > outputfile
```
> __Output:__ EngramName_C

The directories are located in differing locations depending on whether or not you're configuring a server. Server directories stem from arkserver (/arkserver/ShooterGame/Content/) while local directories stem from ARK (/steamapps/common/ARK/ShooterGame/Content/).

Vanilla dirs: /Content/directory [Aberration, Extinction, Genesis, PrimalEarth(base game), ScorchedEarth]

Mod dirs: /Content/Mods/modnumber

#### THE DEETS:

Thanks to [ToeiRei](https://survivetheark.com/index.php?/forums/topic/415335-engram-removalhiding-config-generation/) for originally sharing this.

__Step 1:__ First we need to change to the desired directory, and then we search for any engrams inside.
```bash
cd /pathtodirectory
find . -iname EngramEntry_*
```
This will give you something like this:
> ./CoreBlueprints/Engrams/EngramEntry_Forge.uasset
>
> and a lot of other lines like that

__Step 2:__ Now we need to trim this down by adding "xargs -n1 basename".
```bash
find . -iname EngramEntry_* | xargs -n1 basename
```
This removes the filepath for each entry:
> EngramEntry_Forge.uasset

__Step 3:__ Now that we have that taken care of, we can add the correct syntax for the game.ini using the _sed_ command.

For the beginning of each entry we'll find "EngramEntry_" and replace it with: "OverrideNamedEngramEntries=(EngramClassName="EngramEntry_":
```bash
sed 's/EngramEntry_/OverrideNamedEngramEntries=(EngramClassName="EngramEntry_/'
```
> OverrideNamedEngramEntries=(EngramClassName="EngramEntry_EngramEntry_Forge.uasset

For the end of each entry we'll find ".uasset" and replace it with "_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False)":
```bash
sed 's/.uasset/_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False)/'
```
> OverrideNamedEngramEntries=(EngramClassName="EngramEntry_EngramEntry_Forge_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False)

__Step 4:__ All that's left is to combine this into one command and output it to a file.
```bash
find . -iname EngramEntry_* | xargs -n1 basename | sed 's/EngramEntry_/OverrideNamedEngramEntries=(EngramClassName=EngramEntry_"/' | sed 's/.uasset/_C",EngramHidden=False,EngramPointsCost=0,EngramLevelRequirement=0,RemoveEngramPreReq=False)/' > outputfile
```
If you wish to just have the engram class name:
```bash
find . -iname EngramEntry_* | xargs -n1 basename | sed 's/EngramEntry_//' | sed 's/.uasset/_C/' > outputfile
```
> Forge_C
