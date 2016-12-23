// Originally by Zabn 2014
// Modified for DayZ Epoch 1.0.6 by salival

private ["_animState","_body","_clothesTaken","_finished","_isMedic","_itemNew","_itemNewName","_okSkin","_result","_skin","_started","_takeClothesUsageTime"];

if (dayz_actionInProgress) exitWith {};
dayz_actionInProgress = true;

_body = _this select 3;

player removeAction s_player_clothes;
s_player_clothes = -1;

_skin = (typeOf _body);

_itemNew = _skin;

switch (_itemNew) do {
	case "Survivor3_DZ": {
		_itemNew = "Survivor2_DZ";
	};
	case "Bandit1_DZ": {
		_itemNew = "Survivor2_DZ";
	};
};

_itemNew = "Skin_" + _itemNew;
_okSkin = isClass (configFile >> "CfgMagazines" >> _itemNew);

r_interrupt = false; 
r_doLoop = true; 
_takeClothesUsageTime = time;
_animState = animationState player;
_started = false;
_finished = false;

if (_okSkin) then {
	_clothesTaken = _body getVariable["clothesTaken",false];
	if (!_clothesTaken) then {
		while {r_doLoop} do {
			_clothesTaken = _body getVariable["clothesTaken",false];
			_animState = animationState player;
			_isMedic = ["medic",_animState] call fnc_inString;
			if (_clothesTaken) then { r_doLoop = false; };
			if (_isMedic) then { _started = true; };
			if(!_isMedic && !r_interrupt && (time - _takeClothesUsageTime) < 6) then {
				player playActionNow "Medic"; 
				_isMedic = true;
			};
			if (_started && !_isMedic && (time - _takeClothesUsageTime) > 6) then {
				r_doLoop = false; 
				_finished = true;
			};
			if (r_interrupt) then { r_doLoop = false; };
			uiSleep 0.1;
		};
		r_doLoop = false; 

		if (_finished) then {
			_itemNewName = getText (configFile >> "CfgMagazines" >> _itemNew >> "displayName");
			_result = [player,_itemNew] call BIS_fnc_invAdd;
			if (_result) then {
				_body setVariable["clothesTaken",true,true];
				format["One %1 has been added to your inventory!",_itemNewName] call dayz_rollingMessages;
			} else {
				format["You didn't have enough room to store a %1 :(",_itemNewName] call dayz_rollingMessages;
			};
		} else {
			if (_clothesTaken) then { 
				player switchMove "";
				player playActionNow "stop";
				"This Skin has already been taken!" call dayz_rollingMessages;
			} else {
				r_interrupt = false;
				player switchMove "";
				player playActionNow "stop";
				"You have interrupted taking clothes!" call dayz_rollingMessages;
			};
		};
	} else {
		"This Skin has already been taken!" call dayz_rollingMessages;
	};
} else {
	format["Currently %1 is not supported by the take clothes script.",_skin] call dayz_rollingMessages;
};

dayz_actionInProgress = false;