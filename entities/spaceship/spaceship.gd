extends Spatial
class_name Spaceship

export(NodePath) var physics_body_path;
export(NodePath) var fire_particles_path;

export(int, 0, 1000, 1.0) var health;
export(float, 0, 1000, 0.01) var speed;
export(Curve) var acceleration_curve;

signal shoot(direction, invulnerables);

onready var physics_body = get_node(physics_body_path);
onready var fire_particles = get_node(fire_particles_path);

func _ready():
	pass

#func _process(delta):
#	pass

func set_thrust_state(state):
	fire_particles.set_emitting(state);
	pass

func get_acceleration(var x : float) -> float:
	return acceleration_curve.interpolate(x);
	
func get_acceleration_curve() -> Curve:
	return acceleration_curve;

func get_speed() -> float:
	return speed;

func get_physics_body() -> KinematicBody:
	return physics_body;

func _on_host_shoot(direction, invulnerables):
	emit_signal("shoot", direction, invulnerables);
	pass
