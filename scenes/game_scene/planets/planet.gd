extends Spatial

export(Array, PackedScene) var enemy_scenes : Array = [];

#### World events ####
signal spawn_laser_projectile(from, direction, speed, invulnerables);
signal spawn_electric_bolt_projectile(from, direction, invulnerables);
signal spawn_laserbeam_projectile(from, direction, invulnerables);
signal spawn_gfx_death(me);
signal spawn_gfx_hit(type, me);
signal spawn_gfx_hit_electricity(me);
signal spawn_gfx_nuts_bolts(me);

signal raycast_shoot(result);

#### World Objects ####
onready var teleporter : Spatial = get_node("teleporter");
onready var player : KinematicBody = get_node("player");

#### Pools ####
onready var projectile01_laser_pool = get_node("pools/projectile01_laser_pool");
onready var projectile02_electric_bolt_pool = get_node("pools/projectile02_electric_bolt_pool");
onready var projectile03_laserbeam_pool = get_node("pools/projectile03_laserbeam_pool");
onready var gfx_death_pool = get_node("pools/gfx_death_pool");
onready var gfx_hit_pool = get_node("pools/gfx_hit_pool");
onready var gfx_hit_electricity_pool = get_node("pools/gfx_hit_electricity_pool");
onready var gfx_nuts_bolts_pool = get_node("pools/gfx_nuts_bolts_pool");

var enemies : Array = [];

func _ready():
	self.connect("spawn_electric_bolt_projectile", projectile02_electric_bolt_pool, "_on_planet_spawn_electric_bolt_projectile");
	self.connect("spawn_gfx_death", gfx_death_pool, "_on_planet_spawn_gfx_death");
	self.connect("spawn_gfx_hit", gfx_hit_pool, "_on_planet_spawn_gfx_hit");
	self.connect("spawn_gfx_hit_electricity", gfx_hit_electricity_pool, "_on_planet_spawn_gfx_hit_electricity");
	self.connect("spawn_gfx_nuts_bolts", gfx_nuts_bolts_pool, "_on_planet_spawn_gfx_nuts_bolts");
	self.connect("spawn_laser_projectile", projectile01_laser_pool, "_on_planet_spawn_laser_projectile");
	self.connect("spawn_laserbeam_projectile", projectile03_laserbeam_pool, "_on_planet_spawn_laserbeam_projectile");
	hide_teleporter();

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
	if(projectile_type == Projectile.Type.LASERBEAM_03):
		emit_signal("spawn_laserbeam_projectile", from, direction, invulnerables);
	
func on_entity_hit(type, me):
	#print(me, " got hit, hit type: ", type);
	if(type == Hit.Type.DEFAULT):
		emit_signal("spawn_gfx_hit", me);
	if(type == Hit.Type.ELECTRICITY):
		emit_signal("spawn_gfx_hit_electricity", me);
	if(type == Hit.Type.BOLTS_NUTS):
		emit_signal("spawn_gfx_nuts_bolts", me);
	
func on_entity_death(me):
	enemies.remove(enemies.find(me));
	check_win(me);
	
	emit_signal("spawn_gfx_death", me);

func on_entity_hit_electricity(who):
	emit_signal("spawn_gfx_hit_electricity", who);

func _on_teleporter_teleport_jump():
	SceneLoader.load_scene(SceneLoader.SCENE_02_LEVEL_SELECT);
