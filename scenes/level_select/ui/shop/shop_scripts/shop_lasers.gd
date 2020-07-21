extends Shop

func _on_shop_item_laser_00_pressed():
	emit_signal("preview_item", shop_items[0]);