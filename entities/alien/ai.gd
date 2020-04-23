extends Entity

enum State {
	IDLE,
	MOVING,
	CHASING,
	ATTACK
}

signal shoot(direction, invulnerables);

var state;
var target : Entity;
var speed : float = 2;
var alien : Alien;

func _ready():
	state = State.IDLE;
	pass
	
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
		emit_signal("shoot", -look_dir.normalized(), [Groups.Enemy]);
		pass
	pass
	
func equip_alien(var alien : Alien):
	self.alien = alien;
	self.connect("shoot", self.alien, "_on_host_shoot");
	pass
	
func _on_attraction_range_body_entered(body):
	if(body.name == Strings.to_string(Strings.Type.PLAYER)):
		target = body;
		state = State.CHASING;
		
func _on_attack_range_body_entered(body):
	if(body.name == Strings.to_string(Strings.Type.PLAYER)):
		state = State.ATTACK;

func _on_attack_range_body_exited(body):
	if(body.name == Strings.to_string(Strings.Type.PLAYER)):
		state = State.CHASING;

func _on_attraction_range_body_exited(body):
	if(body.name == Strings.to_string(Strings.Type.PLAYER)):
		state = State.IDLE;

func _on_too_close_range_body_entered(body):
	if(body.is_in_group(Groups.Player)):
		pass
		#state = State.RUN_WITH_FOCUS;

func _on_too_close_range_body_exited(body):
	if(body.is_in_group(Groups.Player)):
		pass
		#state = State.RUN_WITH_FOCUS;
