extends Spatial

var current_laser;
var can_shoot = true;

func shoot():
	if(!can_shoot):
		return false;
	
	can_shoot = false;
	$shoot_timer.start();
	
	yield($shoot_timer, "timeout");
	
	return true;

func equip_weapon(var laser):
	self.current_laser = laser;
	$shoot_timer.wait_time = laser.cooldown;
	
func has_weapon() -> bool:
	return self.current_laser != null;
	
func get_weapon_direction() -> Vector3:
	var direction = get_node("direction");
	
	if(direction == null):
		return Vector3();
	
	return direction.get_pointing_direction_normalized();

func _on_shoot_timer_timeout():
	can_shoot = true;