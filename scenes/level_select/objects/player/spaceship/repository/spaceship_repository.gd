extends Node

func _ready():
	_deactivate_all();
	
	for child in get_children():
		if(child.spaceship_type == GlobalPlayerData.current_equipped_ship):
			child.activate();

func _deactivate_all():
	for child in get_children():
		child.deactivate();