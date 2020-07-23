extends PhysicsState

signal shoot(laser_data, from, direction);

var target;

func enter(data : Array):
	target = data[0];

func physics_update(parent : KinematicBody):
	var look_dir = (parent.global_transform.origin - target.global_transform.origin).normalized();
	
	parent.rotate_y(0.01);
	
	PhysicsHelper.look_at_smooth(parent, -look_dir, 0.2);
	
	parent.spaceship.loadout.shoot();
	
func _on_spaceship_shoot(laser_data, from, direction):
	emit_signal("shoot", laser_data, from, direction);
