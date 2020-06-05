extends Timer

var can_shoot : bool = true;
var timer_active : bool = false;

func _ready():
	connect("timeout", self, "on_timeout");

func start(time_sec : float = 1):
	.start(time_sec);
	can_shoot = false;
	timer_active = true;

func on_timeout():
	can_shoot = true;
	timer_active = false;
	
func is_finished() -> bool:
	return !timer_active;
	
func can_shoot() -> bool:
	return can_shoot;