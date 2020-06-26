extends Spatial

export(Array, PackedScene) var enemy_scenes : Array = []; 
export(NodePath) var player_path : NodePath;

onready var player : KinematicBody = get_node(player_path);

var enemy_instances : Array = [];

func _ready():
	spawn_enemies();

func spawn_enemies():
	var x = 0;
	var y = 0;
	
	for i in x:
		for j in y:
			var instance = enemy_scenes[randi() % enemy_scenes.size()].instance();
			add_child(instance);
			
			randomize();
			var side = randi() % 2;
			if(side == 0):
				instance.global_transform.origin = Vector3(rand_range(-64, -16), 0, rand_range(-64, -16));
			elif(side == 1):
				instance.global_transform.origin = Vector3(rand_range(64, 16), 0, rand_range(64, 16));
			
			enemy_instances.append(instance);
			
	print("Spawned ", (x * y), " enemies");
	pass