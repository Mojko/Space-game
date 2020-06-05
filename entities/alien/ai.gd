extends Entity

enum State {
	IDLE,
	MOVING,
	CHASING,
	ATTACK
}

signal hit(from);
signal shoot(direction, invulnerables);
signal death(entity);

onready var sfx_hurt = get_node("hurt");
onready var shoot_timer = get_node("shoot_timer");

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
	get_tree().call_group("spawn_listener", "alien_have_spawned", self);

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
		shoot(-look_dir.normalized());
		
		if(global_transform.origin.distance_to(target.global_transform.origin) > 9):
			move_and_slide(-look_dir.normalized() * speed);
			pass
		pass
	pass

func shoot(aim_direction):
	if(shoot_timer.is_finished() and rand_range(0, 10) <= 1):
		for weapon in alien.loadout.get_loadout():
			if(weapon.has_weapon() and shoot_timer.can_shoot()):
				emit_signal("shoot", weapon, aim_direction, [Groups.Enemy]);
		shoot_timer.start();
	
func equip_alien(var alien : Alien):
	self.alien = alien;
	self.alien.connect("death", self, "_on_alien_death");
	pass
	
func on_hit():
	alien.health -= 1;
	sfx_hurt.play();
	emit_signal("hit", self);
	if(alien.health <= 0):
		emit_signal("death", self);
		queue_free();
	
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
