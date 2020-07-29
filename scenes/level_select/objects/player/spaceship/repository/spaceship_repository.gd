extends Node

func _ready():
	
	##This can be removed when a main menu is added
	##The reason this is needed is because the singleton
	##GlobalPlayerData will load before this object
	##And since this object is a part of the current
	##"Main" scene means that we have to manually
	##Equip the ship
	_on_spaceship_equipped(GlobalPlayerData.current_equipped_ship);
	
	GlobalPlayerData.connect("ship_equipped", self, "_on_spaceship_equipped");
	
func _deactivate_all():
	for child in get_children():
		child.deactivate();
		
func _on_spaceship_equipped(spaceship_id):
	_deactivate_all();
	
	for child in get_children():
		if(child.spaceship_id == spaceship_id):
			child.activate();