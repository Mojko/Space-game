extends Spatial
class_name Spaceship

export(NodePath) var fire_particles_path;

export(int, 0, 1000, 1.0) var health;
export(float, 0, 1000, 0.01) var speed;
export(Curve) var acceleration_curve;
export(Curve) var deacceleration_curve;

signal shoot(direction, invulnerables);
signal has_shot();

onready var fire_particles = get_node("fire_particles");
onready var loadout = get_node("loadout");

func set_thrust_state(state):
	fire_particles.emit(state);
	pass

func get_acceleration(var x : float) -> float:
	return acceleration_curve.interpolate(x);
	
func get_acceleration_curve() -> Curve:
	return acceleration_curve;

func get_deacceleration_curve() -> Curve:
	return deacceleration_curve;

func get_speed() -> float:
	return speed;

func _on_host_shoot(direction, invulnerables):
	emit_signal("shoot", direction, invulnerables);
	pass
	
func _on_loadout_has_shot():
	emit_signal("has_shot");
	pass
