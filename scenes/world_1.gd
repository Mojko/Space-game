extends Spatial

export(NodePath) var minimap_path;

export(PackedScene) var death_particles;

onready var minimap = get_node(minimap_path);