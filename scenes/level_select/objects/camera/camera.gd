extends Camera

export(NodePath) var stalk_path;

onready var stalk = get_node(stalk_path);
onready var start = global_transform.origin;

func _process(delta):
	global_transform.origin = start + stalk.global_transform.origin;
	
	if(Input.is_action_pressed("mouse_right")):
		
		pass