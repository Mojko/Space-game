extends Spatial
class_name Alien

signal shoot(laser_data, from, direction);
signal flash();

onready var loadout = get_node("loadout");

func _on_loadout_shoot(laser_data, from, direction):
	emit_signal("shoot", laser_data, from, direction);

func _on_enemy_hit(type, entity):
	emit_signal("flash");