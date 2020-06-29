extends Spatial

export(Array, PackedScene) var enemy_scenes : Array = []; 
export(NodePath) var player_path : NodePath;

###### World events ######
signal spawn_laser_projectile(from, direction, speed, invulnerables);
signal spawn_electric_bolt_projectile(from, direction, invulnerables);
signal spawn_gfx_death(me);
signal spawn_gfx_hit(me);
signal spawn_gfx_hit_electricity(me);

onready var player : KinematicBody = get_node(player_path);
onready var teleporter : Spatial = get_node("teleporter");

var enemies : Array = [];

func _ready():
	spawn_enemies();
	hide_teleporter();

func spawn_enemies():
	var x = 0;
	var y = 0;
	
	for i in x:
		for j in y:
			var instance = enemy_scenes[randi() % enemy_scenes.size()].instance();
			instance.connect("shoot", self, "on_entity_shoot");
			instance.connect("hit", self, "on_entity_hit");
			instance.connect("death", self, "on_entity_death");
			enemies.append(instance);
			add_child(instance);
			
			randomize();
			var side = randi() % 2;
			if(side == 0):
				instance.global_transform.origin = Vector3(rand_range(-64, -16), 0, rand_range(-64, -16));
			elif(side == 1):
				instance.global_transform.origin = Vector3(rand_range(64, 16), 0, rand_range(64, 16));
				
			
	print("Spawned ", (x * y), " enemies");

func check_win(last_enemy):
	if(enemies.size() <= 0):
		show_teleporter(last_enemy.global_transform.origin);

func show_teleporter(location):
	teleporter.global_transform.origin = location;

func hide_teleporter():
	teleporter.global_transform.origin = Vector3(999, 999, 999)

func on_entity_shoot(projectile_type, from, direction, speed, invulnerables):
	if(projectile_type == Projectile.Type.LASER_01):
		emit_signal("spawn_laser_projectile", from, direction, speed, invulnerables);
	if(projectile_type == Projectile.Type.ELECTRIC_BOLT_02):
		emit_signal("spawn_electric_bolt_projectile", from, direction, speed, invulnerables);
	
func on_entity_hit(projectile_type, me):
	emit_signal("spawn_gfx_hit", me);
	
func on_entity_death(me):
	enemies.remove(enemies.find(me));
	check_win(me);
	
	emit_signal("spawn_gfx_death", me);

func on_entity_hit_electricity(who):
	emit_signal("spawn_gfx_hit_electricity", who);
	
func _on_teleporter_teleport_jump():
	#Go to next stage
	pass
