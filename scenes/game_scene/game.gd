extends Spatial

#### Pools ###
#onready var projectile01_laser_pool = get_node("pools/projectile01_laser_pool");
#onready var projectile02_electric_bolt_pool = get_node("pools/projectile02_electric_bolt_pool");
#onready var gfx_death_pool = get_node("pools/gfx_death_pool");
#onready var gfx_hit_pool = get_node("pools/gfx_hit_pool");
#onready var gfx_hit_electricity_pool = get_node("pools/gfx_hit_electricity_pool");
#onready var gfx_nuts_bolts_pool = get_node("pools/gfx_nuts_bolts_pool");

### Camera ###
export(NodePath) var camera_path : NodePath;

onready var camera : Camera = get_node(camera_path);

#####
#
# scene_data:
# Expecting what type of planet the player is coming from
#
####
func load_scene(scene_data : Dictionary):
	if(!scene_data.has("planet")):
		print("No planet found");
		return;
		
	if(scene_data.planet == null):
		print("No planet found");
		return;
		
	var planet_instance = SceneLoader.load_resource(scene_data.planet.get_path());
	add_child(planet_instance);
	
#	planet_instance.connect("spawn_electric_bolt_projectile", projectile02_electric_bolt_pool, "_on_planet_spawn_electric_bolt_projectile");
#	planet_instance.connect("spawn_gfx_death", gfx_death_pool, "_on_planet_spawn_gfx_death");
#	planet_instance.connect("spawn_gfx_hit", gfx_hit_pool, "_on_planet_spawn_gfx_hit");
#	planet_instance.connect("spawn_gfx_hit_electricity", gfx_hit_electricity_pool, "_on_planet_spawn_gfx_hit_electricity");
#	planet_instance.connect("spawn_gfx_nuts_bolts", gfx_nuts_bolts_pool, "_on_planet_spawn_gfx_nuts_bolts");
#	planet_instance.connect("spawn_laser_projectile", projectile01_laser_pool, "_on_planet_spawn_laser_projectile");
	camera.connect("raycast_shoot", planet_instance.player, "_on_raycast_shoot");
	planet_instance.player.connect("move", camera, "_on_player_move");
	planet_instance.player.connect("move", $ground, "_on_player_move");
