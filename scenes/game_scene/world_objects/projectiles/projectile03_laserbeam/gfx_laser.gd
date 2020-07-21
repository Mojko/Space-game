extends CPUParticles

#interpolate_property( Object object, NodePath property, 
#Variant initial_val, Variant final_val, 
#float duration, TransitionType trans_type, 
#EaseType ease_type, float delay=0 )

func start():
	$tween_shrink.interpolate_property(self, "scale:x", 1, 0.1, 1, Tween.TRANS_LINEAR, Tween.EASE_OUT);
	$tween_shrink.start();

func _on_death_timer_timeout():
	scale.x = 1;