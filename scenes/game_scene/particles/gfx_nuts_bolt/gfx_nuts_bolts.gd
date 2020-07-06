extends Spatial

export(Array, NodePath) var particles_paths;

onready var death_timer = get_node("death_timer");

signal death(object);

func emit():
	for i in particles_paths:
		get_node(i).set_emitting(true);
	death_timer.start();
	
func _on_death_timer_timeout():
	for i in particles_paths:
		get_node(i).set_emitting(false);
		
	emit_signal("death", self);
	death_timer.stop();