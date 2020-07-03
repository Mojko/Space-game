extends Control

onready var go_to_planet_button = get_node("go_to_planet");

var selected_planet;

func _on_planets_planet_selected(planet):
	self.selected_planet = planet;
	print("SElected a planet: ", self.selected_planet.name);

func _on_go_to_planet_pressed():
	SceneLoader.load_scene(SceneLoader.SCENE_01_GAME, 
	{
		"planet": selected_planet.planet_scene
	});