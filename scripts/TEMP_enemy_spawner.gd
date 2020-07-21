extends Spatial

export(PackedScene) var enemy;

func _ready():
	var x = 4;
	var y = 4;
	
	for i in x:
		for j in y:
			var instance = enemy.instance();
			add_child(instance);
			
			randomize();
			var side = randi() % 2;
			if(side == 0):
				instance.global_transform.origin = Vector3(rand_range(-64, -16), 0, rand_range(-64, -16));
			elif(side == 1):
				instance.global_transform.origin = Vector3(rand_range(64, 16), 0, rand_range(64, 16));
			
			get_parent().add_enemy(instance);
			
			#instance.global_transform.origin = Vector3(rand_range(-64, 64), 0, rand_range(-64, 64));
	
	print("Spawned ", (x * y), " enemies");
	pass