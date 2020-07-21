extends ObjectPool

func _ready():
	expand(25);
	
func expand(size):
	for i in size:
		var instance = create_instance();
		instance.connect("death", self, "add_to_pool");
		add_to_pool(instance);

func _on_planet_spawn_laserbeam_projectile(from, direction, invulnerables):
	var instance = spawn_object_from_pool(from.global_transform.origin);
	
	instance.fire(
	{
		"source": from, 
		"direction": direction, 
		"invulnerables": invulnerables
	});