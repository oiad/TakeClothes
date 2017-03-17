# TakeClothes
Zabns TakeClothes script updated for 1.0.6.1 by salival

	Discussion thread: https://epochmod.com/forum/topic/43076-zabns-take-clothes-updated-for-epoch-106/

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
	
6) Find these lines in fn_selfActions.sqf (around line 1160):

	player removeAction s_player_fuelauto;
	s_player_fuelauto = -1;
	player removeAction s_player_fuelauto2;
	s_player_fuelauto2 = -1;
	player removeAction s_player_manageDoor;
	s_player_manageDoor = -1;

Add these lines after it:

	// Take Clothes by Zabn
	player removeAction s_player_clothes;
	s_player_clothes = -1;

7) Find these lines in fn_selfActions.sqf (around line 926):

	} else {
		player removeAction s_player_fillgen;
		s_player_fillgen = -1;
	};
	
Add these lines after it:

	_clothesTaken = _cursorTarget getVariable["clothesTaken",false];
	_isZombie = _cursorTarget isKindOf "zZombie_base"; // Add this here now since epoch 1.0.6 doesn't initialize this where this will go.

	// Take clothes by Zabn
	if (_isMan and !_isAlive and !_isZombie and !_clothesTaken) then {
		if (s_player_clothes < 0) then {
			s_player_clothes = player addAction [format["<t color='#0096ff'>Take Clothes</t>"], "scripts\takeClothes.sqf",_cursorTarget,0, false,true];
		};
	} else {
		player removeAction s_player_clothes;
		s_player_clothes = -1;
	};
		
8) OPTIONAL: to remove certain skins from being removable, add this:

	case "EXAMPLE_SKIN": {
		_itemNew = "disabled";
	};

(obviously replace the EXAMPLE_SKIN with the classname of the skin)

under this:

	case "Bandit1_DZ": {
		_itemNew = "Survivor2_DZ";
	};

9) You're done! enjoy the new script! :)

Credits - Zabn, salival
