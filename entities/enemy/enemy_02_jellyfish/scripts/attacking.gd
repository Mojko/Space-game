extends PhysicsState

signal shoot(direction, invulnerables);

onready var shoot_delay = .get_node("shoot_delay");
onready var attacking_effect = .get_owner().get_node("electrical_shield");

var target;
var can_shoot : bool = true;

func enter(data : Array):
	target = data[0];
	attacking_effect.show();
	
func exit():
	attacking_effect.hide();

func physics_update(parent : KinematicBody):
	var look_dir = parent.global_transform.origin - target.global_transform.origin;
	PhysicsHelper.look_at_smooth(parent, look_dir, 0.2);
	
	if(can_shoot and in_range_for_attack(parent)):
		target.hit_electricity(.get_owner());
		#.emit_signal("shoot", -look_dir.normalized(), [Groups.Enemy]);
		shoot_delay.start();
		can_shoot = false;

	if(parent.global_transform.origin.distance_to(target.global_transform.origin) > 2):
		parent.move_and_slide(-look_dir.normalized() * parent.speed);
		
	if(in_range_for_chase(parent)):
		return ['chasing', target];

func _on_shoot_delay_timeout():
	can_shoot = true;
	
func in_range_for_chase(parent : KinematicBody):
	return parent.global_transform.origin.distance_to(target.global_transform.origin) > 12;
	
func in_range_for_attack(parent : KinematicBody):
	return parent.global_transform.origin.distance_to(target.global_transform.origin) < 10;
