extends Spatial

export(PackedScene) var enemy;

func _ready():
	var x = 1;
	var y = 1;
	
	for i in x:
		for j in y:
			var instance = enemy.instance();
			instance.global_transform.origin = Vector3(rand_range(-64, 64), 0, rand_range(-64, 64));
			add_child(instance);
	
	print("Spawned ", (x * y), " enemies");
	pass