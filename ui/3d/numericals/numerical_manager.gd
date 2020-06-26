extends Node

export(PackedScene) var numerical;

func _ready():
	connect_nodes();
		
func connect_nodes():
	var damageables = get_tree().get_nodes_in_group("damageable");
	
	for damageable in damageables:
		damageable.connect("hit", self, "spawn_numerical");
		if(damageable.has_user_signal("hit_electricity")):
			damageable.connect("hit_electricity", self, "spawn_numerical");

func spawn_numerical(who):
	#var position = get_owner().camera.unproject_position(who.global_transform.origin);
	var instance = numerical.instance();
	instance.position_in_world(get_owner().camera, who.global_transform.origin);
	add_child(instance);
	