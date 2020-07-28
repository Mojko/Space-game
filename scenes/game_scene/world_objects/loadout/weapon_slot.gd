extends Spatial

export(Resource) var weapon : Resource;
export(bool) var has_weapon : bool;

signal shoot(laser_data, from, direction);

var current_laser : Resource;
var can_shoot : bool = true;

func _ready():
	if(weapon == null):
		return;
		
	self.current_laser = weapon;
	$shoot_timer.wait_time = current_laser.cooldown;
	
func shoot():
	if(!has_weapon):
		return false;
	
	if(!can_shoot):
		return false;
	
	can_shoot = false;
	$shoot_timer.start();
	emit_signal("shoot", current_laser, self, get_global_transform().basis.z);

func has_weapon() -> bool:
	return self.current_laser != null;

func _on_shoot_timer_timeout():
	can_shoot = true;