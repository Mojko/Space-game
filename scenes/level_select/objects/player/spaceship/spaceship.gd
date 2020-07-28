extends Spatial

export(GlobalPlayerData.SpaceshipType) var spaceship_type;

func activate():
	set_process(true);
	set_physics_process(true);
	show();
	
func deactivate():
	set_process(false);
	set_physics_process(false);
	hide();