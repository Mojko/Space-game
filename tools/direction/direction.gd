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
	
	for x in 4:
		for y in 4:
			for z in 4:
				var x_new = x * 0.01;
				var y_new = y * 0.01;
				var z_new = z * 0.01;
				add_vertex(Vector3(from.x + x_new, from.y + y_new, from.z + z_new));
				add_vertex(Vector3(to.x + x_new, to.y + y_new, to.z + z_new));
	
	#add_vertex((from - global_transform.basis.z) * 10);
	
	end();
	
func get_pointing_direction_normalized():
	return -(from - to).normalized();