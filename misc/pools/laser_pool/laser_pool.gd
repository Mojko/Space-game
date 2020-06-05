extends ObjectPool

func _ready():
	expand();

func player_has_spawned(player):
	player.connect("shoot", self, "on_entity_shoot");
	pass
	
func alien_have_spawned(entity):
	entity.connect("shoot", self, "on_entity_shoot");
	pass

func on_entity_shoot(from, direction, invulnerables):
	var instance = spawn_object_from_pool(from.global_transform.origin);
	instance.fire(direction, 1, invulnerables);
	
func expand():
	for i in 3000:
		var instance = create_instance();
		instance.connect("death", self, "add_to_pool");
		add_to_pool(instance);
	print("Expanded required, there are now ", pool.size(), " lasers in pool");