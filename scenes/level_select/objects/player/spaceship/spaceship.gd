extends Spatial

export(SpaceshipId.Id) var spaceship_id;

func activate():
	set_process(true);
	set_physics_process(true);
	show();
	
func deactivate():
	set_process(false);
	set_physics_process(false);
	hide();