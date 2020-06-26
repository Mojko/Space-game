extends Spatial

export(NodePath) var chase_path;

onready var chase : Node = get_node(chase_path);

func _ready():
	pass
	
func _process(delta):
	if(chase == null):
		return;
	
	self.global_transform.origin = Vector3(chase.global_transform.origin.x, 0, chase.global_transform.origin.z);