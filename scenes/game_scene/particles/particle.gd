extends CPUParticles

signal death(instance);

var target;

func follow(target):
	self.target = target;

func emit():
	$death_timer.start();
	set_emitting(true);

func kill():
	$death_timer.stop();
	emit_signal("death", self);
	set_emitting(false);
	
func _process(delta):
	if(target == null):
		return;
		
	global_transform.origin = self.target.global_transform.origin