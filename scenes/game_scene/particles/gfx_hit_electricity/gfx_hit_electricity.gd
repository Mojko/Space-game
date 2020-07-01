extends CPUParticles

signal death(instance);

func emit():
	$death_timer.start();

func kill():
	print("wtf?");
	emit_signal("death", self);