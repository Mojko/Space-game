extends ObjectPool

func _ready():
	expand(25);

func player_has_spawned(player):
	player.connect("hit_electricity", self, "on_electricity_hit");
	
func on_electricity_hit(target):
	var instance = spawn_object_from_pool(target.global_transform.origin);
	instance.emit();
	instance.follow(target);
	
func expand(size):
	for i in size:
		var instance = create_instance();
		instance.connect("death", self, "add_to_pool");
		add_to_pool(instance);
	print("Expanded required, there are now ", pool.size(), " gfx_hit_electricity in pool");