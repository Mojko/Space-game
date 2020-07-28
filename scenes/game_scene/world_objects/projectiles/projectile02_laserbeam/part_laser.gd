extends CPUParticles

func start():
	emitting = true;
	$tween_shrink.interpolate_property(self, "scale:x", 1, 0.01, 0.8, Tween.TRANS_EXPO, Tween.EASE_OUT);
	$tween_shrink.start();

func _on_death_timer_timeout():
	scale.x = 0.25;
	emitting = false;