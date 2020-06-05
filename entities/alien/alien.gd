extends Spatial
class_name Alien

export(NodePath) var host_path;
export(PackedScene) var death_particles;

export(int, 0, 1000, 1.0) var health;

signal shoot(direction, invulnerables);
signal death();

onready var host = get_node(host_path);

func _ready():
	pass

#func _process(delta):
#	pass

func get_physics_body() -> KinematicBody:
	return host;

func _on_host_hit():
	health -= 1;
	if(health <= 0):
		get_tree().call_group("death_listener", "i_have_died", self.get_physics_body());
		var instance = death_particles.instance();
		instance.global_transform.origin = global_transform.origin;
		get_tree().get_root().add_child(instance);
		get_physics_body().queue_free();
	pass

func _on_host_shoot(direction, invulnerables):
	emit_signal("shoot", direction, invulnerables);
	pass