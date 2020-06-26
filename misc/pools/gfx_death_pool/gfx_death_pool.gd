extends ObjectPool

func _ready():
	expand(50);
		
func player_has_spawned(player):
	#Add death here
	pass
	
func alien_have_spawned(entity : Spatial):
	entity.connect("death", self, "on_entity_death");

func on_entity_death(entity : Spatial):
	var instance = spawn_object_from_pool(entity.global_transform.origin);
	instance.emit();
	
func expand(size):
	for i in size:
		var instance = create_instance();
		instance.connect("death", self, "add_to_pool");
		add_to_pool(instance);