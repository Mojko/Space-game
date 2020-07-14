extends Node

func _ready():
	preview("shop_item_preview_ship_noob_model");
	
func preview(preview_path):
	for child in $root.get_children():
		child.visible = false;
		
	if($root.get_node(preview_path) != null):
		$root.get_node(preview_path).visible = true;

func _on_shop_item_ship_noob_pressed():
	preview("shop_item_preview_ship_noob_model");
	
func _on_shop_item_ship_2_pressed():
	preview("shop_item_preview_ship_2_model");

func _on_shop_item_laser_00_button_pressed():
	preview("");