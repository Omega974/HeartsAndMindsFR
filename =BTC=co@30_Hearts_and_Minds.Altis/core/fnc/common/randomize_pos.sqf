
/* ----------------------------------------------------------------------------
Function: btc_fnc_randomize_pos

Description:
    Fill me when you edit me !

Parameters:
    _pos - [Array]
    _random_area - [Number]
    _allowwater - [Booleen]

Returns:

Examples:
    (begin example)
        _result = [] call btc_fnc_randomize_pos;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_pos", [0, 0, 0], [[]]],
    ["_random_area", 300, [0]],
    ["_allowwater", false, [true]]
];

private _return_pos = _pos;

_check_pos = [_pos, _random_area] call CBA_fnc_randPos;

if ((surfaceIsWater _check_pos) && !(_allowwater)) then {
    _return_pos = [_check_pos, 0, _random_area, 13, false] call btc_fnc_findsafepos;
} else {
    _return_pos = _check_pos;
};
_return_pos
