extends ObjectPool

func _ready():
	expand(50);

func expand(size):
	for i in size:
		var instance = create_instance();
		instance.connect("death", self, "add_to_pool");
		add_to_pool(instance);

func _on_planet_spawn_gfx_hit(me):
	var instance = spawn_object_from_pool(me.global_transform.origin);
	instance.emit();