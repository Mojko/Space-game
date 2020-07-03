extends Spatial

signal planet_selected(planet);
signal travel_to_planet(position);

func _ready():
	for planet in get_children():
		planet.connect("travel_here", self, "_on_planet_travel");
		planet.connect("select", self, "_on_planet_select");
		
	get_child(0).select();
		
func _on_planet_travel(planet, position):
	emit_signal("travel_to_planet", position);
	
	for planet in get_children():
		planet.deselect();
		
func _on_planet_select(planet):
	emit_signal("planet_selected", planet);