extends Control

export(NodePath) var minimap_path;
export(PackedScene) var blip_enemy;

onready var minimap = get_node(minimap_path);
onready var blip_player = get_node("minimap/blip_player");

var blips : Array = [];

func player_has_spawned(player):
	blip_player.attach(player);

func alien_have_spawned(entity):
	entity.connect("death", self, "alien_have_died");
	var instance = blip_enemy.instance();
	get_node(minimap_path).add_child(instance);
	instance.attach(entity);
	instance.attach_center(blip_player.get_attachment());
	instance.set_bounds(0, 0, minimap.rect_size.x, minimap.rect_size.y);
	blips.append(instance);
	pass

func alien_have_died(entity):
	var index = 0;
	
	for i in blips:
		if(i.get_attached_entity() == null or i.get_attached_entity().name == entity.name):
			blips.remove(index);
			i.queue_free();
		index += 1;
	pass