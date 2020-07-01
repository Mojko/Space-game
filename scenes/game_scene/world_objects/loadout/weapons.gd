extends Node

enum Types {
	LF0,
}

var weapon_type_0 = {
	"name": "lf0",
	"damage": 1
};

var weapons = [];

func _ready():
	weapons.append(weapon_type_0);

func get_weapon(var type) -> Dictionary:
	return weapons[type];