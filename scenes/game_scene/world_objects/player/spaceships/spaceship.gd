extends Spatial

signal shoot(laser_data, from, direction);

export(Resource) var spaceship_data;

onready var loadout = get_node("loadout");

func set_thrust_state(state):
	$fire_particles.emit(state);

func get_acceleration(var x : float) -> float:
	return spaceship_data.acceleration_curve.interpolate(x);
	
func get_acceleration_curve() -> Curve:
	return spaceship_data.acceleration_curve;

func get_speed() -> float:
	return spaceship_data.speed;
	
func inactivate():
	set_process(false);
	set_physics_process(false);
	hide();
	
func activate():
	set_process(true);
	set_physics_process(true);
	show();
	
func get_collision_shape_copy():
	return spaceship_data.collision_shape.instance();
	
func get_collision_shape():
	return spaceship_data.collision_shape;

func _on_loadout_shoot(laser_data, from, direction):
	emit_signal("shoot", laser_data, from, direction);
