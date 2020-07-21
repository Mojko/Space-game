extends Shop

func _on_shop_item_ship_noob_pressed():
	emit_signal("preview_item", shop_items[0]);

func _on_shop_item_ship_2_pressed():
	emit_signal("preview_item", shop_items[1]);