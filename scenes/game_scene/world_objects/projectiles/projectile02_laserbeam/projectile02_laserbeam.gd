extends ProjectileEntity

func fire(laser_data, from, direction, invulnerables):
	.fire(laser_data, from, direction, invulnerables);
	
	$gfx_laser.start();
	$hitbox.disabled = false;
	look_at(global_transform.origin + direction, Vector3(0,1,0));
	
func on_body_entered(body):
	.on_body_entered(body);
	
	
func reset():
	.reset();
	$hitbox.disabled = true;