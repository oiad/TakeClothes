# TakeClothes
Zabns TakeClothes script updated for 1.0.7 by Airwaves Man

	Discussion thread: https://epochmod.com/forum/topic/43076-zabns-take-clothes-updated-for-epoch-106/

	(original install url: http://opendayz.net/threads/release-zabns-take-clothes-2-0.19290/)
	(original discussion url: http://opendayz.net/threads/help-discussion-zabns-take-clothes.13198/)

# REPORTING ERRORS/PROBLEMS

1. Please, if you report issues can you please attach (on pastebin or similar) your CLIENT rpt log file as this helps find out the errors very quickly. To find this logfile:

	```sqf
	C:\users\<YOUR WINDOWS USERNAME>\AppData\Local\Arma 2 OA\ArmA2OA.RPT
	```

**[>> Download <<](https://github.com/oiad/TakeClothes/archive/master.zip)**

# Install:

* This install basically assumes you have a custom variables.sqf, compiles.sqf and fn_selfActions.sqf.
	
# Mission folder install:

1. 	Open your fn_selfactions.sqf and search for:

	```sqf
	// ZSC
	if (Z_singleCurrency) then {
	```

	Add this code lines above:
	
	```sqf	
	if (_isMan && !_isAlive && !_isZombie && {!(_cursorTarget isKindOf "Animal")} && {!(_cursorTarget getVariable["clothesTaken",false])}) then {
		if (s_player_clothes < 0) then {
			s_player_clothes = player addAction [format["<t color='#0059FF'>%1</t>",localize "STR_CL_TC_TAKE_CLOTHES"],"scripts\takeClothes.sqf",_cursorTarget,0, false,true];
		};
	} else {
		player removeAction s_player_clothes;
		s_player_clothes = -1;
	};
	```	
2. In fn_selfactions search for this codeblock:

	```sqf
	player removeAction s_bank_dialog3;
	s_bank_dialog3 = -1;
	player removeAction s_player_checkWallet;
	s_player_checkWallet = -1;	
	```	
	And add this below:
	
	```sqf
	player removeAction s_player_clothes;
	s_player_clothes = -1;	
	```
3. Open your variables.sqf and search for:

	```sqf
	s_bank_dialog3 = -1;
	s_player_checkWallet = -1;	
	```
	And add this below:
	
	```sqf
	s_player_clothes = -1;	
	```	

8) OPTIONAL: to remove certain skins from being removable, add this:

	```sqf
	case "EXAMPLE_SKIN": {
		_itemNew = "disabled";
	};
	```

   (obviously replace the EXAMPLE_SKIN with the classname of the skin)

   directly below:

	```sqf
	case "Bandit1_DZ": {
		_itemNew = "Survivor2_DZ";
	};
	```
	
# Battleye Script.txt filter:

1. In your config\<yourServerName>\Battleye\scripts.txt around line 53: <code>1 nearEntities</code> add this to the end of it:

	```sqf
	!="ayerNear = {isPlayer _x} count (([_body] call FNC_GetPos) nearEntities [\"CAManBase\", 10]) > 1;\nif (_playerNear) exitWith {dayz_a"
	```

	So it will then look like this for example:

	```sqf
	1 nearEntities <CUT> !="ayerNear = {isPlayer _x} count (([_body] call FNC_GetPos) nearEntities [\"CAManBase\", 10]) > 1;\nif (_playerNear) exitWith {dayz_a"
	```	

Credits - Zabn, salival, Airwaves Man

**** *For Epoch 1.0.6.2 only* ****
**[>> Download <<](https://github.com/oiad/TakeClothes/archive/refs/tags/Epoch_1.0.6.2.zip)**

Visit this link: https://github.com/oiad/TakeClothes/tree/Epoch_1.0.6.2	
