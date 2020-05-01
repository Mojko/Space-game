extends Control

export(NodePath) var player_path;
export(NodePath) var minimap_path;

var blip_enemy = preload("res://ui/minimap/blip_enemy.tscn");

onready var player = get_node(player_path);
onready var minimap = get_node(minimap_path);
onready var blip_player = get_node("minimap/blip_player");

func _ready():
	blip_player.attach(player);

func _on_alien_i_have_spawned(entity):
	var instance = blip_enemy.instance();
	get_node(minimap_path).add_child(instance);
	instance.attach(entity);
	instance.attach_center(player);
	instance.set_bounds(0, 0, minimap.rect_size.x, minimap.rect_size.y);
	pass
