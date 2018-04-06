params ["_city","_area","_n"];

private _pos = getPos _city;
private _array = _city getVariable ["ieds", []];

private _active = true;

for "_i" from 1 to _n do {
    private _sel_pos = _pos;
    _sel_pos = [_pos, _area] call btc_fnc_randomize_pos;
    _sel_pos = [_sel_pos, 30, 150, 1, false] call btc_fnc_findsafepos;

    private _type_ied = selectRandom btc_model_ieds;

    private _dir = random 360;

    if (random 1 > 0.3) then {
        private _roads = _sel_pos nearRoads _area;
        if (count _roads > 0) then {
            private _obj = selectRandom _roads;
            if (random 1 > 0.5) then {
                _sel_pos = _obj modelToWorld [3.5, 0, 0];
            } else {
                _sel_pos = _obj modelToWorld [-3.5, 0, 0];
            };
        };
    } else {
        if (isOnRoad _sel_pos) then    {
            private _roads = _sel_pos nearRoads 15;
            if (count _roads > 0) then {
                private _obj = objNull;
                private _dist = 100;
                {
                    if (_x distance _sel_pos < _dist) then {
                        _dist = _x distance _sel_pos;
                        _obj = _x;
                    };
                } foreach _roads;

                if (isNull _obj) exitWith {};
                if (random 1 > 0.5) then {
                    _sel_pos = _obj modelToWorld [3.5, 0, 0];
                } else {
                    _sel_pos = _obj modelToWorld [-3.5, 0, 0];
                };
            };
        }
    };


    if (btc_debug) then {
        private _marker = createMarker [format ["btc_ied_%1", _sel_pos], _sel_pos];
        _marker setMarkerType "mil_warning";
        _marker setMarkerColor "ColorRed";
        _marker setMarkerText "IED";
        _marker setMarkerSize [0.8, 0.8];
    };

    if (btc_debug_log) then {diag_log format ["btc_fnc_ied_create_in_area: _this = %1 ; POS %2 ; N %3(%4)", _this, _sel_pos, _i, _n];};

    _array pushBack [_sel_pos, _type_ied, _dir, _active];
};

_active = false;

for "_i" from 1 to _n do {
    private _sel_pos = _pos;
    _sel_pos = [_pos, _area] call btc_fnc_randomize_pos;
    _sel_pos = [_sel_pos, 30, 150, 1, false] call btc_fnc_findsafepos;

    private _type_ied = selectRandom btc_model_ieds;

    private _dir = random 360;

    if (random 1 > 0.3) then {
        private _roads = _sel_pos nearRoads _area;
        if (count _roads > 0) then     {
            private _obj = selectRandom _roads;
            if (random 1 > 0.5) then {
                _sel_pos = _obj modelToWorld [3, 0, 0];
            } else {
                _sel_pos = _obj modelToWorld [-3, 0, 0];
            };
        };
    };


    if (btc_debug) then {
        private _marker = createMarker [format ["btc_ied_%1", _sel_pos], _sel_pos];
        _marker setMarkerType "mil_warning";
        _marker setMarkerColor "ColorBlue";
        _marker setMarkerText "IED (fake)";
        _marker setMarkerSize [0.8, 0.8];
    };

    if (btc_debug_log) then    {diag_log format ["btc_fnc_ied_create_in_area: _this = %1 ; POS %2 ; N %3(%4)", _this, _sel_pos, _i, _n];};

    _array pushBack [_sel_pos, _type_ied, _dir, _active];
};

_city setVariable ["ieds", _array];
