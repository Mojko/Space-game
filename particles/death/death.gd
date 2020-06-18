extends Spatial

export(Array, NodePath) var particles_paths;
export(NodePath) var death_sfx_path;

onready var death_sfx = get_node(death_sfx_path);
onready var death_timer = get_node("death_timer");

signal death(object);

func emit():
	for i in particles_paths:
		get_node(i).set_emitting(true);
	death_sfx.play();
	death_timer.start();

func kill():
	for i in particles_paths:
		get_node(i).set_emitting(false);
		
	emit_signal("death", self);
	death_timer.stop();