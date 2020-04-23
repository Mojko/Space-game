extends Node

export(NodePath) var player_path;
export(Array, NodePath) var spaceship_repository_paths;

onready var player = get_node(player_path);

var spaceship_repository : Array = [];

func _ready():
	for i in spaceship_repository_paths:
		spaceship_repository.append(get_node(i));
		pass
		
	player.equip_spaceship(spaceship_repository.front());
	pass

#func _process(delta):
#	pass
