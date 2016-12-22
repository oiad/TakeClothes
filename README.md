# TakeClothes
Zabns TakeClothes script updated for 1.0.6

Installation Steps -

1) in your \dayzinstallfolder\MPMissions\dayz_1.Chernarus folder, create a subfolder called "scripts" or use another name if a folder with other add-on scripts exists.

2) place the file that you've downloaded below into the "scripts" folder

3) now you must create a new fn_selfActions.sqf (you can get this file by opening up your dayz_code.pbo and grabbing it out of your compile folder) to the new "scripts" folder if you dont already have one in there... if you don't make sure to add this line of code:

init.sqf:
Code:
fnc_usec_selfActions = compile preprocessFileLineNumbers "scripts\fn_selfActions.sqf";
just after this code:


init.sqf:
Code:
call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\compiles.sqf";
progressLoadingScreen 1.0;
4) find this code:

	player removeAction s_player_manageDoor;
	s_player_manageDoor = -1;

add these lines after it:

    // Take Clothes by Zabn
        player removeAction s_player_clothes;
      s_player_clothes = -1;

5) Find these lines in fn_selfActions:

	} else {
		player removeAction s_player_fillgen;
		s_player_fillgen = -1;
	};
Add these lines after:

	_clothesTaken = _cursorTarget getVariable["clothesTaken",false];
	_isZombie = _cursorTarget isKindOf "zZombie_base"; // Add this here now since epoch 1.0.6 doesn't initialize this where this will go.

	// Take clothes by Zabn
	if (_isMan and !_isAlive and !_isZombie and !_clothesTaken) then {
		if (s_player_clothes < 0) then {
			s_player_clothes = player addAction [("<t color='#0096ff'>")+("Take Clothes")+("</t>"), "scripts\player_takeClothes_v2.sqf",_cursorTarget, -10, false, true];
		};
	} else {
		player removeAction s_player_clothes;
		s_player_clothes = -1;
		
6) If you don't have a custom variables.sqf you need to make one. You can get it from the dayz_code\init folder by extracting it just like you did the fn_selfActions.sqf file.
If you already have a variables.sqf or you have copied over the default epoch one:

Find this line:
	s_player_manageDoor = -1;
	
Add this after it:
	s_player_clothes = -1; // Zabns take clothes

7) Battleye filters: open your setvariable.txt and at line 1 add to the end of the line this:

Code:
!="clothesTaken"
8) OPTIONAL: to remove certain skins from being removable, add this:
Code:
case "<SKIN CLASSNAME>": {
    _itemNew = "disabled";
};
(obviously replace the <SKIN CLASSNAME> with the classname of the skin)

under this

Code:
case "Bandit1_DZ": {
    _itemNew = "Survivor2_DZ";
};
9) You're done! enjoy the new script! :)

Credits - Zabn