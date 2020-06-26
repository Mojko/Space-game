extends Spatial

var current_weapon : Dictionary;
	
func equip_weapon(var weapon : Dictionary):
	self.current_weapon = weapon;
	pass
	
func has_weapon() -> bool:
	return !self.current_weapon.empty();
	
func get_weapon_direction() -> Vector3:
	var direction = get_node("direction");
	
	if(direction == null):
		return Vector3();
	
	return direction.get_pointing_direction_normalized();