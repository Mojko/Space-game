extends Node

export(Array, NodePath) var shop_category_buttons_paths;
export(Array, NodePath) var shop_paths;

var shop_category_buttons : Array = PathArray.to_node_array(self, shop_category_buttons_paths);
var shops : Array = PathArray.to_node_array(self, shop_paths);

func _ready():
	for shop_category_button in shop_category_buttons:
		shop_category_button.connect("pressed");

func _on_shop_category_ships_button_pressed():
	pass # Replace with function body.


func _on_shop_category_lasers_button_pressed():
	pass # Replace with function body.
