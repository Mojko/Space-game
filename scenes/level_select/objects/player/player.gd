extends KinematicBody

signal move(to_position);

func _on_spaceship_repository_equip_spaceship(spaceship):
	spaceship.activate();

func _on_planets_travel_to_planet(position):
	$smooth_travel.interpolate_property(self, "translation", global_transform.origin, position, 1, 1, Tween.EASE_OUT);
	$smooth_travel.start();
	look_at(position, Vector3.UP);