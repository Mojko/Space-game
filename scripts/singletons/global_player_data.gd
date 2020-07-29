extends Node

signal ship_equipped(spaceship_id);

var current_equipped_ship;
var owned_ships = [];

func _ready():
	add_owned_ship(SpaceshipId.Id.spaceship_0_noob);
	equip_ship(SpaceshipId.Id.spaceship_0_noob);

func equip_ship(spaceship_id):
	if(!owned_ships.has(spaceship_id)):
		return;
	current_equipped_ship = spaceship_id;
	emit_signal("ship_equipped", current_equipped_ship);

func add_owned_ship(spaceship_id):
	if(owned_ships.has(spaceship_id)):
		return;
	owned_ships.append(spaceship_id);
	
func owns_ship(spaceship_id):
	if(owned_ships.has(spaceship_id)):
		return true;
	return false;
	
func has_ship_equipped(spaceship_id):
	if(current_equipped_ship == spaceship_id):
		return true;
	return false;