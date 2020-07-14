extends MarginContainer

var shops : Dictionary = {};

func _ready():
	shops["ships_shop"] = get_node("shop_horizontal_container/ships_shop");
	shops["lasers_shop"] = get_node("shop_horizontal_container/lasers_shop");

func _on_shop_category_ships_button_pressed():
	enable_shop("ships_shop");
	
func _on_shop_category_lasers_button_pressed():
	enable_shop("lasers_shop");
	
func enable_shop(var shop):
	for s in shops.values():
		s.visible = false;
	shops[shop].visible = true;
	shops[shop].init();