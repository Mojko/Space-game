extends Node

export(NodePath) var ai_path;
export(Array, NodePath) var alien_repository_paths;

onready var ai = get_node(ai_path);

var alien_repository : Array = [];

func _ready():
	for i in alien_repository_paths:
		alien_repository.append(get_node(i));
		pass
		
	ai.equip_alien(alien_repository.front());
	pass

#func _process(delta):
#	pass
