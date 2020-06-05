extends ObjectPool

func _ready():
	for i in 100:
		var instance = create_instance();
		instance.connect("death", self, "add_to_pool");
		add_to_pool(instance);

func player_has_spawned(player):
	player.connect("hit", self, "on_entity_hit");
	pass
	
func alien_have_spawned(entity):
	entity.connect("hit", self, "on_entity_hit");
	pass

func on_entity_hit(target):
	var instance = spawn_object_from_pool(target.global_transform.origin);
	instance.emit();
	
func expand():
	for i in 500:
		var instance = create_instance();
		instance.connect("death", self, "add_to_pool");
		add_to_pool(instance);
	print("Expanded required, there are now ", pool.size(), " gfx hit in pool");