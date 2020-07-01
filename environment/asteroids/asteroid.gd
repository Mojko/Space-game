extends Spatial

var random_direction_x;
var random_direction_z;

func _ready():
	random_direction_x = choose(-1, 1);
	random_direction_z = choose(-1, 1);

func _process(delta):
	rotate_z(0.01);
	rotate_x(0.02);
	global_transform.origin.x += random_direction_x * delta;
	global_transform.origin.z += random_direction_z * delta;
	
func choose(a, b):
	if(randi() % 2 == 0):
		return a;
	else:
		return b;
