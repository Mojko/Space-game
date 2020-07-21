extends ScrollContainer
class_name Shop

signal preview_item(item);

export(Array, Resource) var shop_items;

func open():
	visible = true;
	set_process(true);
	_on_shop_open();

func close():
	visible = false;
	set_process(false);
	
func _on_shop_open():
	if(shop_items.size() > 0):
		emit_signal("preview_item", shop_items[0]);