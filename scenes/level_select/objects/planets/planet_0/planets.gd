extends Spatial

export(Array, NodePath) var planet_paths : Array;

signal planet_selected(planet);
signal travel_to_planet(position);

func _ready():
	for planet_path in planet_paths:
		get_node(planet_path).connect("travel_here", self, "on_planet_travel");
		
	get_node(planet_paths[0]).select();
		
func on_planet_travel(planet, position):
	emit_signal("travel_to_planet", position);
	emit_signal("planet_selected", planet);
	
	for planet_path in planet_paths:
		get_node(planet_path).deselect();
	
	planet.select();