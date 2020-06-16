extends Spatial
class_name Alien

export(PackedScene) var death_particles;

export(int, 0, 1000, 1.0) var health;

onready var loadout = get_node("loadout");