extends ProjectileEntity

func fire(laser_data, from, direction, invulnerables):
	.fire(laser_data, from, direction, invulnerables);
	
	var new_direction : Vector3 = self.global_transform.origin - fire_direction;
	look_at(Vector3(new_direction.x, 0, new_direction.z), Vector3.UP);
	self.rotation.x = 0;
	self.rotation.z = 0;
	
func _process(delta):
	if(is_firing):
		self.global_transform.origin += laser_data.speed * fire_direction * (delta * 50);
		
func on_body_entered(body):
	if(.on_body_entered(body)):
		die();