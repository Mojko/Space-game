extends Spatial

export(PackedScene) var enemy;

func _ready():
	var x = 10;
	var y = 10;
	
	for i in x:
		for j in y:
			var instance = enemy.instance();
			instance.global_transform.origin = Vector3(rand_range(-100, 100), 0, rand_range(-100, 100));
			add_child(instance);
	
	print("Spawned ", (x * y), " enemies");
	pass