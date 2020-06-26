extends ObjectPool

func _ready():
	expand(50);

func player_has_spawned(player):
	player.connect("hit", self, "on_entity_hit");
	pass
	
func alien_have_spawned(entity):
	entity.connect("hit", self, "on_entity_hit");
	pass

func on_entity_hit(target):
	var instance = spawn_object_from_pool(target.global_transform.origin);
	instance.emit();
	
func expand(size):
	for i in size:
		var instance = create_instance();
		instance.connect("death", self, "add_to_pool");
		add_to_pool(instance);