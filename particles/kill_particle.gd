extends CPUParticles

signal death(instance);

func emit():
	set_emitting(true);
	$death_timer.start();

func kill():
	set_emitting(false);
	emit_signal("death", self);