extends PhysicsState

var target;
var angle = 0;

func enter(data : Array):
	target = data[0];

func physics_update(parent : KinematicBody):
	var look_dir = parent.global_transform.origin - target.global_transform.origin;
	parent.move_and_slide(-look_dir.normalized() * parent.speed);
	
	parent.global_transform.origin.y += sin(angle) * 0.01;
	angle += 0.01;
	
	#PhysicsHelper.look_at_smooth(parent, look_dir, 0.2);

	if(in_range_for_attack(parent)):
		return ['attacking', target];
	
func in_range_for_attack(parent : KinematicBody):
	return parent.global_transform.origin.distance_to(target.global_transform.origin) < 12;