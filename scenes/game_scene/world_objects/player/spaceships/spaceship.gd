extends Spatial

signal shoot(laser_data, from, direction);

export(int, 0, 1000, 1.0) var health;
export(float, 0, 1000, 0.01) var speed;
export(Curve) var acceleration_curve;
export(Resource) var collision_shape;

onready var loadout = get_node("loadout");

func set_thrust_state(state):
	$fire_particles.emit(state);

func get_acceleration(var x : float) -> float:
	return acceleration_curve.interpolate(x);
	
func get_acceleration_curve() -> Curve:
	return acceleration_curve;

func get_speed() -> float:
	return speed;
	
func inactivate():
	set_process(false);
	set_physics_process(false);
	hide();
	
func activate():
	set_process(true);
	set_physics_process(true);
	show();
	
func get_collision_shape_copy():
	return collision_shape.instance();

func _on_loadout_shoot(laser_data, from, direction):
	emit_signal("shoot", laser_data, from, direction);
