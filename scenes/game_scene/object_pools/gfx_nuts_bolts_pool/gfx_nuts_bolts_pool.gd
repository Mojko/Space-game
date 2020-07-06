extends ObjectPool

func _ready():
	expand(25);

func _on_world_spawn_gfx_nuts_bolts(me):
	var instance = spawn_object_from_pool(me.global_transform.origin);
	instance.emit();
	
func expand(size):
	for i in size:
		var instance = create_instance();
		instance.connect("death", self, "add_to_pool");
		add_to_pool(instance);
	print("Expanded required, there are now ", pool.size(), " gfx_hit_electricity in pool");