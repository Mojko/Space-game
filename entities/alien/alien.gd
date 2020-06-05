extends Spatial
class_name Alien

export(PackedScene) var death_particles;

export(int, 0, 1000, 1.0) var health;

signal shoot(direction, invulnerables);
signal death();

onready var loadout = get_node("loadout");

func _ready():
	pass

#func _process(delta):
#	pass

func _on_host_shoot(direction, invulnerables):
	emit_signal("shoot", direction, invulnerables);
	pass