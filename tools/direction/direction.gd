tool
extends ImmediateGeometry

export(Vector3) var from : Vector3;
export(Vector3) var to : Vector3;
export(bool) var look_at : bool;

func _process(delta):
	clear()
	
	if(global_transform.origin != to and look_at):
		look_at(to, Vector3.UP);
	
	begin(Mesh.PRIMITIVE_LINES);
	
	add_vertex(from);
	add_vertex(to);
	
	#add_vertex((from - global_transform.basis.z) * 10);
	
	end();
	
func get_pointing_direction_normalized():
	return -(from - to).normalized();