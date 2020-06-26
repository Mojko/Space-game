extends ObjectPool

func _ready():
	expand(50);

#func player_has_spawned(player):
#	player.shooting_behaviour.connect("shoot", self, "on_entity_shoot");
#
#func alien_have_spawned(alien):
#	alien.connect("spawn_projectile", self, "on_entity_shoot");

func on_entity_shoot(from, direction, invulnerables):
	var instance = spawn_object_from_pool(from.global_transform.origin);
	instance.fire(from, direction, 1, invulnerables);
	
func expand(size):
	for i in size:
		var instance = create_instance();
		instance.connect("death", self, "add_to_pool");
		add_to_pool(instance);
	print("Expanded required, there are now ", pool.size(), " lasers in pool");