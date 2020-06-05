extends Spatial

export(Array, NodePath) var particles_paths;
export(NodePath) var death_sfx_path;

onready var death_sfx = get_node(death_sfx_path);

func _ready():
	for i in particles_paths:
		get_node(i).set_emitting(true);
	death_sfx.play();

func kill():
	queue_free();
	pass
