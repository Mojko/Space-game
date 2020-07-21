extends MarginContainer

export(NodePath) var ships_shop_path;
export(NodePath) var lasers_shop_path;
export(NodePath) var preview_path;

onready var ships_shop = get_node(ships_shop_path);
onready var lasers_shop = get_node(lasers_shop_path);
onready var preview = get_node(preview_path);

func _ready():
	ships_shop.open();
	
func _on_shop_category_ships_button_pressed():
	close_all();
	ships_shop.open();

func _on_shop_category_lasers_button_pressed():
	close_all();
	lasers_shop.open();

func close_all():
	ships_shop.close();
	lasers_shop.close();