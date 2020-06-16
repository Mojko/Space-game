extends KinematicBody

func _physics_process(delta):
	state_machine.physics_update(self);
	
func on_hit(source):
	state_machine.change_state('chasing', [source]);