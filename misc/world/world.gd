extends Spatial

export(Array, PackedScene) var enemy_scenes : Array = []; 
export(NodePath) var player_path : NodePath;

###### World events ######
signal spawn_laser_projectile(from, direction, invulnerables);
signal spawn_gfx_death(me);
signal spawn_gfx_hit(me);
signal spawn_gfx_hit_electricity(me);

onready var player : KinematicBody = get_node(player_path);

func _ready():
	spawn_enemies();

func spawn_enemies():
	var x = 2;
	var y = 2;
	
	for i in x:
		for j in y:
			var instance = enemy_scenes[randi() % enemy_scenes.size()].instance();
			instance.connect("shoot", self, "on_entity_shoot");
			instance.connect("hit", self, "on_entity_hit");
			instance.connect("death", self, "on_entity_death");
			add_child(instance);
			
			randomize();
			var side = randi() % 2;
			if(side == 0):
				instance.global_transform.origin = Vector3(rand_range(-64, -16), 0, rand_range(-64, -16));
			elif(side == 1):
				instance.global_transform.origin = Vector3(rand_range(64, 16), 0, rand_range(64, 16));
				
			
	print("Spawned ", (x * y), " enemies");
	
func on_entity_shoot(projectile_type, from, direction, invulnerables):
	if(projectile_type == Projectile.Type.LASER_01):
		emit_signal("spawn_laser_projectile", from, direction, invulnerables);
	
func on_entity_hit(projectile_type, me):
	emit_signal("spawn_gfx_hit", me);
	
func on_entity_death(me):
	emit_signal("spawn_gfx_death", me);

func on_entity_hit_electricity(who):
	emit_signal("spawn_gfx_hit_electricity", who);
