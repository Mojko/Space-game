extends Spatial
class_name Alien

signal shoot(laser_data, from, direction);

export(int, 0, 1000, 1.0) var health;

onready var loadout = get_node("loadout");

func _on_loadout_shoot(laser_data, from, direction):
	emit_signal("shoot", laser_data, from, direction);
