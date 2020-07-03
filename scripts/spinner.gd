extends Spatial

export(bool) var should_spin;
export(String, "x", "y", "z") var spin_axis;
export(float, 0.001, 1) var spin_speed;

export(bool) var should_scale;

var a : float = 0;

func _process(delta):
	if(should_spin):
		if(spin_axis == "x"):
			self.rotate_x(spin_speed);
		if(spin_axis == "y"):
			self.rotate_y(spin_speed);
		if(spin_axis == "z"):
			self.rotate_z(spin_speed);
	
	if(should_scale):
		a += 0.1;
		scale = Vector3(sin(a), sin(a), 1);
		return;