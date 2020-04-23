extends Node
class_name Alien

export(NodePath) var host_path;

signal shoot(direction, invulnerables);

onready var host = get_node(host_path);

func _ready():
	pass

#func _process(delta):
#	pass

func get_physics_body() -> KinematicBody:
	return host;

func _on_host_shoot(direction, invulnerables):
	emit_signal("shoot", direction, invulnerables);
	pass