# TakeClothes
Zabns TakeClothes script updated for 1.0.6 by salival

	(original install url: http://opendayz.net/threads/release-zabns-take-clothes-2-0.19290/)
	(original discussion url: http://opendayz.net/threads/help-discussion-zabns-take-clothes.13198/)

Installation Steps -

1) In your \dayzinstallfolder\MPMissions\dayz_1.Chernarus folder, create a subfolder called "scripts" or use another name if a folder with other add-on scripts exists.

2) Place the file that you've downloaded below into the "scripts" folder

3) If you don't already have your own fn_selfActions.sqf, compiles.sqf and variables.sqf you will need to extract them from the dayz_code.pbo file from 1.0.6 Epoch. My folder structure inside my mission directory looks like this:

	dayz_code\compile\fn_selfActions.sqf
	dayz_code\init\compiles.sqf
	dayz_code\init\variables.sqf

4) Edit your compiles.sqf and find the following code:

	fnc_usec_selfActions = compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\fn_selfActions.sqf";		//Checks which actions for self

Replace it with this line:

	fnc_usec_selfactions = compile preprocessFileLineNumbers "dayz_code\compile\fn_selfActions.sqf";

5) If you already have a variables.sqf or you have copied over the default epoch one:

Find this line in variables.sqf:

	s_player_manageDoor = -1;
	
Add this after it:

	s_player_clothes = -1; // Zabns take clothes
	
6) Find these lines in fn_selfActions.sqf:

	player removeAction s_player_manageDoor;
	s_player_manageDoor = -1;

Add these lines after it:

	// Take Clothes by Zabn
	player removeAction s_player_clothes;
	s_player_clothes = -1;

7) Find these lines in fn_selfActions.sqf:

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
			s_player_clothes = player addAction [("<t color='#0096ff'>")+("Take Clothes")+("</t>"), "scripts\takeClothes.sqf",_cursorTarget, -10, false, true];
		};
	} else {
		player removeAction s_player_clothes;
		s_player_clothes = -1;
		
8) Battleye filters: open your setvariable.txt and at line 1 add to the end of the line this:

	!="clothesTaken"

9) OPTIONAL: to remove certain skins from being removable, add this:

	case "<SKIN CLASSNAME>": {
		_itemNew = "disabled";
	};

(obviously replace the <SKIN CLASSNAME> with the classname of the skin)

under this:

	case "Bandit1_DZ": {
		_itemNew = "Survivor2_DZ";
	};

10) You're done! enjoy the new script! :)

Credits - Zabn, salival
