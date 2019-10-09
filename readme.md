# Sid Meier's Alpha Centauri & Alien Crossfire Unofficial Patch

Author: scient ([Brendan Casey](https://github.com/b-casey))

[Donate to Brendan!](https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=bcasey85%40gmail.com&item_name=Brendan+Casey&currency_code=USD&source=url)

## Introduction

[This is mostly Brendan's readme from 2014. Links to CGN and Apolyton
are broken now, but I've left them as they were.]

This is a comprehensive set of fixes to bugs, crashes, and exploits
found in Sid Meier\'s Alpha Centauri (SMAC) and Alien Crossfire (SMACX).
The primary goal of this project is to fix bugs left after the official
patches. A secondary objective is to expand upon the games features
without modifying the existing mechanics to allow for more freedom.

Feel free to host the installer somewhere else besides
[AC2](http://alphacentauri2.info/index.php?action=downloads),
[CGN](http://www.civgaming.net/forums/forumdisplay.php?f=15),
[WPC](http://www.weplayciv.com/forums/downloads.php?do=cat&id=1) or
[Apoly](http://apolyton.net/local_links.php?catid=399) as long as the
contents of package aren\'t altered in any way and the readme is
included.

I am busy with multiple commitments so updates come whenever I have
time. One of those commitments is my work on another unofficial patch
project for the classic isometric RPG [Planescape:
Torment](http://spellholdstudios.net/ie/pst-fixpack). However, this
project has mostly concluded.

I have no problem with other modders building off of my work as long as
credit is given. If you\'re interested in helping out in any capacity
please contact me. I would like to add fixed versions of the localized
text files to the installer, so if you\'re interested in working with me
to update the French, German or some other language let me know!

I encourage you to report any bugs, crashes, exploits or just ideas on
either [AC2](http://alphacentauri2.info/index.php) or
[CGN](http://www.civgaming.net/forums/forumdisplay.php?f=15) forums
which are the two primary homes of this project. You can also contact me
on [WPC](http://www.weplayciv.com/forums/forumdisplay.php?f=7),
[Apolyton](http://apolyton.net/forums/forumdisplay.php?f=23),
[CFC](http://forums.civfanatics.com/forumdisplay.php?f=27) or
[SHS](http://www.shsforums.net/index.php?showforum=551) forums as well.

While my work on this project will go on regardless, if you enjoyed this
patch please donate a few dollars via PayPal link at the top.

## Installation

-   **Install the game (original individual CD\'s, Planetary Pack, SOS,
    GOG).**
-   **Next install the unofficial patch.**
-   **Done!**

**Notes regarding the installer:**

-   While always applying the SMAC base files, the SMACX specific files
    will only be applied if SMACX has been installed.
-   All of the official patches have been rolled into the installer. So
    once applied, you are getting the same effect as if you installed
    the SMAC 2000/XP Compatibility Update and if applicable SMACX v2.0
    patch.
-   Any files touched by the installer will be backed up to a new folder
    inside SMAC/X directory. Also, an uninstaller is created that will
    allow you to roll back any changes made.
-   The installer can be applied to multiple SMAC/X installs on the same
    system without any conflicts. There are no issues with applying the
    installer to a portable install. However, there are a few minor
    fixes related to the registry and system font that will only be in
    effect on a system where the installer was run.

## Engine Fixes

### Version 1.0

1.  **\[CRASH\]\[SMACX\]** As either the Caretakers or the Usurpers,
    opening up the Design Workshop and then switching back and forth
    between a \"Colony Pod\" and other \"Equipment\" can cause the text
    in the \"Special Ability\" panel to become corrupted and crash the
    game upon exiting the Design Workshop. Fixed by increasing the
    memory allocation used to manipulate the caviar animation files
    (cvr) and possibly other buffer related problems. (credit to
    WBird784 for original fix)
2.  **\[CRASH\]** Scrambling air interceptors could cause the game to
    crash usually on larger maps. Even when the game didn\'t crash, it
    would use incorrect altitude values.
3.  **\[CRASH\]** While moving units around near or at the poles, it is
    possible for the y coordinate to exceed the map bounds and crash the
    game. Add handling to prevent the y coordinate from ever going over
    the World Maps minimum or maximum values.
4.  **\[CRASH\]\[MISC\]** Optimized out a number of legacy CPU checks
    that serve no purpose unless you\'re using an extremely old
    computer. In some cases, these checks actually prevented the game
    from starting on newer CPU\'s causing the game to crash. After
    removing these old checks, enabling ForceOldVoxelAlgorithm is no
    longer necessary. Disabling it may improve performance since setting
    ForceOldVoxelAlgorithm to 0 enables SMAC/SMACX to use your CPU\'s
    [MMX
    capabilities](http://en.wikipedia.org/wiki/MMX_(instruction_set))
    for the [voxel algorithm](http://en.wikipedia.org/wiki/Voxel).
5.  **\[BUG\]\[SMACX\]** The transport unit\'s special ability \"Repair
    Bay\" is rendered useless due to an incorrect check that would only
    give the healing bonus to ground transports inside a transport. Now,
    it will give the bonus to all ground units except ground transports.
6.  **\[BUG\]\[SMACX\]** Enhanced probes are now able to mind control
    bases or units normally immune due to high SE morale as stated in
    SMACX manual. For units it\'s purely the morale SE value so \>=3
    acts as if it were 2 (cost doubled). For bases, the value is
    calculated from morale SE and any base facility modifiers (Covert
    Ops: +2, Genejack: -1). If final value is \>=3, it acts as if it
    were 2.
7.  **\[BUG\]\[SMACX\]** While loading the ambient sound file for game,
    there is a mistake in faction id check for Believers causing it to
    use SMACX default of \"aset1.amb\" rather than their correct ambient
    sound file \"bset1.amb\".
8.  **\[BUG\]\[SMACX\]** Enhanced probes don\'t receive a penalty to
    survival probability when target faction has built Hunter-Seeker
    Algorithm. Instead, the success probability is erroneously given the
    penalty for a second time after it has already been displayed in UI.
    This could cause diminished success rate when it should have been
    higher. Fix corrects check so survival rather than success
    probability is modified.
9.  **\[BUG\]\[SMACX\]** Sealurk units will now not get a movement
    penalty when moving through Sea Fungus the same as \"Isle of the
    Deep\".
10. **\[BUG\]** If a faction\'s cumulative PROBE value is greater than
    three (SE morale, covert ops center) it is possible to \"mind
    control\" their bases when they should be immune. If the University
    uses SE Knowledge putting PROBE value down to -4, it would act as if
    it were 0 erroneously increasing \"mind control\" costs. After
    patch, PROBE values greater than 3 will always be immune to regular
    probes and values less than -2 will be treated as if they were -2.
11. **\[BUG\]** Fixed a check that was ending the turn for certain air
    units (choppers/missiles/grav) when entering a base that had no
    adjacent enemy units. The unit\'s turn will now only end if when
    entering a base it has less then one turn remaining with no enemy
    units adjacent to the base.
12. **\[BUG\]** Using \"Go to home base\" command (shift-g) sends the
    unit to closest base rather than it\'s actual home. Fixed so now the
    game retrieves the unit\'s home base and sets a \"go to\" waypoint
    similar to how a unit is recalled from within the base UI. If a home
    base cannot be found say if the unit is independent then the unit
    will go to the nearest base.
13. **\[BUG\]\[EXPLOIT\]** Setting more than one patrol waypoint for a
    unit with the spacebar causes the coordinate values to be stored
    incorrectly. If only two waypoints are set then it is just a display
    issue showing an incorrect amount of waypoints when the unit is
    clicked. However, if three waypoints are set, it causes the unit\'s
    morale to be set as one of coordinates usually boosting it to elite
    or demon boil status. Also, when three waypoints are set the final
    waypoint would get set to some far off random location usually
    (0,0).
14. **\[EXPLOIT\]** Using the right click menu to airdrop a unit moves
    the unit instantly and bypasses all of the required condition checks
    such as if unit has already moved or in a base or an airbase. Fixed
    so airdropping via right click now goes through same condition
    checks as if you used the hotkey \"I\".
15. **\[EXPLOIT\]** Inside the base UI, after opening up the production
    queue window it is possible to then open the hurry command window,
    switch between bases and complete projects for less then their
    actual value. An issue with the queue panel is now fixed preventing
    certain parts of UI from becoming clickable when they shouldn\'t.
16. **\[EXPLOIT\]** When clicking on an unexplored square, the map
    should recenter on that square. However, if the square contains a
    base the map doesn\'t recenter giving away hidden bases. Fixed so
    when an unexplored square with a base is clicked, the game will
    recenter like any other square.
17. **\[EXPLOIT\]** It is possible to change another faction\'s workers
    via \"Base Ops\" (F4) if you have that faction infiltrated. It is
    now fixed so clicking the citizens of another faction in \"Base
    Ops\" has no effect similar to garrisoned units.
18. **\[EXPLOIT\]** It is possible to give the airdrop or artillery
    ability to a unit who didn\'t already have it. This is done by using
    hotkey (I or F) on a unit that has the ability then switching to a
    different unit in bottom center window. The mouse cursor would still
    have the airdrop or artillery action ready to go and it is then
    possible to use it with the new unit bypassing any checks whether
    this unit can use the ability. Fixed by resetting the cursor when
    clicking the unit selection window.
19. **\[MOD\]** Squares with both a Borehole and nutrient bonus don\'t
    receive the nutrient bonus. If the \"Borehole Square\" nutrient
    value defined in alpha/x.txt under \#RESOURCEINFO is set to
    non-zero, a square with a Borehole will erroneously act as if it has
    a nutrient bonus. The check whether or not to give a \"Borehole
    Square\" a nutrient bonus is now fixed from checking if borehole
    nutrient value is non-zero to checking if nutrient bonus is actually
    present in the square.
20. **\[MOD\]** Fixed a check to use the \"Max artillery range\" value
    defined under \#RULES rather than a hardcoded value of 2. It is
    already set to 2 by default in alpha/x.txt.
21. ~~**\[MOD\]** Increase maximum number of all units on a map from
    2048 to over 2 billion (2147483647). Also, increase value when
    native life stops spawning due to number of units on map from 1792
    to 2147483391 (same difference of 256 between original values).~~
    **NOTE:** Removed as of v2.00 due to problems with fix.
22. **\[UI\]** Removed a check when displaying probe success and
    survival probabilities that would drop the display of one if
    they\'re both the same. For example, (50%, 50%) would just be (50%).
    This change makes the interface a little less confusing.

### Version 2.0:

1.  **\[BUG\]\[MISC\]** On launch of the game, fixed a registry check
    that could cause an error message to be incorrectly displayed
    regarding a \"Complete Install\" not being performed. This was due
    to permission issues relating to UAC (Vista, Win7, Win8).
2.  **\[BUG\]\[EXPLOIT\]** Units without the \"Amphibious Pods\" ability
    can no longer move to a land square from a ocean base without there
    being a transport in either the land square or the ocean base. The
    previous buggy behavior would allow the unit in the ocean base to
    move to the land square as long as there was any existing unit in
    that square.
3.  **\[BUG\]\[SMACX\]** Prevent the Caretakers from being given the
    oppertunity to build the Secret Project \"Ascent to Transcendence\"
    which goes against their philosophy. If completed, they would
    declare war on themselves and get a Transcendence victory.
4.  **\[BUG\]\[MOD\]** You can now evict probes from squares that have
    more than one probe or other units in the stack as long as the probe
    is the top most unit. When evicting, only the top most probe is sent
    back to its own faction\'s territory.
5.  **\[BUG\]\[SMACX\]** After the AI successfully completes the probe
    action of freeing a captured faction leader, it would instead reset
    a non-captured faction. The problem was that AI would always try to
    free the first faction, usually being the PC, regardless of whether
    this faction was eliminated or not. Now it will obtain all the
    potential captured faction leaders and free one randomly.
6.  **\[BUG\]\[MOD\]\[SMACX\]** Add references for the use of a new file
    \"movlistx.txt\" to allow for expansion specific information text to
    be displayed after a Secret Project movie has been played.
7.  **\[MOD\]** The \"Nessus Canyon\" landmark is now placed when
    generating random maps.
8.  **\[BUG\]** The \"attacking along road\" combat bonus is now
    correctly applied for combat taking place on roads or magtubes. It
    is set to 0 by default in alpha/x.txt.
9.  **\[MOD\]** There are a number of unused pcx image files in relation
    to the random script event near a base of whether new resources are
    discovered or existing ones are depleted. The game will now display
    one of twelve images depending on the square (land, ocean) and
    resource type (minerals, energy, nutrients) instead of showing a
    general warning image for every event.
10. **\[MOD\]** As part of the Datalinks, add the ability to set
    individual entries for armor and reactors (help/x.txt) as well as
    enable the display of the \"Sea Formers\" unit.
11. **\[BUG\]** Fixed a bug where a \"Planet Buster\" (PB) could
    detonate after being initially shot down. Each faction has one
    chance to defend against an incoming PB if they have bases or units
    in the blast radius. However, there is a check to give the owner of
    the ground zero square a chance to defend against the PB even if
    they have no units or bases in this territory. This check didn\'t
    take into account whether or not the PB had already been shot down
    by another faction.
12. **\[BUG\]\[SMACX\]** When another faction detonates a \"Fungal
    Missile\" near one of your bases, sometimes a script message would
    use an incorrect faction name as part of the text.
13. **\[BUG\]\[MOD\]\[SMACX\]** When detonated in or near ocean squares,
    \"Fungal Missiles\" could spawn \"Mind Worms\" or a \"Fungal Tower\"
    in those ocean squares that would then die instantly after the end
    of turn. Now, a native sea unit will spawn in their place like an
    \"Isle of the Deep\" or a \"Sealurk\".
14. **\[BUG\]** Fixed an erroneous message that the use of nerve gas
    caused massive casualties at a base even when the attack failed.
15. **\[MOD\]** Added the ability to set the reactor type (1-4) for
    \#UNITS inside the alpha/x.txt. To do so, just add a comma after the
    Abil field with the value of the reactor you want for the unit. As
    an example, \"Colony Pod,\..., 00000000000000000000000000,4\" will
    give all \"Colony Pods\" a Singularity Engine. If no value is set,
    it defaults to \"1\" like original code. For SMACX only, there are
    two exceptions for \"Battle Ogre MK2\" and \"Battle Ogre MK3\" where
    default isn\'t \"1\" but \"2\" and \"3\" respectively. You can still
    override the Ogres default.
16. **\[BUG\]** \"Colony Pods\" or \"Sea Colony Pods\" can now be added
    to existing bases where fungus has spread to the base\'s square.
    Also, ignore restrictions regarding land or ocean squares when
    adding pods to existing bases.
17. **\[BUG\]** Due to an incorrect check, a message would fail to
    display telling you that a transport with no units has nothing to
    disembark when moved into a non-base land square.
18. **~~\[BUG\]~~** ~~Changing start date for Perihelion event to be
    2160 from 2190. This is to be consistent with info about Planet and
    cycle from readme regarding 80 year cycles (20 years near, 60 years
    far).~~
19. **\[CRASH\]** Under extremely rare circumstances, the game would
    crash when an AI faction with no bases attempted to upgrade a unit.
20. **\[BUG\]** Abandoning a base after building a \"Colony Pod\" no
    longer skips the base production of the next base in line. This was
    caused by the upkeep function using incorrect base values after the
    abandoned base was destroyed.
21. **\[BUG\]** Non-amphibious units can now move from a transport into
    Pact sea base since movement to and from Pact bases should be
    identical to your own.
22. **\[BUG\]\[SMACX\]** Interludes \#6 and \#7 would display incorrect
    string values specific to either the Caretakers or Usurpers for
    non-Progenitor factions.
23. **\[BUG\]** Interlude \#6 would sometimes be triggered by native
    life forms causing issues with the display strings and not making
    sense. This interlude (and its follow up \#7) are designed only for
    actual rival factions.
24. **\[BUG\]** Fixed the rendering of the menu when using the scenario
    editor to change the faction id of the former owner of a base.
28. **\[BUG\]** Fixed the parsing of the \"Retool strictness\" value in
    alpha/x.txt so \"Never Free\" works correctly. This would only apply
    if you wanted to give a retooling penalty when switching to \"Secret
    Projects\".
29. **\[BUG\]\[MOD\]** Factions with the FREEPROTO flag (Spartans) will
    gain free retooling in their bases as long as the production switch
    is within the same category (unit to unit, base facility to base
    facility) and they\'ve discovered the necessary tech (\"Advanced
    Subatomic Theory\"). This is to resolve the issue with FREEPROTO
    factions never being able to gain the undocumented retooling ability
    of \"Skunkworks\" when it is fairly clear that they should.
30. **\[EXPLOIT\]** Using the right click \"Save current list to
    template\" and \"Load template into list\" features of base queue
    can be used to bypass retooling completely. Fixed so these queue
    template features only save and load the actual queue and not affect
    the item currently in production.
31. **\[BUG\]** When drilling an aquifer, there isn\'t a check whether a
    river already exists in the initial square. Now, it checks the the
    initial square as well as the eight square around it.
32. **\[BUG\]** Fixed an issue where diplomacy dialog could be
    incorrectly displayed due to faction id value being set incorrectly.
    This best exhibited where Progenitors switch into \"Human\" dialog
    syntax.

[This list originally contained three more entries that were actually removed prior to public release. These are now below.]

25. **\[BUG\]** Fixed the CC/BP combat bonus bug.
26. **\[BUG\]\[EXPLOIT\]** Fixed the AI base trading exploit. (credit to
    kyrub)
27. **\[EXPLOIT\]** Fixed the energy stockpile exploit. (credit to
    kyrub)

## Non-Engine Fixes

1.  **\[BUG\]\[MOD\]** Overhaul of all text files correcting spelling,
    grammar and various formatting issues by Guv\'ner. See his projects
    readme for more details since the changes are too numerous to be
    mentioned beyond the highlighted bug fixes below. Also, as part of
    this an update fork of GooglyBoogly\'s Datalinks v1.3 is included
    for SMACX.
    -   **\[BUG\]** Enabled the \"Antigrav Struts\" special ability for
        air units as stated in the manual. (alpha/x.txt)
    -   **\[BUG\]** Disabled the \"Clean Reactor\" special ability for
        Probe Teams because they already don\'t require any support.
        (alpha/x.txt)
    -   **\[BUG\]** Amended base seizure notifications that would
        display incorrect plurality for the faction losing the base.
        (scripts.txt)
2.  **\[BUG\]** Needlejet \"DATA\" edit window via scenario editor
    wouldn\'t render properly making it so you couldn\'t edit the stats.
    (scripts.txt)
3.  **\[BUG\]** When attempting to build a sea base inside another
    faction\'s territorial waters, you were suppose to receive warning
    messages that were mislabeled. (scripts.txt)
4.  **\[BUG\]** Added a new entry that was missing when you attempted to
    use \"B\" or \"b\" shortcuts with a non-combat unit that didn\'t
    have a \"Colony Pod\". (scripts.txt)
5.  **\[BUG\]** Added new entries that were missing in conjunction with
    an engine fix for when \"retool strictness\" in alpha/x.txt is set
    to \"never free\". (scripts.txt)
6.  **\[BUG\]\[SMACX\]** When attempting to terraform an ocean square
    other than shelf, aquatic factions (Nautilus Pirates) were suppose
    to receive a warning message that was mislabeled. (scripts.txt)
7.  **\[BUG\]** Fixed the display of the base facility quotes inside the
    Datalinks caused by incorrect ids. Added the missing quotes for
    SMACX specific facilities transcribed from their audio clips.
    (blurbs/x.txt)
8.  **\[BUG\]\[SMACX\]** Fixed the display of an image used for Fungal
    payloads script events by renaming fungalpayld\_sm.pcx.
9.  **\[BUG\]\[SMACX\]** Fixed the display of an image used for script
    events when Progenitor factions capture a human base by renaming
    humref\_sm.pcx.
10. **\[BUG\]\[SMACX\]** Fixed the display of an image used for Spore
    Launcher script events by renaming sporelnch\_sm.pcx.
11. **\[BUG\]\[INSTALLER\]** Create a registry entry that is usually
    missing to suppress the \"CDNOTFOUND\" warning message on launch.
12. **\[BUG\]\[INSTALLER\]** Register the SMAC \"Alpha Centauri\" font
    with Windows so the game credits are displayed correctly.
13. **\[MOD\]** Add new versions of Arial font to SMAC directory that
    will be more compatible with more recent monitors. If you notice
    graphical issues with the in game text, revert back to original font
    found inside backup directory.
14. **\[BUG\]** Add netcr\_sm.pcx that was missing for a script event
    when a Network Node crashes. The image was taken from the Planetary
    Pack\'s Alternative Art folder with scan lines added by BU.
15. **\[BUG\]** Add rdminldp\_sm.pcx that was missing for a script event
    regarding minerals being depleted in conjunction with an engine fix.
    The image was taken from the Planetary Pack\'s Alternative Art
    folder with scan lines added by BU.
16. **\[BUG\]** Fixed an audio clip for when Network Node is already
    linked from repeating itself by adding fractional amount of silence
    to end of clip.
17. **\[BUG\]** Fixed an audio clip not playing when Missile Launcher
    weapons are used by remixing from stereo to mono (edited by chuft).
18. **\[BUG\]** Fixed an audio clip not playing when Singularity Laser
    weapons are used by remixing from stereo to mono (edited by chuft).


## More SMACX!

You may also be interested in:

- [The Alphacentauri2.info Wiki][ac2wiki]
- [The Alphacentauri2.info Forum][ac2forum]
- [Plotinus Redux's PRACX UI mod][pracx]
- [Thinker][thinker]
- [Yitzi's patch][yitzi]
- [bvanery's SMACX AI Growth mod][aigrowthmod]
- [The SMAC in SMAX project][smac-in-smax]

[ac2wiki]: http://alphacentauri2.info/wiki/
[ac2forum]: http://alphacentauri2.info/index.php?action=community
[pracx]: https://github.com/drazharln/pracx
[scient]: https://github.com/drazharln/scient-unofficial-smacx-patch
[thinker]: https://github.com/induktio/thinker
[yitzi]: http://alphacentauri2.info/wiki/Yitzi%27s_patch
[aigrowthmod]: http://alphacentauri2.info/index.php?topic=20959.0
[smac-in-smax]: https://github.com/drazharln/smac-in-smax


## Credits

So far beyond a few, all of the patches to the exe are done by myself (@b-casey).
Thanks goes out to WBird784 for his crash fix and kyrub for his two
fixes. A special thanks goes out to Guv\'ner for his overhaul of all the
text files. I\'d like to thank a few people for their work behind the
scenes. First off, a big thank you should go out to vyeh for the work
he\'s done in overseeing the administrative aspects of project. He has
definitely helped motivate me by keeping in contact and setting up
community at
[CGN](http://www.civgaming.net/forums/forumdisplay.php?f=15) for this
project. Another big thank you goes to buster (the owner of
[CGN](http://www.civgaming.net/forums/forumdisplay.php?f=15)) for
providing dedicated forums for project and being willing to host the
unofficial patch. chuft for helping moderate and organize project forums
on [CGN](http://www.civgaming.net/forums/forumdisplay.php?f=15). Darsnan
for making playtest scenarios used in testing of fixed game mechanics.
GooglyBoogly for his Datalinks update and comprehensive testing of patch
changes. BlackCat, BU, ete, Flygon, Googlie, Illuminatus, Kilkakon, Lord
Avalon, Mart, Nevill, Petek, Psyringe, Rubin, [AC2
forums](http://alphacentauri2.info/index.php), [WPC
forums](http://www.weplayciv.com/forums/forumdisplay.php?f=7) and anyone
else who has reported bugs, given feedback and support to this project.
Qwinn for letting me use the html shell of his readme. And of course to
the developers of SMAC and SMACX for making two great games that are
still being played even to this day!
