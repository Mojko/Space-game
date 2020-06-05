extends Entity

enum State {
	IDLE,
	MOVING,
	CHASING,
	ATTACK
}

export(NodePath) var sfx_hurt_path;

signal shoot(direction, invulnerables);
signal hit();

onready var sfx_hurt = get_node(sfx_hurt_path);

var state = State.ATTACK;
var target : Entity;
var speed : float = 2;
var alien : Alien;

enum TargetRangeType {
	CHASING,
	ATTACK
}

func _ready():
	target = get_parent().get_parent().get_node("player");
	get_tree().call_group("spawn_listener", "i_have_spawned", self);

func _process(delta):
	match state:
		State.IDLE:
			handle_idle();
		State.MOVING:
			handle_moving();
		State.CHASING:
			handle_chasing();
		State.ATTACK:
			handle_attacking();
	pass
	
func handle_idle():
	self.target = get_target_by(TargetRangeType.ATTACK);
	pass
	
func handle_moving():
	#Move to a random location
	pass

func handle_chasing():
	if(target != null):
		var look_dir = global_transform.origin - target.global_transform.origin;
		move_and_slide(-look_dir.normalized() * speed);
		look_at_smooth(look_dir, 0.2);
		pass
	pass

func handle_attacking():
	if(target != null):
		var look_dir = global_transform.origin - target.global_transform.origin;
		look_at_smooth(look_dir, 0.2);
		#emit_signal("shoot", -look_dir.normalized(), [Groups.Enemy]);
		
		if(global_transform.origin.distance_to(target.global_transform.origin) > 9):
			move_and_slide(-look_dir.normalized() * speed);
			pass
		pass
	pass
	
func equip_alien(var alien : Alien):
	self.alien = alien;
	self.connect("shoot", self.alien, "_on_host_shoot");
	self.connect("hit", self.alien, "_on_host_hit");
	self.alien.connect("death", self, "_on_alien_death");
	pass
	
func on_hit():
	sfx_hurt.play();
	emit_signal("hit");
	pass
	
func in_attack_range(var object : Spatial) -> bool:
	return object.global_transform.origin.distance_to(self.global_transform.origin) < 4;

func get_target_by(var type) -> Spatial:
	var targets = get_tree().get_nodes_in_group("friendly");
	
	for target in targets:
		match type:
			TargetRangeType.ATTACK:
				if(in_attack_range(target)): 
					return target;
		pass
	return null;
	

#func _on_attraction_range_body_entered(body):
#	if(body.name == Strings.to_string(Strings.Type.PLAYER)):
#		target = body;
#		state = State.CHASING;
#
#func _on_attack_range_body_entered(body):
#	if(body.name == Strings.to_string(Strings.Type.PLAYER)):
#		print("wew");
#		state = State.ATTACK;
#
#func _on_attack_range_body_exited(body):
#	if(body.name == Strings.to_string(Strings.Type.PLAYER)):
#		state = State.CHASING;
#
#func _on_attraction_range_body_exited(body):
#	if(body.name == Strings.to_string(Strings.Type.PLAYER)):
#		state = State.IDLE;
#
#func _on_too_close_range_body_entered(body):
#	if(body.is_in_group(Groups.Player)):
#		pass
#		#state = State.RUN_WITH_FOCUS;
#
#func _on_too_close_range_body_exited(body):
#	if(body.is_in_group(Groups.Player)):
#		pass
#		#state = State.RUN_WITH_FOCUS;
