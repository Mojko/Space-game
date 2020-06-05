extends Control

export(NodePath) var player_path;
export(NodePath) var minimap_path;

var blip_enemy = preload("res://ui/minimap/blip_enemy.tscn");

onready var player = get_node(player_path);
onready var minimap = get_node(minimap_path);
onready var blip_player = get_node("minimap/blip_player");

var blips : Array = [];

func _ready():
	blip_player.attach(player);

func i_have_spawned(entity):
	var instance = blip_enemy.instance();
	get_node(minimap_path).add_child(instance);
	instance.attach(entity);
	instance.attach_center(player);
	instance.set_bounds(0, 0, minimap.rect_size.x, minimap.rect_size.y);
	blips.append(instance);
	pass

func i_have_died(entity):
	var index = 0;
	print(blips.size());
	for i in blips:
		if(i.get_attached_entity().name == entity.name):
			print("Freed the enemy");
			blips.remove(index);
			i.queue_free();
		index += 1;
	pass