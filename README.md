# TakeClothes
Zabns TakeClothes script updated for 1.0.6.1 by salival

	Discussion thread: https://epochmod.com/forum/topic/43076-zabns-take-clothes-updated-for-epoch-106/

	(original install url: http://opendayz.net/threads/release-zabns-take-clothes-2-0.19290/)
	(original discussion url: http://opendayz.net/threads/help-discussion-zabns-take-clothes.13198/)

# REPORTING ERRORS/PROBLEMS

1. Please, if you report issues can you please attach (on pastebin or similar) your CLIENT rpt log file as this helps find out the errors very quickly. To find this logfile:

	```sqf
	C:\users\<YOUR WINDOWS USERNAME>\AppData\Local\Arma 2 OA\ArmA2OA.RPT
	```

**[>> Download <<](https://github.com/oiad/TakeClothes/archive/master.zip)**
	
# Installation Steps:

1) Extract your mission PBO and open the extracted folder.

2) Copy the scripts folder over to the root of your extracted mission PBO or if you have an existing scripts folder, copy the takeClothes.sqf file into it.

3) If you don't already have an existing dayz_code folder in your mission folder, copy the one over from the download. If you already have it, then copy the files over to the appropriate directories listed below.
   If the files already exist from prior mods, proceed to step 4 or use diffmerge to merge the code into your existing files.
	
	```sqf
	dayz_code\compile\fn_selfActions.sqf
	dayz_code\init\compiles.sqf
	dayz_code\init\variables.sqf
	```

# compiles.sqf:
	
4) If you already have an existing compiles.sqf then find this line

	```sqf
	if (!isDedicated) then {
	```
	
	and add directly below:

	```sqf
	fnc_usec_selfactions = compile preprocessFileLineNumbers "dayz_code\compile\fn_selfActions.sqf";
	```

Otherwise merge the code from the downloaded file.

# variables.sqf:

5) If you already have an existing variables.sqf with a dayz_resetSelfActions section:

    Find this line:

	```sqf
	s_player_manageDoor = -1;
	```
	
	and add directly below:

	```sqf
	s_player_clothes = -1; // Zabns take clothes
	```

Otherwise merge the code from the downloaded file.

# fn_selfActions.sqf:

6) If you already have a fn_selfActions.sqf

    Find these lines
	
	```sqf
	player removeAction s_player_fuelauto;
	s_player_fuelauto = -1;
	player removeAction s_player_fuelauto2;
	s_player_fuelauto2 = -1;
	player removeAction s_player_manageDoor;
	s_player_manageDoor = -1;
	```

	and add directly below:

	```sqf
	// Take Clothes by Zabn
	player removeAction s_player_clothes;
	s_player_clothes = -1;
	```

7)  Find these lines
	
	```sqf
	} else {
		player removeAction s_player_fillgen;
		s_player_fillgen = -1;
	};
	```
	
	and add directly below:

	```sqf
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
	```

8) OPTIONAL: to remove certain skins from being removable, add this:

	```sqf
	case "EXAMPLE_SKIN": {
		_itemNew = "disabled";
	};
	```

(obviously replace the EXAMPLE_SKIN with the classname of the skin)

	under this:

	```sqf
	case "Bandit1_DZ": {
		_itemNew = "Survivor2_DZ";
	};
	```
	
# init.sqf:

9)  Find this line
	
	```sqf
	call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\variables.sqf";
	```
	
	and add directly below:

	```sqf
	call compile preprocessFileLineNumbers "dayz_code\init\variables.sqf";
	```
	
10) Find this line
	
	```sqf
	call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\compiles.sqf";
	```
	
	and add directly below:

	```sqf
	call compile preprocessFileLineNumbers "dayz_code\init\compiles.sqf";
	```

11) You're done! enjoy the new script! :)

Credits - Zabn, salival
