extends CenterContainer

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_C:
			_toggle_visiblity();
			
func _toggle_visiblity():
	if(visible == true):
		hide();
	else:
		show();