extends CPUParticles

func emit(state):
	set_emitting(state);
	if(state == true):
		get_node("OmniLight").omni_range = 2;
	else:
		get_node("OmniLight").omni_range = 0;
	pass