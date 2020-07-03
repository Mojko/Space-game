extends ObjectPool

func _ready():
	expand(150);
	
func expand(size):
	for i in size:
		var instance = create_instance();
		instance.connect("death", self, "add_to_pool");
		add_to_pool(instance);
	print("Expanded required, there are now ", pool.size(), " lasers in pool");

func _on_planet_spawn_laser_projectile(from, direction, speed, invulnerables):
	var instance = spawn_object_from_pool(from.global_transform.origin);
	instance.fire(from, direction, speed, invulnerables);
