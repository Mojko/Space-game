extends Button

export(int) var cost;

signal preview(shop_item);

func _ready():
	connect("pressed", self, "_on_button_pressed");
	
func preview():
	emit_signal("preview", self);
	
func _on_button_pressed():
	preview();