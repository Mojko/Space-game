extends Control

export(NodePath) var camera_path;

onready var camera = get_node(camera_path);

func _process(delta):
	pass