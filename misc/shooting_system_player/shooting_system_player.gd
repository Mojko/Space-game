extends Node

onready var shoot_timer : Timer = get_node("shoot_timer");

var loadout : Array;

func assign_loadout(loadout : Array) -> void:
	self.loadout = loadout;
	
func has_assigned_loadout() -> bool:
	return loadout != null;
	
func get_shootable_loadout() -> Array:
	if(!has_assigned_loadout()):
		print("Please assign loadout before using this node shooting_pattern.gd");
		return [];
	
	if(!can_shoot()):
		return [];
		
	var newArray : Array = [];
	for weapon in self.loadout:
		if(weapon.has_weapon()):
			newArray.append(weapon);
			
	return newArray;
	
func can_shoot() -> bool:
	if(shoot_timer.time_left <= 0):
		shoot_timer.start();
	
	return shoot_timer.time_left <= 0;