extends PhysicsState

signal shoot(direction, invulnerables);

onready var shoot_delay = .get_node("shoot_delay");

var target;
var can_shoot : bool = true;

func enter(data : Array):
	target = data[0];

func physics_update(parent : KinematicBody):
	#var look_dir = parent.global_transform.origin - target.global_transform.origin;
	#var look_dir = -parent.global_transform.basis.z;
	var look_dir = Vector3();
	
	parent.rotate_y(0.01);
	
#	PhysicsHelper.look_at_smooth(parent, look_dir, 0.2);
	
	if(can_shoot):
		.emit_signal("shoot", -look_dir.normalized(), [Groups.Enemy]);
		shoot_delay.start();
		can_shoot = false;

#	if(parent.global_transform.origin.distance_to(target.global_transform.origin) > 9):
#		parent.move_and_slide(-look_dir.normalized() * parent.speed);

func _on_shoot_delay_timeout():
	can_shoot = true;
