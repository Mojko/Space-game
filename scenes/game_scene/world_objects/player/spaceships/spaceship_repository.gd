extends Node

export(Array, NodePath) var spaceship_repository_paths;
export(NodePath) var temp_spaceship_to_equip;

signal equip_spaceship(spaceship);

var spaceship_repository : Array = [];

func _ready():
	for i in spaceship_repository_paths:
		spaceship_repository.append(get_node(i));
		get_node(i).inactivate();
		
	if(temp_spaceship_to_equip != ""):
		emit_signal("equip_spaceship", get_node(temp_spaceship_to_equip));
	else:
		emit_signal("equip_spaceship", spaceship_repository[0]);