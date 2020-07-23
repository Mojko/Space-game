extends Spatial

export(Array, PackedScene) var enemy_scenes : Array = [];

#### World events ####
signal spawn_laser_projectile(laser_data, from, direction, invulnerables);
signal spawn_electric_bolt_projectile(laser_data, from, direction, invulnerables);
signal spawn_laserbeam_projectile(laser_data, from, direction, invulnerables);
signal spawn_gfx_death(me);
signal spawn_gfx_hit(type, me);
signal spawn_gfx_hit_electricity(me);
signal spawn_gfx_nuts_bolts(me);

signal raycast_shoot(result);

#### Pools ####
onready var projectile01_laser_pool = get_node("pools/projectile01_laser_pool");
onready var projectile02_electric_bolt_pool = get_node("pools/projectile02_electric_bolt_pool");
onready var projectile03_laserbeam_pool = get_node("pools/projectile03_laserbeam_pool");
onready var gfx_death_pool = get_node("pools/gfx_death_pool");
onready var gfx_hit_pool = get_node("pools/gfx_hit_pool");
onready var gfx_hit_electricity_pool = get_node("pools/gfx_hit_electricity_pool");
onready var gfx_nuts_bolts_pool = get_node("pools/gfx_nuts_bolts_pool");

var enemies : Array = [];

#####
# Function: _ready()
#
# Returns: -
#
####
func _ready():
	hide_teleporter();

#####
# Function: load_into_game(game_data)
#
# This is the finishing function to load the planet into the game. This is where all
# the signals should be connected
#
# game_data contains information about different objects that the Game want to be connected
# to signals in the planet (camera, ground etc)
#
# Returns: -
#
####
func load_into_game(game_data : Dictionary):
	$player.connect("move", game_data["camera"], "_on_player_move");
	$player.connect("move", game_data["ground"], "_on_player_move");
	game_data["camera"].connect("raycast_shoot", $player, "_on_raycast_shoot");
	
	connect_spawning_signals();
	connect_player_signals();
	connect_enemy_signals();
	
#####
# Function: connect_spawning_signals()
#
# Returns: -
#
####
func connect_spawning_signals():
	self.connect("spawn_electric_bolt_projectile", projectile02_electric_bolt_pool, "_on_planet_spawn_electric_bolt_projectile");
	self.connect("spawn_gfx_death", gfx_death_pool, "_on_planet_spawn_gfx_death");
	self.connect("spawn_gfx_hit", gfx_hit_pool, "_on_planet_spawn_gfx_hit");
	self.connect("spawn_gfx_hit_electricity", gfx_hit_electricity_pool, "_on_planet_spawn_gfx_hit_electricity");
	self.connect("spawn_gfx_nuts_bolts", gfx_nuts_bolts_pool, "_on_planet_spawn_gfx_nuts_bolts");
	self.connect("spawn_laser_projectile", projectile01_laser_pool, "_on_planet_spawn_laser_projectile");
	self.connect("spawn_laserbeam_projectile", projectile03_laserbeam_pool, "_on_planet_spawn_laserbeam_projectile");

#####
# Function: connect_player_signals()
#
# Returns: -
#
####
func connect_player_signals():
	$player.connect("death", self, "on_entity_death");
	$player.connect("hit", self, "on_entity_hit");
	$player.connect("shoot", self, "on_entity_shoot");

#####
# Function: connect_enemy_signals()
#
# Returns: -
#
####
func connect_enemy_signals():
	if($enemies == null):
		print("System Node 'enemies' need to be added to scene", self.name);
	for enemy in $enemies.get_children():
		enemy.connect("death", self, "on_entity_death");
		enemy.connect("hit", self, "on_entity_hit");
		enemy.connect("shoot", self, "on_entity_shoot");

#####
# Function: check_win(last_enemy)
#
# Returns: -
#
####
func check_win(last_enemy):
	if(enemies.size() <= 0):
		show_teleporter(last_enemy.global_transform.origin);

#####
# Function: show_teleporter(location)
#
# Returns: -
#
####
func show_teleporter(location):
	$teleporter.global_transform.origin = location;

#####
# Function: hide_teleporter()
#
# Returns: -
#
####
func hide_teleporter():
	$teleporter.global_transform.origin = Vector3(999, 999, 999)

#####
# Function: on_entity_shoot(laser_data, from, direction, invulnerables)
#
# Returns: -
#
####
func on_entity_shoot(laser_data, from, direction, invulnerables):
	if(laser_data.projectile_type == Projectile.Type.LASER_01):
		emit_signal("spawn_laser_projectile", laser_data, from, direction, invulnerables);
	if(laser_data.projectile_type == Projectile.Type.ELECTRIC_BOLT_02):
		emit_signal("spawn_electric_bolt_projectile", laser_data, from, direction, invulnerables);
	if(laser_data.projectile_type == Projectile.Type.LASERBEAM_03):
		emit_signal("spawn_laserbeam_projectile", laser_data, from, direction, invulnerables);

#####
# Function: on_entity_hit(type, me)
#
# Returns: -
#
####
func on_entity_hit(type, me):
	#print(me, " got hit, hit type: ", type);
	if(type == Hit.Type.DEFAULT):
		emit_signal("spawn_gfx_hit", me);
	if(type == Hit.Type.ELECTRICITY):
		emit_signal("spawn_gfx_hit_electricity", me);
	if(type == Hit.Type.BOLTS_NUTS):
		emit_signal("spawn_gfx_nuts_bolts", me);

#####
# Function: on_entity_death(me)
#
# Returns: -
#
####
func on_entity_death(me):
	enemies.remove(enemies.find(me));
	check_win(me);
	
	emit_signal("spawn_gfx_death", me);

#####
# Function: on_entity_hit_electricity(who)
#
# Returns: -
#
####
func on_entity_hit_electricity(who):
	emit_signal("spawn_gfx_hit_electricity", who);

#####
# Function: _on_teleporter_teleport_jump()
#
# Returns: -
#
####
func _on_teleporter_teleport_jump():
	SceneLoader.load_scene(SceneLoader.SCENE_02_LEVEL_SELECT);
