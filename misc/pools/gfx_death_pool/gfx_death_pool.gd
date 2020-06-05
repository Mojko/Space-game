extends ObjectPool

func _ready():
	for i in 100:
		var instance = create_instance();
		instance.connect("death", self, "add_to_pool");
		add_to_pool(instance);
		
func player_has_spawned(player):
	#Add death here
	pass
	
func alien_have_spawned(entity : Spatial):
	entity.connect("death", self, "on_entity_death");

func on_entity_death(entity : Spatial):
	var instance = spawn_object_from_pool(entity.global_transform.origin);
	instance.emit();
	
func expand():
	for i in 500:
		var instance = create_instance();
		instance.connect("death", self, "add_to_pool");
		add_to_pool(instance);
	print("Expanded required, there are now ", pool.size(), " gfx death in pool");