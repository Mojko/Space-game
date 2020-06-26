extends Camera

export(NodePath) var target;
var start_position : Vector3;

onready var p = get_node(target);

# Called when the node enters the scene tree for the first time.
func _ready():
	start_position = self.global_transform.origin;
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if(p != null): 
		self.global_transform.origin = start_position + p.global_transform.origin;
	elif(p == null):
		print("Camera has no target");
	pass
