extends Node

export(Array, NodePath) var spaceship_repository_paths;

signal equip_spaceship(spaceship);

var spaceship_repository : Array = [];

func _ready():
	for i in spaceship_repository_paths:
		spaceship_repository.append(get_node(i));
		get_node(i).inactivate();
		
	emit_signal("equip_spaceship", spaceship_repository[1]);