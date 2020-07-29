extends Node

signal equip_spaceship(spaceship);

func _ready():
	for child in get_children():
		child.inactivate();
		if(child.spaceship_data.spaceship_id == GlobalPlayerData.current_equipped_ship):
			emit_signal("equip_spaceship", child);
			print("wew");