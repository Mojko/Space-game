extends Node

enum Type {
	PLAYER,
	SIZE
}

var strings = [Type.SIZE];

func _ready():
	strings[Type.PLAYER] = "player";
	pass

func to_string(var type):
	return strings[type];
	pass
