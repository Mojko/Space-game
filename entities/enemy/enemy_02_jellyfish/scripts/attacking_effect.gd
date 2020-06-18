extends CPUParticles

onready var sfx_buzz = get_node("sfx_buzz");

func show():
	.show();
	sfx_buzz.play();
	
func hide():
	.hide();
	sfx_buzz.stop();